library(ordinal)
library(logisticPCA)
library(dplyr)
##Response: 
## Y1 = overall FGC future (continueFgc) 
## Y2 = daughter's future fgc status (daughterToFgc)
numchange <- function(x){
  ifelse(x=="Yes",1,0)
}

daufuture <- function(x){
  if(x=="Yes"){return(2)}
  if(x=="Don't know"){return(1)}
  if(x=="No"){return(0)}
}

contfgc <- function(x){
  if(x=="Continued"){return(2)}
  if(x=="Depends"){return(1)}
  if(x=="Discontinued"){return(0)}
}

df <- (Answers 
	%>% select(c(
		continueFgc,daughterToFgc,fgc,clusterId,
      beneHygiene,beneAcceptance,beneMarriage,
      benePreventPreSex,benePleasureM,beneReligion,
      beneRedPromis,beneRedSTD,beneOther
	))
	%>% filter(complete.cases(.))
)

beneNames <- grepl("bene", names(df))
fgcDat <- df %>% select(c(continueFgc,daughterToFgc,fgc))
covsDat <- df %>% select(clusterId)
beneDat <- df[beneNames] 
beneDat2 <- beneDat %>% rowwise() %>% summarise_each(funs(numchange))

logPCA <- logisticPCA(beneDat2,k=1,m=6)

logPCA2 <- logisticPCA(beneDat2,k=2,m=6)
PCAscores2 <- logPCA2$PCs



fgcDat <- (fgcDat
	%>% rowwise() %>% 
	transmute(continueFgc = contfgc(continueFgc),
  	daughterToFgc = daufuture(daughterToFgc),
  	fgc = numchange(fgc))
)
fgcDat <- sapply(fgcDat,as.factor)

beneDat <- beneDat %>% rowwise() %>% summarise_each(funs(numchange))

belief_score <- factanal(beneDat,factors=1,scores="regression")$score

combinedDat <- data.frame(fgcDat, beneScore=belief_score[,1],covsDat, 
                          P1=logPCA$PCs,
                          PC1 = PCAscores2[,1],PC2 = PCAscores2[,2])

daughtermod <- clmm(daughterToFgc~fgc+beneScore+ (1|clusterId),
                     data=combinedDat)
summary(daughtermod)

daughtermodP1 <- update(daughtermod,.~fgc+P1+(1|clusterId))
summary(daughtermodP1)

daughtermodPC <- update(daughtermod,.~fgc+PC1+PC2+(1|clusterId))
summary(daughtermodPC)


contmod <- clmm2(continueFgc~fgc+beneScore,
                 random = clusterId,
                 Hess = TRUE,
                 data=combinedDat)
summary(contmod)

# rdsave(combinedDat)


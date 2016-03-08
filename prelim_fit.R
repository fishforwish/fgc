library(ordinal)
library(dplyr)
##Response: 
## Y1 = overall FGC future (continueFgc) 
## Y2 = daughter's future fgc status (daughterToFgc)
numchange <- function(x){
  ifelse(x=="Yes",1,0)
}

numchange2 <- function(x){
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

fgcDat <- (fgcDat
	%>% rowwise() %>% 
	transmute(continueFgc = numchange2(continueFgc),
  	daughterToFgc = numchange(daughterToFgc),
  	fgc = numchange(fgc))
)
fgcDat <- sapply(fgcDat,as.factor)

beneDat <- beneDat %>% rowwise() %>% summarise_each(funs(numchange))

belief_score <- factanal(beneDat,factors=1,scores="regression")$score

combinedDat <- data.frame(fgcDat, beneScore=belief_score[,1],covsDat)

daughtermod <- clmm2(daughterToFgc~fgc+beneScore,
                     random = clusterId,
                     Hess = TRUE,
                     data=combinedDat)
summary(daughtermod)

contmod <- clmm2(continueFgc~fgc+beneScore,
                 random = clusterID,
                 Hess = TRUE,
                 data=combinedDat)
summary(contmod)

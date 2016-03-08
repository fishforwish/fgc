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
		continueFgc,daughterToFgc,fgc,
      beneHygiene,beneAcceptance,beneMarriage,
      benePreventPreSex,benePleasureM,beneReligion,
      beneRedPromis,beneRedSTD,beneOther
	))
	%>% filter(complete.cases(.))
)

beneNames <- grepl("bene", names(df))
fgcDat <- df[!beneNames]
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

combinedDat <- data.frame(fgcDat, beneScore=belief_score[,1])

daughtermod <- clm2(daughterToFgc~fgc+beneScore,data=combinedDat)
summary(daughtermod)

contmod <- clm2(continueFgc~fgc+beneScore,data=combinedDat)
summary(contmod)

fullmod <- clm2(
	continueFgc:daughterToFgc~fgc+beneScore,data=combinedDat
)
summary(fullmod)

##aa <- princomp(beneDat,scores=TRUE)

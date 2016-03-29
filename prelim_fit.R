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

df <- Answers %>% select(c(continueFgc,daughterToFgc,fgc,clusterId,
                           beneHygiene,beneAcceptance,beneMarriage,
                           benePreventPreSex,benePleasureM,beneReligion,
                           beneRedPromis,beneRedSTD,beneOther))

beneNames <- grepl("bene", names(df))
fgcDat <- df %>% select(c(continueFgc,daughterToFgc,fgc))
covsDat <- df %>% select(clusterId)
beneDat <- df[beneNames] 
beneDat2 <- beneDat %>% rowwise() %>% summarise_each(funs(numchange)) %>% 
  rowwise() %>% mutate(benemean = mean(c(beneHygiene,beneAcceptance,beneMarriage,
                       benePreventPreSex,benePleasureM,beneReligion,
                       beneRedPromis,beneRedSTD,beneOther),na.rm=TRUE))

fgcDat <- (fgcDat
	%>% rowwise() %>% 
	transmute(continueFgc = contfgc(continueFgc),
  	daughterToFgc = daufuture(daughterToFgc),
  	fgc = numchange(fgc))
)
fgcDat <- sapply(fgcDat,as.factor)

combinedDat <- data.frame(fgcDat, beneScore=belief_score[,1],covsDat, 
                          benesum=beneDat2$benesum, country="ke")

# rdsave(combinedDat)


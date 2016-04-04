##df for mcmcglmm fit

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

scoring <- function(dat, type){
  typeNames <- grepl(type, names(Answers))
  cols <- sum(typeNames)
  tempdat <- dat[typeNames] %>% 
    rowwise() %>%
    summarise_each(funs(numchange)) %>%
    transmute(total = rowMeans(.[1:cols],na.rm=TRUE)) %>%
    ungroup() %>%
    transmute(Score=total/mean(total,na.rm=TRUE))
  colnames(tempdat) <- paste(type,"score",sep=".")
  return(tempdat)
}

Answers <- Answers %>% mutate(id=row.names(.))
benescore <- scoring(Answers,"bene")
attscore <- scoring(Answers,"att")
Answers <- cbind(Answers,benescore,attscore)

combinedDatID <- Answers %>%  
  select(c(continueFgc,daughterToFgc,fgc,clusterId,bene.score,att.score,clusterId,age,
           edu,wealth,ethni,religion,maritalStat,job,urRural,mediaNpmg,
           mediaRadio,mediaTv,CC)) %>%
  filter(complete.cases(.)) %>%
  rowwise() %>% 
  mutate(futurefgc = contfgc(continueFgc)
         , futurefgcDau = daufuture(daughterToFgc)
         , fgcstatusMom = numchange(fgc)) %>% 
  select(-c(continueFgc,daughterToFgc,fgc)) %>% 
  ungroup() %>% 
  group_by(clusterId) %>% 
  mutate(Gbenescore = mean(bene.score),
         Gattscore = mean(att.score))

# rdsave(combinedDatID)



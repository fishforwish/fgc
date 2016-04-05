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

scoring <- function(dat, type, colnam,idvec=NULL){
  if(!is.null(idvec)) dat <- dat %>% filter(id %in% idvec)
  typeNames <- grepl(type, names(Answers))
  cols <- sum(typeNames)
  tempdat <- dat[typeNames] %>% 
    rowwise() %>%
    summarise_each(funs(numchange)) %>%
    transmute(total = rowMeans(.[1:cols],na.rm=TRUE)) %>%
    ungroup() %>%
    transmute(Score=total/mean(total,na.rm=TRUE))
  colnames(tempdat) <- paste(colnam,"score",sep=".")
  tempdat <- tempdat %>% mutate(id=idvec)
  return(tempdat)
}

Answers <- Answers %>% mutate(id=1:nrow(.))
# benescore <- scoring(Answers,"bene","B")
# attscore <- scoring(Answers,"att","A")
# Answers <- cbind(Answers,benescore,attscore)

filterDat <- Answers %>%  
  select(c(continueFgc,daughterToFgc,fgc,clusterId,clusterId,age,id,
           edu,wealth,ethni,religion,maritalStat,job,urRural,mediaNpmg,
           mediaRadio,mediaTv,CC)) %>%
  filter(complete.cases(.)) %>%
  ungroup()

benescore <- scoring(Answers,"bene","B",filterDat$id)
attscore <- scoring(Answers,"att","A",filterDat$id)
combinedDat <- filterDat %>% 
  left_join(.,benescore,by="id") %>%
  left_join(.,attscore,by="id")

combinedDat <- combinedDat %>%
  rowwise() %>% 
  mutate(futurefgc = contfgc(continueFgc)
         , futurefgcDau = daufuture(daughterToFgc)
         , fgcstatusMom = numchange(fgc)) %>% 
  select(-c(continueFgc,daughterToFgc,fgc)) %>%
  ungroup() %>%
  group_by(clusterId) %>% 
  mutate(Gbenescore = mean(B.score),
         Gattscore = mean(A.score))

# rdsave(combinedDat)



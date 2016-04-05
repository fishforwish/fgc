##df for mcmcglmm fit

library(dplyr)
##Response: 
## Y1 = overall FGC future (continueFgc) 
## Y2 = daughter's future fgc status (daughterToFgc)

yesnodk <- function(x){
  y <- as.numeric(factor(x,levels(x)[c(1,3,2)]))-1
  return(y)
}

contfgc <- function(x){
  y <- as.numeric(factor(x,levels(x)[c(3,1,2)]))-1
  return(y)
}

rightfactor <- function(x){
  y <- as.numeric(x)-1
  return(y)
}

scoring <- function(dat, type,funct,colnam,idvec=NULL){
  if(!is.null(idvec))(dat <- dat %>% filter(id %in% idvec))
  if(is.null(idvec)) idvec <- 1:nrow(dat)
  typeNames <- grepl(type, names(Answers))
  cols <- sum(typeNames)
  tempdat <- dat[typeNames] %>% 
    rowwise() %>% 
    summarise_each(funs(funct)) %>%
    mutate(id=idvec
           , numNA = rowSums(is.na(.[,1:cols]))) %>% 
    filter(numNA != cols) %>% 
    transmute(total = rowMeans(.[,1:cols],na.rm=TRUE)
              , id=id) %>%
    ungroup() %>%
    mutate(Score=total/mean(total,na.rm=TRUE)) %>% 
    select(-total)
  colnames(tempdat) <- c("id",paste(colnam,"score",sep="."))
  return(tempdat)
}

Answers <- Answers %>% mutate(id=1:nrow(.))
responseDat <- Answers %>%  
  select(c(continueFgc,daughterToFgc,id)) %>%
  mutate(futurefgc = contfgc(continueFgc),
         futurefgcDau = yesnodk(daughterToFgc)) %>%
  select(-c(continueFgc,daughterToFgc)) %>% 
  filter(complete.cases(.))
  
covDat <- Answers %>% 
  select(c(fgc,clusterId,age,id,edu,wealth,ethni,religion,maritalStat,
           job,urRural,CC)) %>% 
  mutate(fgcstatusMom = rightfactor(fgc)) %>% 
  select(-fgc)

benescore <- scoring(Answers,"bene",rightfactor,"B",responseDat$id)

attscore <- scoring(Answers,"att",yesnodk,"A",responseDat$id)
mediascore <- scoring(Answers, "media",rightfactor,"M",responseDat$id)
combinedDat <- responseDat %>% 
  left_join(., covDat, by="id") %>%
  left_join(.,benescore,by="id") %>%
  left_join(.,attscore,by="id") %>%
  left_join(.,mediascore, by= "id")

combinedDat <- combinedDat %>%
  group_by(clusterId) %>% 
  mutate(Gbenescore = mean(B.score,na.rm=TRUE),
         Gattscore = mean(A.score,na.rm=TRUE),
         Gmediascore= mean(M.score,na.rm=TRUE))

# rdsave(combinedDat)
## need JD's help, brute force atm

summary(combinedDat)

saveRDS(combinedDat,file=paste(combinedDat$CC[1],"df.RDS",sep="."))


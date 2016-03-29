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

Answers <- Answers %>% mutate(id=row.names(.))
scores <- scores %>% 
  mutate(id=row.names(.),beneScore=PC1) %>%
  select(c(beneScore,id))
  

combinedDatID <- left_join(Answers,scores,by="id") %>% 
  select(c(continueFgc,daughterToFgc,fgc,clusterId,beneScore,clusterId)) %>%
  filter(complete.cases(.)) %>%
  rowwise() %>% 
  mutate(futurefgc = contfgc(continueFgc)
         , futurefgcDau = daufuture(daughterToFgc)
         , fgcstatusMom = numchange(fgc)) %>% 
  select(-c(continueFgc,daughterToFgc,fgc)) %>% 
  ungroup() %>% 
  group_by(clusterId) %>% 
  mutate(Gscore = mean(beneScore))





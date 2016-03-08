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
  %>% select(c(continueFgc,daughterToFgc,fgc,
      beneHygiene,beneAcceptance,beneMarriage,
      benePreventPreSex,benePleasureM,beneReligion,
      beneRedPromis,beneRedSTD,beneOther))
    %>% filter(complete.cases(.))
)

catList <- grepl("bene", names(df))
dat <- df[!catList]
dat <- (dat %>% rowwise() %>% 
  transmute(continueFgc = numchange2(continueFgc),
            daughterToFgc = numchange(daughterToFgc),
            fgc = numchange(fgc))
)
dat2 <- sapply(dat,as.factor)
qual <- df[catList] %>% rowwise() %>% summarise_each(funs(numchange))

belief_score <- factanal(qual,factors=1,scores="regression")$score

dat3 <- data.frame(dat2,belief_score)
daughtermod <- clm2(daughterToFgc~fgc+Factor1,data=dat3)
contmod <- clm2(continueFgc~fgc+Factor1,data=dat3)

fullmod <- clm2(continueFgc:daughterToFgc~fgc+Factor1,data=dat3)
summary(fullmod)

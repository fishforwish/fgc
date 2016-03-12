##lme4 
library(lme4)
library(reshape2)
library(dplyr)

lumpMaybe <- function(x){
  ifelse(x=="0",0,1)
}

lumpedDat <- combinedDat %>% 
  mutate(continueFgc = as.factor(lumpMaybe(continueFgc)),
    daughterToFgc = as.factor(lumpMaybe(daughterToFgc)))

lumpedID <- data.frame(id= 1:nrow(lumpedDat),lumpedDat)

mlumpedDatID <- melt(lumpedID,id=c("id","fgc","beneScore","clusterId"))

mlumpedDatID <- (mlumpedDatID %>% 
                     mutate(value = as.factor(value)
                            , futurefgc = variable
                            #         , id = as.factor(id)
                     )
                   %>% select(-variable)
)

str(mlumpedDatID)

mod <- glmer(value~futurefgc:(fgc+beneScore) -1 + 
               (futurefgc|clusterId) ## + 
               ##  (futurefgc|id)
             ,
            data = subset(mlumpedDatID,beneScore<4),
            family = "binomial",
            control=glmerControl(optimizer="nloptwrap"),
            verbose=TRUE
            #control = lmerControl(check.nobs.vs.nRE="ignore")
            )

library("ggplot2")
ggplot(mlumpedDatID,aes(x=beneScore,y=as.numeric(as.character(value)),
                        colour=factor(fgc)))+
  geom_point()+geom_smooth(aes(group=fgc),method="gam",
                           method.args=list(family="binomial"))+
  facet_wrap(~futurefgc)
with(mlumpedDatID,plot(fgc,value))
with(combinedDat,table(daughterToFgc,continueFgc))

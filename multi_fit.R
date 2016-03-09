library(dplyr)
library(tidyr)
library(reshape2)
library(ordinal)


dat <- data.frame(id= 1:nrow(combinedDat),combinedDat)

aa <- melt(dat,id=c("id","fgc","beneScore","clusterId"))

dat2 <- aa %>% mutate(id = as.factor(id),
                      value = as.factor(value))

str(dat2)

fullmod <- clmm(value~variable+fgc+beneScore+(1|clusterId)+(1|clusterId:id),
               data = dat2)


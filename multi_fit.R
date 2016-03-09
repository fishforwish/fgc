library(dplyr)
library(tidyr)
library(reshape2)
library(ordinal)


dat <- data.frame(obs= 1:nrow(combinedDat),combinedDat)

aa <- melt(dat,id=c("obs","fgc","beneScore","clusterId"))

dat2 <- aa %>% mutate(value = as.factor(value))

str(dat2)

fullmod <- clmm(value~variable+fgc+beneScore+ (0+variable|clusterId),
               data = dat2)


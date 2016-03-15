library(dplyr)
library(tidyr)
library(reshape2)
library(ordinal)

combinedDat <- combinedDat %>% select(c(continueFgc,daughterToFgc,fgc,
                                        beneScore,clusterId))

combinedDatID <- data.frame(id= 1:nrow(combinedDat),combinedDat)

mcombinedDatID <- melt(combinedDatID,id=c("id","fgc","beneScore","clusterId"))

mcombinedDatID <- (mcombinedDatID %>% 
  mutate(value = as.factor(value)
         , futurefgc = variable
#         , id = as.factor(id)
  )
    %>% select(-variable)
)

str(mcombinedDatID)

fullmod <- clmm(value~fgc+beneScore + (0+futurefgc|clusterId),
                  data = mcombinedDatID)

summary(fullmod)

fullmod2 <- clmm(value~futurefgc+fgc+beneScore + (0+futurefgc|clusterId),
                data = mcombinedDatID)

summary(fullmod2)

summary(fullmod2)


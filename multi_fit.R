library(dplyr)
library(tidyr)
library(reshape2)
library(ordinal)


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

fullmod2 <- clmm(value~futurefgc+fgc+beneScore -1 + (futurefgc|clusterId),
               data = mcombinedDatID)


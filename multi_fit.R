library(dplyr)
library(tidyr)
library(reshape2)
library(ordinal)

combinedDat <- combinedDat %>% select(
	c(continueFgc,daughterToFgc,fgc, beneScore,clusterId)
)

combinedDatID <- data.frame(id= 1:nrow(combinedDat),combinedDat)

mcombinedDatID <- melt(combinedDatID,id=c("id","fgc","beneScore","clusterId"))

mcombinedDatID <- (mcombinedDatID %>% 
  mutate(futurefgc = as.factor(value)
         , respType = variable
			, fgcStatusMom = fgc
  )
    %>% select(-c(variable, value, fgc))
)

str(mcombinedDatID)

fullmod <- clmm(futurefgc~
		respType*(fgcStatusMom+beneScore)
		+ (0+respType|clusterId)
	, data = mcombinedDatID
)

summary(fullmod)


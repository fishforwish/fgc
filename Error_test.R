library(ordinal)
library(dplyr)

load(".ml5.futurefgcDau.RData")

aa <- combinedDat$clusterId
table(aa)

dat <- combinedDat %>% filter(clusterId %in% c("ML5_1","ML5_98","ML5_117","ML5_125"))
## 1 has 2 people
## 98 has 16, 117 has 16, 125 has 15
dat2 <- c(combinedDat %>% filter(clusterId %in% c("ML5_98","ML5_117","ML5_125"))
%>% filter(ethni != "ML_Sarkol<e9>/Sonink<e9>/Marka"))

fullmod <- clmm(futurefgcDau~
  ethni+(1|clusterId)
   ,data=dat2
)

summary(fullmod)

ML_Bamhara,ML_Sonrai
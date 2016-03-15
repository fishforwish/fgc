library(MCMCglmm)

combinedDatID <- data.frame(id=1:(nrow(combinedDat)),combinedDat)

MCMCmod <- MCMCglmm(cbind(as.factor(continueFgc),as.factor(daughterToFgc))~trait-1+fgc+beneScore,
                random=~us(trait):clusterId,
                rcov=~us(trait):id,
                data=combinedDatID,
                family=c("ordinal","ordinal"))

summary(MCMCmod)

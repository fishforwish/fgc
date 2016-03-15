library(MCMCglmm)

dat <- data.frame(id=1:(nrow(combinedDat)),combinedDat)

mod <- MCMCglmm(cbind(as.factor(continueFgc),as.factor(daughterToFgc))~trait-1+fgc+beneScore,
                random=~us(trait):clusterId,
                rcov=~us(trait):id,
                data=dat,
                family=c("ordinal","ordinal"))

library(MCMCglmm)

combinedDatID <- data.frame(id=1:(nrow(combinedDat)),combinedDat)

prior.c <- list(R=list(list(V=diag(2),n=2)),
                G=list(list(V=diag(2)/3,n=2)))

MCMCmod <- MCMCglmm(cbind(as.factor(continueFgc),as.factor(daughterToFgc))~trait-1+fgc+beneScore,
                random=~us(trait):clusterId,
                rcov=~us(trait):id,
                prior=prior.c,
                data=combinedDatID,
                family=c("ordinal","ordinal"))



summary(MCMCmod)

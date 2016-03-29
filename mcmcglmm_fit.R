library(MCMCglmm)

combinedDatID <- data.frame(id=1:(nrow(combinedDat)),combinedDat)

prior.c <- list(R=list(list(V=diag(2),nu=5)),
                G=list(list(V=diag(2),nu=5)))

MCMCmod <- MCMCglmm(cbind(as.factor(futurefgc),as.factor(futurefgcDau))~trait-1+fgc+benemean,
                random=~us(trait):clusterId,
                rcov=~us(trait):units,
                prior=prior.c,
                nitt = 30000,
                data=combinedDatID,
                family=c("ordinal","ordinal"))



summary(MCMCmod)

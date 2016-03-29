library(MCMCglmm)


prior.c <- list(R=list(list(V=diag(2),nu=5)),
                G=list(list(V=diag(2),nu=5)))

MCMCmod <- MCMCglmm(cbind(as.factor(futurefgc),as.factor(futurefgcDau))~
                      trait+fgcstatusMom+beneScore+Gscore-1,
                random=~us(trait):clusterId,
                rcov=~us(trait):units,
                prior=prior.c,
                nitt = 30000,
                data=combinedDatID,
                verbose=FALSE,
                family=c("ordinal","ordinal"))



summary(MCMCmod)

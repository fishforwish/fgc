library(MCMCglmm)
nitt <- 50000
for (r in grep("Rds$", input_files, value=TRUE)){
  if (exists("dat"))
    dat <- rbind(dat, readRDS(r))
  else
    dat <- readRDS(r)
}


set.seed(101)
prior.ind <- list(R=list(list(V=diag(1),nu=10)),
                  G=list(list(Vcomm=diag(1),nu=10)
                         , list(Veth=diag(1),nu=10)
                         , list(VCC=diag(1),nu=10)
                         , list(VCCB=diag(1),nu=10)
                         , list(VCCA=diag(1),nu=10)
                         , list(VCCM=diag(1),nu=10)
#                          , list(VCCAGE=diag(4),nu=10)
#                          , list(VCCW=diag(4),nu=10)
                  ))
print(summary(dat))

futurefgcDau_ind <- MCMCglmm(
  as.factor(futurefgcDau) ~fgcstatusMom 
  + futurefgc 
  + bene + media + att + edu
  + spl(age, 4) + spl(wealth, 4)
  + maritalStat + job + urRural + religion
  , random=~clusterId + ethni + CC 
  + bene:CC + att:CC + media:CC 
  , rcov=~units
  , prior=prior.ind
  , nitt = nitt
  , data=dat
  , verbose=FALSE
  , family="ordinal"
)

print(summary(futurefgcDau_ind))



prior.full <- list(R=list(list(V=diag(1),nu=5)),
                   G=list(list(Vcomm=diag(1),nu=5)
                          , list(Veth=diag(1),nu=5)
                          , list(VCC=diag(1),nu=5)
                          , list(VCCB=diag(1),nu=5)
                          , list(VCCA=diag(1),nu=5)
                          , list(VCCM=diag(1),nu=5)
                          #                           , list(VCCAGE=diag(4),nu=5)
                          #                           , list(VCCW=diag(4),nu=5)
                          , list(VCCGB=diag(1),nu=5)
                          , list(VCCGA=diag(1),nu=5)
                          , list(VCCGM=diag(1),nu=5)
                          # , list(VCCGW=diag(4),nu=5)
                   ))

futurefgcDau_full <- MCMCglmm(
  as.factor(futurefgcDau) ~ fgcstatusMom 
  + group_fgcstatusMom
  + futurefgc + group_futurefgc
  + bene + group_bene
  + media + group_media
  + att + group_att 
  + edu + group_edu 
  + spl(wealth, 4) + spl(group_wealth,4)
  + spl(age, 4)  
  + maritalStat + job + urRural + religion
  , random=~clusterId + ethni + CC
  + bene:CC + att:CC + media:CC 
  # + us(spl(age,k=4)):CC + us(spl(wealth,k=4)):CC 
  + group_bene:CC + group_att:CC + group_media:CC
  # + us(spl(group_wealth,k=4)):CC
  , rcov=~units
  , prior=prior.full
  , nitt = nitt
  , data=dat
  # , singular.ok = TRUE
  # , slice=TRUE
  , verbose=FALSE
  , family="ordinal"
)

print(summary(futurefgcDau_full))

library(MCMCglmm)
nitt <- 20000
for (r in grep("Rds$", input_files, value=TRUE)){
  if (exists("dat"))
    dat <- rbind(dat, readRDS(r))
  else
    dat <- readRDS(r)
}

# dat <- dat[sample(1:nrow(dat),5000),]

set.seed(101)
prior.ind <- list(R=list(list(V=diag(1),nu=5)),
                  G=list(list(Vcomm=diag(1),nu=5)
                         , list(Veth=diag(1),nu=5)
                         , list(VCC=diag(1),nu=5)
                         , list(VCCB=diag(1),nu=5)
                         , list(VCCA=diag(1),nu=5)
                         , list(VCCM=diag(1),nu=5)
                         , list(VCCAGE=diag(4),nu=5)
                         , list(VCCW=diag(4),nu=5)
                  ))

print(summary(dat))

daughterfgc_ind <- MCMCglmm(
  as.factor(futurefgcDau) ~ fgcstatusMom
  + bene + media + att + edu
  + spl(age,k=4) + spl(wealth,k=4)
  + maritalStat 
  + job
  + urRural + religion
  - 1
  , random=~clusterId + ethni + CC 
  + bene:CC + att:CC + media:CC 
  + us(spl(age,k=4)):CC + us(spl(wealth,k=4)):CC 
  , rcov=~units
  , prior=prior.ind
  , nitt = nitt
  , data=dat
  #   , singular.ok = TRUE
  , verbose=FALSE
  #   , slice = TRUE
  , family="ordinal"
)

print(summary(daughterfgc_ind))

prior.full <- list(R=list(list(V=diag(1),nu=5)),
                   G=list(list(Vcomm=diag(1),nu=5)
                          , list(Veth=diag(1),nu=5)
                          , list(VCC=diag(1),nu=5)
                          , list(VCCB=diag(1),nu=5)
                          , list(VCCA=diag(1),nu=5)
                          , list(VCCM=diag(1),nu=5)
                          , list(VCCAGE=diag(4),nu=5)
                          , list(VCCW=diag(4),nu=5)
                          , list(VCCGB=diag(1),nu=5)
                          , list(VCCGA=diag(1),nu=5)
                          , list(VCCGM=diag(1),nu=5)
                          , list(VCCGW=diag(4),nu=5)
                   ))

daughterfgc_full <- MCMCglmm(
  as.factor(futurefgcDau) ~ fgcstatusMom
  + bene + media + att
  + group_bene + group_media + group_att 
  + group_fgc + group_edu + spl(group_wealth,4)
  + spl(age, 4) + spl(wealth, 4) 
  + maritalStat + CC:job + CC:urRural
  - 1
  , random=~clusterId + ethni + CC
  + bene:CC + att:CC + media:CC 
  + us(spl(age,k=4)):CC + us(spl(wealth,k=4)):CC 
  + group_bene:CC + group_att:CC + group_media:CC
  + us(spl(group_wealth,k=4)):CC
  , rcov=~units
  , prior=prior.full
  , nitt = nitt
  , data=dat
  # , singular.ok = TRUE
  # , slice=TRUE
  , verbose=FALSE
  , family="ordinal"
)

print(summary(daughterfgc_full))
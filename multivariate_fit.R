library(MCMCglmm)
nitt <- 50000
for (r in grep("Rds$", input_files, value=TRUE)){
  if (exists("dat"))
    dat <- rbind(dat, readRDS(r))
  else
    dat <- readRDS(r)
}

prior.c <- list(R=list(list(V=diag(2),nu=5)),
                G=list(list(V=diag(2),nu=5)))

print(summary(dat))

multivariate_full <- MCMCglmm(
  cbind(as.factor(futurefgc),as.factor(futurefgcDau)) ~ CC*trait * (
    fgcstatusMom
    + bene + media + att
    + group_bene + group_media + group_att 
    + group_fgc + group_edu + splines:::ns(group_wealth,4)
    + splines::ns(age, 4) + splines::ns(wealth, 4)
    + edu + maritalStat + job + urRural 
    + ethni + religion
  ) - 1
  , random=~us(trait):clusterId
  , rcov=~us(trait):units
  , prior=prior.c
  , nitt = nitt
  , data=dat
  , verbose=FALSE
  , slice = TRUE
  , family=c("ordinal","ordinal")
)

print(summary(multivariate_full))

multivariate_ind <- MCMCglmm(
  cbind(as.factor(futurefgc),as.factor(futurefgcDau)) ~ CC*trait * (
    fgcstatusMom
    + bene + media + att
    + splines::ns(age, 4) + splines::ns(wealth, 4)
    + edu + maritalStat + job + urRural 
    + ethni + religion
  ) - 1
  , random=~us(trait):clusterId
  , rcov=~us(trait):units
  , prior=prior.c
  , nitt = nitt
  , data=dat
  , verbose=FALSE
  , slice = TRUE
  , family=c("ordinal","ordinal")
)

print(summary(multivariate_ind))

# rdsave(MCMCmod)

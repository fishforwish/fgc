library(MCMCglmm)
nitt <- 5000
for (r in grep("Rds$", input_files, value=TRUE)){
  if (exists("dat"))
    dat <- rbind(dat, readRDS(r))
  else
    dat <- readRDS(r)
}
# rdsave(dat)

prior.c <- list(R=list(list(V=diag(2),nu=5)),
                G=list(list(V=diag(2),nu=5)))

print(summary(dat))

MCMCmod <- MCMCglmm(
  cbind(as.factor(futurefgc),as.factor(futurefgcDau)) ~ trait * (
    fgcstatusMom
    + bene + media + att
    + group_bene + group_media + group_att + group_fgc
    + splines::ns(age, 4) + splines::ns(wealth, 4) 
    + edu + maritalStat + job + urRural + CC
    + ethni + religion
  ) - 1
  , random=~us(trait):clusterId
  , rcov=~us(trait):units
  , prior=prior.c
  , nitt = nitt
  , data=dat
  , verbose=FALSE
  , family=c("ordinal","ordinal")
)

print(summary(MCMCmod))

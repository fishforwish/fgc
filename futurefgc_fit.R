library(MCMCglmm)
nitt <- 5000
for (r in grep("Rds$", input_files, value=TRUE)){
  if (exists("dat"))
    dat <- rbind(dat, readRDS(r))
  else
    dat <- readRDS(r)
}

# rdsave(dat)

prior.c <- list(R=list(list(V=diag(1),nu=5)),
                G=list(list(V=diag(1),nu=5)))

print(summary(dat))

MCMCmod <- MCMCglmm(
    as.factor(futurefgc) ~ CC*(
    fgcstatusMom
    + bene + media + att
    + group_bene + group_media + group_att + group_fgc + group_edu + group_wealth
    + splines::ns(age, 4) + splines::ns(wealth, 4) 
    + edu + wealth + maritalStat + job + urRural
    + ethni + religion)
   - 1
  , random=~clusterId
  , rcov=~units
  , prior=prior.c
  , nitt = nitt
  , data=dat
  , verbose=TRUE
  , family="ordinal"
)

print(summary(MCMCmod))
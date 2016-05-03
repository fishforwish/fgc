library(MCMCglmm)
nitt <- 5000
for (r in grep("Rds$", input_files, value=TRUE)){
  if (exists("dat"))
    dat <- rbind(dat, readRDS(r))
  else
    dat <- readRDS(r)
}


prior.c <- list(R=list(list(V=diag(1),nu=5)),
                G=list(list(V=diag(1),nu=5)))

print(summary(dat))
# 
# futurefgc_full <- MCMCglmm(
#     as.factor(futurefgc) ~ CC:fgcstatusMom
#     + CC:bene + CC:media + CC:att
#     + CC:group_bene + CC:group_media + CC:group_att 
#     + CC:group_fgc + group_edu + CC:splines:::ns(group_wealth,4)
#     + CC:splines::ns(age, 4) + CC:splines::ns(wealth, 4) 
#     + CC:edu + CC:maritalStat + CC:job + CC:urRural
#     + CC:ethni + CC:religion
#    - 1
#   , random=~clusterId
#   , rcov=~units
#   , prior=prior.c
#   , nitt = nitt
#   , data=dat
#   , singular.ok = TRUE
#   , slice=TRUE
#   , verbose=FALSE
#   , family="ordinal"
# )
# 
# print(summary(futurefgc_full))
dat2 <- head(dat,4000)
futurefgc_ind <- MCMCglmm(
  as.factor(futurefgc) ~ CC:fgcstatusMom
    + CC:bene + CC:media + CC:att + CC:edu
    + CC:splines::ns(age, 4) + CC:splines::ns(wealth, 4)
    + CC:maritalStat 
    + CC:job
    + CC:urRural + CC:ethni + CC:religion
  , random=~clusterId
  , rcov=~units
  , prior=prior.c
  , nitt = nitt
  , data=dat2
  , singular.ok = TRUE
  , verbose=TRUE
  , slice = TRUE
  , family="ordinal"
)

print(summary(futurefgc_ind))

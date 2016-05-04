library(MCMCglmm)
nitt <- 5000
for (r in grep("Rds$", input_files, value=TRUE)){
  if (exists("dat"))
    dat <- rbind(dat, readRDS(r))
  else
    dat <- readRDS(r)
}
set.seed(101)
dat <- dat[sample(1:nrow(dat),5000),]

prior.c <- list(R=list(list(V=diag(1),nu=5)),
                G=list(list(Vcomm=diag(1),nu=5)
                       , list(Veth=diag(1),nu=5)
                       , list(VCCB=diag(4),nu=5)
                       , list(VCCA=diag(4),nu=5)
                       , list(VCCM=diag(4),nu=5)
#                        , list(VCCAGE=diag(1),nu=5)
#                        , list(VCCW=diag(1),nu=5)
))

print(summary(dat))

futurefgc_ind <- MCMCglmm(
  as.factor(futurefgc) ~ fgcstatusMom
    + CC
    + bene + media + att + edu
    + splines::ns(age, 4) + splines::ns(wealth, 4)
    + maritalStat 
    + job
    + urRural + religion
    - 1
  , random=~clusterId + ethni 
    + us(CC):bene + us(CC):att + us(CC):media 
    # + CC:splines::ns(age,4) + CC:splines::ns(wealth,4) 
  , rcov=~units
  , prior=prior.c
  , nitt = nitt
  , data=dat
#   , singular.ok = TRUE
   , verbose=TRUE
#   , slice = TRUE
  , family="ordinal"
)

print(summary(futurefgc_ind))


quit()
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
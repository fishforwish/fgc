library(ordinal)

# for (r in grep("Rds$", input_files, value=TRUE)){
#   if (exists("dat"))
#     dat <- rbind(dat, readRDS(r))
#   else
#     dat <- readRDS(r)
# }

system.time(fullmod <- clmm2(futurefgc~
    fgcstatusMom
    + bene + media + att
    + group_bene + group_media + group_att 
    + group_fgc + group_edu + splines::ns(group_wealth,4)
    + splines::ns(age, 4) + splines::ns(wealth, 4) 
    + edu + maritalStat + job + urRural
    + ethni + religion
    , random= clusterId
    , data=combinedDat
    , nAGQ = 5
    , Hess = TRUE
))

system.time(indmod <- clmm2(futurefgc~
  fgcstatusMom
  + bene + media + att
  + splines::ns(age, 4) + splines::ns(wealth, 4)
  + edu + maritalStat + job + urRural
  + ethni + religion
  , random= clusterId
  , data=combinedDat
  , nAGQ = 5
  , Hess = TRUE
))

print(summary(fullmod))
print(summary(indmod))
print(anova(fullmod,indmod))

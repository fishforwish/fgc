library(ordinal)
library(splines)

library(shellpipes)

combined_dat <- rdsRead()

modAns <- model.frame(
  Persist ~ group_Persist
  + daughterPlan + group_daughterPlan
  + fgcstatus + group_fgc
  + CC
  + bene 
  + group_bene
  + media + group_media 
  + genderAware + group_genderAware
  + edu + group_edu
  + wealth + group_wealth
  + age + maritalStat + job + urRural + religion
  + clusterId + ethni
  , data=combined_dat, na.action=na.exclude, drop.unused.levels=TRUE
)

system.time(mod <- clmm(
  Persist ~ group_Persist
  + daughterPlan + group_daughterPlan
  + fgcstatus + group_fgc
  + CC
  + bene
  + group_bene
  + media + group_media 
  + genderAware + group_genderAware
  + edu + group_edu
  + ns(wealth,3) + ns(group_wealth, 3)
  + ns(age,4) 
  + maritalStat 
  + job
  + urRural + religion
  + (1|clusterId) + (1|ethni)
  , data=modAns)
)

print(summary(mod))

saveVars(mod, modAns)

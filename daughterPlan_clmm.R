library(shellpipes)
library(ordinal)
library(splines)

combined_dat <- rdsRead()

summary(combined_dat)

modAns <- model.frame(
  daughterPlan ~ group_daughterPlan
  + Persist + group_Persist
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

fit_time <- system.time(mod<- clmm(
  daughterPlan ~ group_daughterPlan
  + fgcstatus + group_fgc
  + CC
  + bene 
  + group_bene
  + media + group_media 
  + genderAware + group_genderAware 
  + edu + group_edu
  + ns(wealth,3) + ns(group_wealth,3)
  + ns(age,4) 
  + maritalStat 
  + job
  + urRural + religion
  + (1|clusterId) + (1|ethni)
  , data=modAns)
)

print(summary(mod))

saveVars(mod, modAns, fit_time)

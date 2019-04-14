library(dplyr)
library(ordinal)
library(splines)

combined_dat <- (combined_dat
	%>% group_by(clusterId)
	%>% mutate(group_Persist = mean(Persist01, na.rm=TRUE))
)

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

system.time(mod<- clmm(
  daughterPlan ~ group_daughterPlan
  + Persist + group_Persist
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

# rdsave(mod, modAns)

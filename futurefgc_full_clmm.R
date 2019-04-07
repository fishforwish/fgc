library(ordinal)
library(splines)


modAns <- model.frame(
  futurefgc ~ group_futurefgc
  + fgcstatus + group_fgc
  + CC
  + bene 
  + group_bene
  + media + group_media 
  + gender + group_gender
  + edu + group_edu
  + wealth + group_wealth
  + age + maritalStat + job + urRural + religion
  + clusterId + ethni
  , data=combined_dat, na.action=na.exclude, drop.unused.levels=TRUE
)

system.time(mod <- clmm(
  futurefgc ~ group_futurefgc
  + fgcstatus + group_fgc
  + CC
  + bene
  + group_bene
  + media + group_media 
  + gender + group_gender
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

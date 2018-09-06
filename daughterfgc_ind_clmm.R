library(ordinal)
library(splines)


modAns <- model.frame(
  futurefgcDau ~ fgcstatus + CC 
  + bene + media + att + edu 
  + age + wealth 
  + maritalStat + job + urRural + religion
  + clusterId + ethni
  , data=combined_dat, na.action=na.exclude, drop.unused.levels=TRUE
)

system.time(mod <- clmm(futurefgcDau ~ fgcstatus
  + CC
  + bene + media + att + edu
  + ns(age,4) + ns(wealth,3)
  + maritalStat + job + urRural + religion
  + (1|clusterId) + (1|ethni)
  , data=modAns)
)

print(summary(mod))

# rdsave(mod, modAns)


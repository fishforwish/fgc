library(ordinal)
library(splines)

for (r in grep("Rds$", input_files, value=TRUE)){
  if (exists("dat"))
    dat <- rbind(dat, readRDS(r))
  else
    dat <- readRDS(r)
}

modAns <- model.frame(
  futurefgc ~ fgcstatusMom + group_fgcstatusMom
  + bene + group_bene
  + media + group_media 
  + att + group_att 
  + edu + group_edu
  + wealth + group_wealth
  + age + maritalStat + job + urRural + religion
  + clusterId + ethni + CC
  , data=dat, na.action=na.exclude, drop.unused.levels=TRUE
)

system.time(mod <- clmm(
  futurefgc ~ fgcstatusMom + group_fgcstatusMom
  + bene + group_bene
  + media + group_media 
  + att + group_att 
  + edu + group_edu
  + ns(wealth,3) + ns(group_wealth,3)
  + ns(age,4) 
  + maritalStat 
  + job
  + urRural + religion
  + (1|clusterId) + (1|ethni)
    + (1|CC)
  , data=modAns)
)

print(summary(mod))

# rdsave(mod, modAns)

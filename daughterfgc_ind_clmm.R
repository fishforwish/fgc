library(ordinal)
library(splines)

for (r in grep("Rds$", input_files, value=TRUE)){
  if (exists("dat"))
    dat <- rbind(dat, readRDS(r))
  else
    dat <- readRDS(r)
}

modAns <- model.frame(
  futurefgcDau ~ fgcstatusMom + bene + media + att + edu 
  + age + wealth + maritalStat + job + urRural + religion
  + clusterId + ethni + CC
  , data=dat, na.action=na.exclude, drop.unused.levels=TRUE
)

system.time(mod <- clmm(
  futurefgcDau ~ fgcstatusMom
  + bene + media + att + edu
  + ns(age,4) + ns(wealth,3)
  + maritalStat 
  + job
  + urRural + religion
  + (1|clusterId) + (1|ethni)
  + (1| CC)
  , data=modAns)
)

print(summary(mod))

# rdsave(mod, modAns)


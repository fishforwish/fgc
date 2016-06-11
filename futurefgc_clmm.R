library(ordinal)
library(splines)

for (r in grep("Rds$", input_files, value=TRUE)){
  if (exists("dat"))
    dat <- rbind(dat, readRDS(r))
  else
    dat <- readRDS(r)
}


system.time(futurefgc_ind <- clmm(
  futurefgc ~ fgcstatusMom
  + bene + media + att + edu
  + ns(age,4) + ns(wealth,3)
  + maritalStat 
  + job
  + urRural + religion
  + (1|clusterId) + (1|ethni)
  + (1 + bene + media + att |CC)
  , data=dat)
)

print(summary(futurefgc_ind))

system.time(futurefgc_full <- clmm(
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
    + (1 + bene + media + att
       + group_bene + group_media + group_att |CC)
  , data=dat)
)

print(summary(futurefgc_full))

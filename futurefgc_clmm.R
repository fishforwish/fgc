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
  + ns(age,k=4) + ns(wealth,k=3)
  + maritalStat 
  + job
  + urRural + religion
  + (1|clusterId) + (1|ethni)
  + (1 + bene + media + att |CC)
     # + edu + ns(age, k=4) + ns(wealth, k=4)| CC)
  , data=dat)
)

print(summary(futurefgc_ind))

#ns(group_wealth,k=4) has a problem

system.time(futurefgc_full <- clmm(
  futurefgc ~ fgcstatusMom + group_fgcstatusMom
  + bene + group_bene
  + media + group_media 
  + att + group_att 
  + edu + group_edu
  + ns(wealth,k=3) + ns(group_wealth,k=3)
  + ns(age,k=4) 
  + maritalStat 
  + job
  + urRural + religion
  + (1|clusterId) + (1|ethni)
    + (1 + bene + media + att
       # + edu + ns(age,k=4)
       + group_bene + group_media + group_att |CC)
       # + group_edu
       # + ns(wealth,k=4)
       # + ns(group_wealth,k=3)| CC)
  , data=dat)
)

print(summary(futurefgc_full))

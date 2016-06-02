library(ordinal)
library(splines)

for (r in grep("Rds$", input_files, value=TRUE)){
  if (exists("dat"))
    dat <- rbind(dat, readRDS(r))
  else
    dat <- readRDS(r)
}

system.time(daughterfgc_ind <- clmm(
  futurefgcDau ~ fgcstatusMom
  + bene + media + att + edu
  + ns(age,k=4) + ns(wealth,k=4)
  + maritalStat 
  + job
  + urRural + religion
  + (1|clusterId) + (1|ethni)
  + (1 + bene + media + att + ns(age, k=4) + ns(wealth, k=4)| CC)
  , data=dat)
)

print(daughterfgc_ind)

# 
# system.time(daughter_full <- clmm(
#   futurefgcDau ~ fgcstatusMom
#   + bene + group_bene
#   + media + group_media 
#   + att + group_att 
#   + edu + group_edu
#   + ns(wealth,k=4) + ns(group_wealth,k=3)
#   + ns(age,k=4) 
#   + maritalStat 
#   + job
#   + urRural + religion
#   + (1|clusterId) + (1|ethni)
#   + (1 + bene + media + att + edu + ns(age,k=4)
#      + group_bene + group_media + group_att + group_edu
#      + ns(wealth,k=4)
#      + ns(group_wealth,k=3)| CC)
#   , data=dat)
# )

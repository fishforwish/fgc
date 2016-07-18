library(brms)
library(splines)

for (r in grep("Rds$", input_files, value=TRUE)){
  if (exists("dat"))
    dat <- rbind(dat, readRDS(r))
  else
    dat <- readRDS(r)
}

system.time(futurefgc_ind <- brm(
  as.numeric(futurefgc) ~ fgcstatusMom
  + bene + media + att + edu
  + ns(age,4) + ns(wealth,3)
  + maritalStat 
  + job
  + urRural + religion
  + (1|clusterId) + (1|ethni)
  + (1 + media |CC)
  , data=dat
  , family=cumulative()
  )
)

print(summary(futurefgc_ind))


system.time(futurefgc_full <- brm(
  as.numeric(futurefgc) ~ fgcstatusMom + group_fgcstatusMom
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
  + (1 + media 
     + group_media |CC)
  , data=dat
  , family=cumulative()
)
)

print(summary(futurefgc_full))



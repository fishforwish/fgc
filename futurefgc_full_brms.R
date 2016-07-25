library(brms)
library(splines)

for (r in grep("Rds$", input_files, value=TRUE)){
  if (exists("dat"))
    dat <- rbind(dat, readRDS(r))
  else
    dat <- readRDS(r)
}

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
  , chains = 4
  , iter = 2000
  , warmup = 500
)
)

print(summary(futurefgc_full))



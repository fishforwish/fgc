library(brms)
library(splines)

for (r in grep("Rds$", input_files, value=TRUE)){
  if (exists("dat"))
    dat <- rbind(dat, readRDS(r))
  else
    dat <- readRDS(r)
}

system.time(futurefgcDau_ind <- brm(
  as.numeric(futurefgcDau) ~ futurefgc + fgcstatusMom
  + bene + media + att + edu
  + ns(age,4) + ns(wealth,3)
  + maritalStat 
  + job
  + urRural + religion
  + (1|clusterId) + (1|ethni)
  + (1 + media| CC)
  , data=dat
  , family=cumulative()
  )
)

print(summary(futurefgcDau_ind))


system.time(futurefgcDau_full <- brm(
  as.numeric(futurefgcDau) ~ futurefgc + group_futurefgc
  + fgcstatusMom + group_fgcstatusMom
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


print(summary(futurefgcDau_full))

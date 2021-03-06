library(brms)
library(splines)

for (r in grep("Rds$", input_files, value=TRUE)){
  if (exists("dat"))
    dat <- rbind(dat, readRDS(r))
  else
    dat <- readRDS(r)
}

system.time(futurefgc<- brm(
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

print(summary(futurefgc))

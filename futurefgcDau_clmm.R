library(ordinal)
library(splines)

for (r in grep("Rds$", input_files, value=TRUE)){
  if (exists("dat"))
    dat <- rbind(dat, readRDS(r))
  else
    dat <- readRDS(r)
}

system.time(futurefgcDau_ind <- clmm(
  futurefgcDau ~ futurefgc + fgcstatusMom
  + bene + media + att + edu
  + ns(age,k=4) + ns(wealth,k=4)
  + maritalStat 
  + job
  + urRural + religion
  + (1|clusterId) + (1|ethni)
  + (1 + bene + media + att + ns(age, k=4) + ns(wealth, k=4)| CC)
  , data=dat)
)

print(futurefgcDau_ind)

library(ordinal)
library(splines)

for (r in grep("Rds$", input_files, value=TRUE)){
  if (exists("dat"))
    dat <- rbind(dat, readRDS(r))
  else
    dat <- readRDS(r)
}

set.seed(101)
dat <- dat[sample(1:nrow(dat),2000),]


system.time(futurefgc_ind <- clmm(
  futurefgc ~ fgcstatusMom
  + bene + media + att + edu
  + ns(age,k=4) + ns(wealth,k=4)
  + maritalStat 
  + job
  + urRural + religion
  + (1|clusterId) + (1|ethni) +
  + (1 + bene + media + att + ns(age, k=4) + ns(wealth, k=4)| CC)
  , data=dat)
)

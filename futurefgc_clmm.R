library(ordinal)

for (r in grep("Rds$", input_files, value=TRUE)){
  if (exists("dat"))
    dat <- rbind(dat, readRDS(r))
  else
    dat <- readRDS(r)
}

dat2 <- head(dat,8000)

print(summary(dat2))

fullmod <- clmm(futurefgc~
    fgcstatusMom
    + bene + media + att
    + group_bene + group_media + group_att + group_fgc + group_edu 
    + splines::ns(age, 4) + splines::ns(wealth, 4) + splines::ns(group_wealth,4)
    + edu + maritalStat + job + urRural
    + ethni + religion
    + (1|clusterId),
    data=dat
)

print(summary(fullmod))

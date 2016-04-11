library(ordinal)

for (r in grep("Rds$", input_files, value=TRUE)){
  if (exists("dat"))
    dat <- rbind(dat, readRDS(r))
  else
    dat <- readRDS(r)
}

dat2 <- head(dat,9000)

fullmod <- clmm(futurefgc~
    fgcstatusMom
    + bene + media + att
    + group_bene + group_media + group_att + group_fgc
    + splines::ns(age, 4) + splines::ns(wealth, 4) 
    + edu + maritalStat + job + urRural + CC
    + ethni + religion
    - 1
    + (0|clusterId),
    data=dat2
)
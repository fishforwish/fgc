library(MCMCglmm)
library(splines)

for (r in grep("Rds$", input_files, value=TRUE)){
	if (exists("dat"))
		dat <- rbind(dat, readRDS(r))
	else
		dat <- readRDS(r)
}
# rdsave(dat)

prior.c <- list(R=list(list(V=diag(2),nu=5)),
                G=list(list(V=diag(2),nu=5)))

dat2 <- dat %>% 
  ungroup() %>% 
  mutate(futurefgc=vector(futurefgc,mode="integer"),
         futurefgcDau=vector(futurefgcDau,mode="integer"))

aa <- dat2$futurefgc

print(summary(dat))

MCMCmod <- MCMCglmm(
	cbind(as.factor(futurefgc),as.factor(futurefgcDau)) ~ trait
		+ fgcstatusMom
# 		+ bene + media + att
# 		+ group_bene + group_media + group_att + group_fgc
# 	  	+ ns(age, 4) + ns(wealth, 4) 
# 		+ edu + maritalStat + job + urRural + CC
# 		+ ethni + religion
		- 1
	, random=~us(trait):clusterId
	, rcov=~us(trait):units
#	, prior=prior.c
	, nitt = 5000
	, data=dat2
	, verbose=FALSE
	, family=c("ordinal","ordinal")
)

summary(MCMCmod)

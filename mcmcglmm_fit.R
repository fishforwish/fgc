library(MCMCglmm)

dat <- rbind(readRDS("KE.df.RDS"),
             readRDS("SL.df.RDS"),
             readRDS("NG.df.RDS"),
             readRDS("ML.df.RDS")
)

prior.c <- list(R=list(list(V=diag(2),nu=5)),
                G=list(list(V=diag(2),nu=5)))

MCMCmod <- MCMCglmm(
	cbind(as.factor(futurefgc),as.factor(futurefgcDau)) ~ trait
		+ fgcstatusMom
		+ bene + media + att
		+ group_bene + group_media + group_att + group_fgc
	  	+ ns(age, 4) + ns(wealth, 4) 
		+ edu + maritalStat + job + urRural + CC
		+ ethni + religion
		- 1
	, random=~us(trait):clusterId
	, rcov=~us(trait):units
	, prior=prior.c
	, nitt = 30000
	, data=combinedDatID
	, verbose=FALSE
	, family=c("ordinal","ordinal")
)

summary(MCMCmod)

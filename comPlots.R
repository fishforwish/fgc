vf <- factor(v, levels=c("beneHygiene", "beneAcceptance", "beneMarriage", "benePreventPreSex", "benePleasureM", "beneReligion", "beneOther"))

dnp <- apply(pc$rotation, 2, function(r){
	plot(vf, r)
	abline(h=0)
})

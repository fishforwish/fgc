vf <- factor(v, levels=c("beneHygiene", "beneAcceptance", "beneMarriage", "benePreventPreSex", "benePleasureM", "beneReligion", "beneRedPromis", "beneRedSTD", "beneOther"))

dnp <- apply(pc$rotation, 2, function(r){
	plot(vf, r)
	abline(h=0)
})

library(ordinal)
library(splines)
library(gridExtra)
library(ggplot2)
library(reshape)
theme_set(theme_bw())

library(shellpipes)
loadEnvironments()
rtargetname <- targetname()
startGraphics()

attr(modAns,"terms") <- NULL 

catNames <- c("religion","urRural","job","maritalStat")
predNames <- colnames(modAns)[2:(ncol(modAns)-2)]

predNames <- c("CC","religion","maritalStat","age","wealth", "group_wealth")
predsummary <- c("CC","religion","maritalStat","ns(age, 4)","ns(wealth, 3)","ns(group_wealth, 3)")

if(rtargetname == "hybrid_isoplots"){
	predNames <- c(predNames, "Persist")
	predsummary <- c(predsummary, "Persist")
	respLab <- "Hybrid Score"
}
if(rtargetname == "fgcPersist_isoplots"){
	varlvlnames <- varlvlnames[-which(varlvlnames == "group_daughterPlan")]
	respLab <- "FGC Persistence Score"
}

if(rtargetname == "daughterPlan_isoplots"){
	varlvlnames <- varlvlnames[-which(varlvlnames == "group_Persist")]
	respLab <- "Daughter Plan Score"
}


isoList <- lapply(predNames, function(n){
  ordpred(mod, n, modAns)
})


varlvlsum1 <- varlvlsum[predsummary,]
print(
  grid.arrange(varPlot(rename(isoList[[1]], c(CC = "Country")) ,P=varlvlsum1$`Pr(>Chisq)`[1],ylab=""),
               varPlot(rename(isoList[[2]], c(religion = "Religion")) ,P=varlvlsum1$`Pr(>Chisq)`[2], ylab=""),
               varPlot(rename(isoList[[3]], c(maritalStat = "Marital Status")) ,P=varlvlsum1$`Pr(>Chisq)`[3], ylab=respLab),
               varPlot(rename(isoList[[4]], c(age = "Age")) ,P=varlvlsum1$`Pr(>Chisq)`[4], ylab=""),
               varPlot(rename(isoList[[5]], c(wealth = "Wealth")) ,P=varlvlsum1$`Pr(>Chisq)`[5], ylab=""),
					varPlot(rename(isoList[[6]], c(group_wealth = "Group Wealth")) ,P=varlvlsum1$`Pr(>Chisq)`[6], ylab=""),
					nrow=3
					)
)
if(rtargetname == "hybrid_isoplots"){
	print(varPlot(isoList[[7]],P=varlvlsum1$`Pr(>Chisq)`[7], ylab=respLab))
}


## Single var iso plots

varlvlsum2 <- varlvlsum[varlvlnames,]
isoList2 <- lapply(varlvlnames, function(n){
	ordpred(mod, n, modAns)
})



## futurefgc_ind, daughterfgc_ind
print(
grid.arrange(varPlot(isoList2[[1]] ,P=varlvlsum2$`Pr(>Chisq)`[1],ylab=""),
             varPlot(isoList2[[2]] ,P=varlvlsum2$`Pr(>Chisq)`[2],ylab=""),
             varPlot(isoList2[[3]] ,P=varlvlsum2$`Pr(>Chisq)`[3],ylab=""),
             varPlot(isoList2[[4]] ,P=varlvlsum2$`Pr(>Chisq)`[4],ylab=""),
             varPlot(isoList2[[5]] ,P=varlvlsum2$`Pr(>Chisq)`[5], ylab=respLab),
             varPlot(isoList2[[6]] ,P=varlvlsum2$`Pr(>Chisq)`[6],ylab=""),
             varPlot(isoList2[[7]] ,P=varlvlsum2$`Pr(>Chisq)`[7],ylab=""),
             varPlot(isoList2[[8]] ,P=varlvlsum2$`Pr(>Chisq)`[8],ylab=""),
             varPlot(isoList2[[9]] ,P=varlvlsum2$`Pr(>Chisq)`[9],ylab=""),
             varPlot(isoList2[[10]],P=varlvlsum2$`Pr(>Chisq)`[10],ylab=""),
             varPlot(isoList2[[11]],P=varlvlsum2$`Pr(>Chisq)`[11],ylab=""),
             varPlot(isoList2[[12]],P=varlvlsum2$`Pr(>Chisq)`[[12]],ylab=""),
             nrow=3,ncol=4)
)



## futurefgc_full, daughterfgc_full
if(nrow(varlvlsum2)==14){
  print(varPlot(isoList2[[13]],P=varlvlsum2$`Pr(>Chisq)`[13],ylab=respLab)
  )
}

# saveVars(isoList,varlvlsum)

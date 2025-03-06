library(shellpipes)
loadEnvironments()

library(ordinal)
library(splines)
library(RVAideMemoire)


varlvlsum <- Anova.clmm(mod)

print(varlvlsum)

saveVars(mod,modAns,varlvlsum)

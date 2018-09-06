library(ordinal)
library(splines)
library(RVAideMemoire)


varlvlsum <- Anova.clmm(mod)

print(varlvlsum)

# rdsave(mod,modAns,varlvlsum)

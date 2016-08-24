library(ordinal)
library(splines)
library(RVAideMemoire)

load(".all.futurefgc_full_clmm.RData")

varlvlsum <- Anova.clmm(mod)

print(varlvlsum)

# rdsave(mod, modAns, varlvlsum)
library(ordinal)
library(splines)
library(RVAideMemoire)

load(".all.futurefgcDau_full_clmm.RData")

varlvlsum <- Anova.clmm(mod)

print(varlvlsum)

# rdsave(mod, modAns, varlvlsum)
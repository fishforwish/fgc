library(ordinal)
library(splines)
library(RVAideMemoire)

load(".all.futurefgcDau_ind_clmm.RData")

varlvlsum <- Anova.clmm(mod)

print(varlvlsum)

# rdsave(mod,modAns, varlvlsum)
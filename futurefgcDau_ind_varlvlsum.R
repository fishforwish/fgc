library(ordinal)
library(splines)
library(RVAideMemoire)

load(".all.futurefgcDau_ind_clmm.RData")

varlvlsum <- Anova.clmm(futurefgcDau_ind)

print(varlvlsum)

# rdsave(futurefgcDau_ind, varlvlsum)
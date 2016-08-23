library(ordinal)
library(splines)
library(RVAideMemoire)

load(".all.futurefgc_ind_clmm.RData")

varlvlsum <- Anova.clmm(futurefgc_ind)

print(varlvlsum)

# rdsave(futurefgc_ind, varlvlsum)
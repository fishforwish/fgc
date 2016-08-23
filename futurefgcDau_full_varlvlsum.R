library(ordinal)
library(splines)
library(RVAideMemoire)

load(".all.futurefgcDau_full_clmm.RData")

varlvlsum <- Anova.clmm(futurefgcDau_full)

print(varlvlsum)

# rdsave(futurefgcDau_full, varlvlsum)
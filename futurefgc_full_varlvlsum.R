library(ordinal)
library(splines)
library(RVAideMemoire)

load(".all.futurefgc_full_clmm.RData")

varlvlsum <- Anova.clmm(futurefgc_full)

print(varlvlsum)

# rdsave(futurefgc_full, varlvlsum)
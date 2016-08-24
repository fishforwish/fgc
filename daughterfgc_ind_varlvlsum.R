library(ordinal)
library(splines)
library(RVAideMemoire)

load(".all.daughterfgc_ind_clmm.RData")

varlvlsum <- Anova.clmm(mod)

print(varlvlsum)

# rdsave(mod, modAns, varlvlsum)
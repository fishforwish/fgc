library(ordinal)
library(splines)
library(RVAideMemoire)

load(".all.daughterfgc_full_clmm.RData")

varlvlsum <- Anova.clmm(daughterfgc_full)

print(varlvlsum)

# rdsave(daughterfgc_full, varlvlsum)
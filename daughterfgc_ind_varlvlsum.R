library(ordinal)
library(splines)
library(RVAideMemoire)

load(".all.daughterfgc_ind_clmm.RData")

varlvlsum <- Anova.clmm(daughterfgc_ind)

print(varlvlsum)

# rdsave(daughterfgc_ind, varlvlsum)
library(ordinal)
library(splines)
library(gridExtra)
library(ggplot2)
library(reshape)
theme_set(theme_bw())
attr(modAns,"terms") <- NULL 

# predfun <- function(modtype){
#   predNames = NULL
#   ifelse(modtype == "daughterfgc_full"
#          , predNames <- c(
#            "fgcstatusMom", "wealth", "religion", "edu", "urRural", "job", "group_edu",
#            "maritalStat", "media", "age", "bene", "group_bene",
#            "group_media", "group_wealth", "group_att", "att", "group_fgcstatusMom")
#          , predNames <- c("age","wealth","religion","edu","urRural","job",
#                           "maritalStat", "media", "knowledge")
#   )
#   return(predNames)
# }
# 
# tt <- "recency"
# if(unlist(strsplit(rtargetname,"[.]")) == "condomStatus_isoplots"){tt <- "status"}
# if(unlist(strsplit(rtargetname,"[.]")) == "partnerYearStatus_isoplots"){tt <- "status"}



catNames <- c("religion","urRural","job","maritalStat")
predNames <- colnames(modAns)[2:(ncol(modAns)-3)]

isoList <- lapply(predNames, function(n){
  ordpred(mod, n, modAns)
})

# print(
# grid.arrange(varPlot(rename(isoList[[1]],c(age="Age")),P=varlvlsum$`Pr(>Chisq)`[1]),
#              varPlot(rename(isoList[[2]],c(wealth="Wealth")),P=varlvlsum$`Pr(>Chisq)`[2]),
#              varPlot(rename(isoList[[3]],c(religion="Religion")),P=varlvlsum$`Pr(>Chisq)`[3]),
#              varPlot(rename(isoList[[4]],c(edu="Education")),P=varlvlsum$`Pr(>Chisq)`[4]),
#              varPlot(rename(isoList[[5]],c(urRural="Area")),P=varlvlsum$`Pr(>Chisq)`[5]),
#              varPlot(rename(isoList[[6]],c(job="Job")),P=varlvlsum$`Pr(>Chisq)`[6]),
#              varPlot(rename(isoList[[7]],c(maritalStat="Marital Status")),P=varlvlsum$`Pr(>Chisq)`[7]),
#              varPlot(rename(isoList[[8]],c(media="Media")),P=varlvlsum$`Pr(>Chisq)`[8]),
#              varPlot(rename(isoList[[9]],c(knowledge="Knowledge")),P=varlvlsum$`Pr(>Chisq)`[9]),
#              nrow=3)
# )

print(listPlot(isoList))

#rdsave(isoList,varlvlsum)
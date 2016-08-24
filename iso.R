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


if(ncol(modAns)==15){
print(
grid.arrange(varPlot(isoList[[1]],P=varlvlsum$`Pr(>Chisq)`[1]),
             varPlot(isoList[[2]],P=varlvlsum$`Pr(>Chisq)`[2]),
             varPlot(isoList[[3]],P=varlvlsum$`Pr(>Chisq)`[3]),
             varPlot(isoList[[4]],P=varlvlsum$`Pr(>Chisq)`[4]),
             varPlot(isoList[[5]],P=varlvlsum$`Pr(>Chisq)`[5]),
             varPlot(isoList[[6]],P=varlvlsum$`Pr(>Chisq)`[6]),
             varPlot(isoList[[7]],P=varlvlsum$`Pr(>Chisq)`[7]),
             varPlot(isoList[[8]],P=varlvlsum$`Pr(>Chisq)`[8]),
             varPlot(isoList[[9]],P=varlvlsum$`Pr(>Chisq)`[9]),
             varPlot(isoList[[9]],P=varlvlsum$`Pr(>Chisq)`[10]),
             varPlot(isoList[[9]],P=varlvlsum$`Pr(>Chisq)`[11]),
             nrow=4)
)
}

if(ncol(modAns)==15){
  print(
    grid.arrange(varPlot(isoList[[1]],P=varlvlsum$`Pr(>Chisq)`[1]),
                 varPlot(isoList[[2]],P=varlvlsum$`Pr(>Chisq)`[2]),
                 varPlot(isoList[[3]],P=varlvlsum$`Pr(>Chisq)`[3]),
                 varPlot(isoList[[4]],P=varlvlsum$`Pr(>Chisq)`[4]),
                 varPlot(isoList[[5]],P=varlvlsum$`Pr(>Chisq)`[5]),
                 varPlot(isoList[[6]],P=varlvlsum$`Pr(>Chisq)`[6]),
                 varPlot(isoList[[7]],P=varlvlsum$`Pr(>Chisq)`[7]),
                 varPlot(isoList[[8]],P=varlvlsum$`Pr(>Chisq)`[8]),
                 varPlot(isoList[[9]],P=varlvlsum$`Pr(>Chisq)`[9]),
                 varPlot(isoList[[9]],P=varlvlsum$`Pr(>Chisq)`[10]),
                 varPlot(isoList[[9]],P=varlvlsum$`Pr(>Chisq)`[11]),
                 nrow=4)
  )
}

if(ncol(modAns)==21){
  print(
    grid.arrange(varPlot(isoList[[1]],P=varlvlsum$`Pr(>Chisq)`[1]),
                 varPlot(isoList[[2]],P=varlvlsum$`Pr(>Chisq)`[2]),
                 varPlot(isoList[[3]],P=varlvlsum$`Pr(>Chisq)`[3]),
                 varPlot(isoList[[4]],P=varlvlsum$`Pr(>Chisq)`[4]),
                 varPlot(isoList[[5]],P=varlvlsum$`Pr(>Chisq)`[5]),
                 varPlot(isoList[[6]],P=varlvlsum$`Pr(>Chisq)`[6]),
                 varPlot(isoList[[7]],P=varlvlsum$`Pr(>Chisq)`[7]),
                 varPlot(isoList[[8]],P=varlvlsum$`Pr(>Chisq)`[8]),
                 varPlot(isoList[[9]],P=varlvlsum$`Pr(>Chisq)`[9]),
                 varPlot(isoList[[9]],P=varlvlsum$`Pr(>Chisq)`[10]),
                 varPlot(isoList[[9]],P=varlvlsum$`Pr(>Chisq)`[11]),
                 nrow=4)
  )
}


# print(listPlot(isoList))

#rdsave(isoList,varlvlsum)
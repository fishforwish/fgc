library(ordinal)
library(splines)
library(gridExtra)
library(ggplot2)
library(reshape)
theme_set(theme_bw())
attr(modAns,"terms") <- NULL 


catNames <- c("religion","urRural","job","maritalStat")
predNames <- colnames(modAns)[2:(ncol(modAns)-3)]

isoList <- lapply(predNames, function(n){
  ordpred(mod, n, modAns)
})


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
             varPlot(isoList[[10]],P=varlvlsum$`Pr(>Chisq)`[10]),
             varPlot(isoList[[11]],P=varlvlsum$`Pr(>Chisq)`[11]),
             nrow=4,ncol=3)
)

if(nrow(varlvlsum)>11){
  print(
    grid.arrange(varPlot(isoList[[12]],P=varlvlsum$`Pr(>Chisq)`[12]),
                 nrow=4,ncol=3)
  )
}

if(nrow(varlvlsum)>16){
  print(
    grid.arrange(varPlot(isoList[[12]],P=varlvlsum$`Pr(>Chisq)`[12]),
                 varPlot(isoList[[13]],P=varlvlsum$`Pr(>Chisq)`[13]),
                 varPlot(isoList[[14]],P=varlvlsum$`Pr(>Chisq)`[14]),
                 varPlot(isoList[[15]],P=varlvlsum$`Pr(>Chisq)`[15]),
                 varPlot(isoList[[16]],P=varlvlsum$`Pr(>Chisq)`[16]),
                 varPlot(isoList[[17]],P=varlvlsum$`Pr(>Chisq)`[17]),
                 nrow=4,ncol=3)
  )
}

if(nrow(varlvlsum)>18){
  print(
    grid.arrange(varPlot(isoList[[18]],P=varlvlsum$`Pr(>Chisq)`[18]),
                 varPlot(isoList[[19]],P=varlvlsum$`Pr(>Chisq)`[19]),
                 nrow=4,ncol=3)
  )
}

# print(listPlot(isoList))

#rdsave(isoList,varlvlsum)
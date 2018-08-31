library(ordinal)
library(splines)
library(gridExtra)
library(ggplot2)
library(reshape)
theme_set(theme_bw())
attr(modAns,"terms") <- NULL 


catNames <- c("religion","urRural","job","maritalStat")
predNames <- colnames(modAns)[2:(ncol(modAns)-3)]
predNames <- c(predNames,"CC")

isoList <- lapply(predNames, function(n){
  ordpred(mod, n, modAns)
})

## futurefgc_ind, daughterfgc_ind
print(
grid.arrange(varPlot(isoList[[1]],P=varlvlsum$`Pr(>Chisq)`[1]),
             varPlot(isoList[[2]],P=varlvlsum$`Pr(>Chisq)`[2]),
             varPlot(isoList[[3]],P=varlvlsum$`Pr(>Chisq)`[4]),
             varPlot(isoList[[4]],P=varlvlsum$`Pr(>Chisq)`[5]),
             varPlot(isoList[[5]],P=varlvlsum$`Pr(>Chisq)`[6]),
             varPlot(isoList[[6]],P=varlvlsum$`Pr(>Chisq)`[7]),
             varPlot(isoList[[7]],P=varlvlsum$`Pr(>Chisq)`[8]),
             varPlot(isoList[[8]],P=varlvlsum$`Pr(>Chisq)`[9]),
             varPlot(isoList[[9]],P=varlvlsum$`Pr(>Chisq)`[10]),
             varPlot(isoList[[10]],P=varlvlsum$`Pr(>Chisq)`[11]),
             varPlot(isoList[[11]],P=varlvlsum$`Pr(>Chisq)`[12]),
             varPlot(isoList[[12]], P=varlvlsum$`Pr(>Chisq)`[[13]]),
             nrow=4,ncol=3)
)


## futurefgcDau_ind
if(nrow(varlvlsum)==13){
  print(
    grid.arrange(varPlot(isoList[[13]],P=varlvlsum$`Pr(>Chisq)`[13]),
                 nrow=4,ncol=3)
  )
}

## futurefgc_full, daughterfgc_full
if(nrow(varlvlsum)==18){
  print(
    grid.arrange(varPlot(isoList[[13]],P=varlvlsum$`Pr(>Chisq)`[14]),
                 varPlot(isoList[[14]],P=varlvlsum$`Pr(>Chisq)`[15]),
                 varPlot(isoList[[15]],P=varlvlsum$`Pr(>Chisq)`[16]),
                 varPlot(isoList[[16]],P=varlvlsum$`Pr(>Chisq)`[17]),
                 varPlot(isoList[[17]],P=varlvlsum$`Pr(>Chisq)`[18]),
                 varPlot(isoList[[18]],P=varlvlsum$`Pr(>Chisq)`[3]),
                 nrow=4,ncol=3)
  )
}


## futurefgcDau_full
if(nrow(varlvlsum)==20){
  print(
    print(
      grid.arrange(varPlot(isoList[[13]],P=varlvlsum$`Pr(>Chisq)`[14]),
                   varPlot(isoList[[14]],P=varlvlsum$`Pr(>Chisq)`[15]),
                   varPlot(isoList[[15]],P=varlvlsum$`Pr(>Chisq)`[16]),
                   varPlot(isoList[[16]],P=varlvlsum$`Pr(>Chisq)`[17]),
                   varPlot(isoList[[17]],P=varlvlsum$`Pr(>Chisq)`[18]),
                   varPlot(isoList[[18]],P=varlvlsum$`Pr(>Chisq)`[19]),
                   varPlot(isoList[[19]],P=varlvlsum$`Pr(>Chisq)`[20]),
                   varPlot(isoList[[20]],P=varlvlsum$`Pr(>Chisq)`[5]),
                   nrow=4,ncol=3)
    )
  )
}

# print(listPlot(isoList))

# rdsave(isoList,varlvlsum)


library(shellpipes)

print(paste("######## TARGET", targetname()))

loadEnvironments()

levelCodeTable <- tsvRead(col_names=FALSE, comment="#")

print(levelCodeTable)

levelCodes <- levelCodeTable[[2]]
names(levelCodes) <- levelCodeTable[[1]]

quantall <- as.data.frame(sapply(qual, function(qual){
    sapply(as.character(qual), function(q){
        if(is.na(q)){return (NA)}
        levelCodes[[q]]
    })
}))

numObs <- sapply(quantall, function(q){
    sum(!is.na(q))
})

quant <- quantall[numObs>0]
row.names(quant) <- row.names(qual)

summary(quant)

# rdsave(quant, catname)

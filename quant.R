library(shellpipes)

print(paste("######## TARGET", targetname()))

loadEnvironments()

catList <- grepl(catname, names(Answers))
levelCodeTable <- (read.table(input_files, header=FALSE, stringsAsFactors=FALSE, sep="\t", row.names=1))

levelCodes <- levelCodeTable[[1]]
names(levelCodes) <- rownames(levelCodeTable)

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

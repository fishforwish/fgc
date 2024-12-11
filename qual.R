
library(shellpipes)

print(paste("######## TARGET", targetname()))

Answers <- rdsRead()
loadEnvironments()

catList <- grepl(catname, names(Answers))

qual <- Answers[catList]
Answers <- Answers[!catList]
 
num <- sapply(qual, function(q){
	sum(!is.na(q))
})
 
qual <- qual[num>0]

print(summary(qual))

as.data.frame(t(sapply(qual, levels)))
 
rdaSave(qual, catname)

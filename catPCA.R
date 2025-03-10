
library(shellpipes)

tname <- targetname()
print(paste("######## TARGET", tname))

loadEnvironments()

# library(gdata)
library(ggplot2)
library(ggfortify)

quant <- na.omit(quant)

# These match
# complete_quant <- na.omit(quant)
# print(rownames(complete_quant))
# print(rownames(quant))

print(summary(quant))

pc <- prcomp(quant, scale=TRUE, center=FALSE)
print(pc$rotation)
print(plot(pc)) 

print(PCAplot <- autoplot(pc
	, loadings.label = TRUE
	, loadings = TRUE
	, loadings.colour = "black"
	, loadings.label.colour = "blue"
	)
	+ theme_bw()
	+ ggtitle(tname)
)

scores <- as.data.frame(predict(pc))
scores <- within(scores, {
	PC1 <- PC1/mean(PC1)
})

quant$sum <- rowSums(quant)

quant$score <- scores$PC1

cor(quant$score, quant$sum)

print(summary(scores))

# -1 to drop the spuriously generated row names column
quantpca <- (merge(quant, scores, by="row.names", sort=FALSE, all=TRUE))
rownames(quantpca) <- quantpca$Row.names
quantpca <- quantpca[-1]

# row.names(quantpca)
# row.names(scores)

rdsSave(PCAplot)
saveVars(quantpca, scores, catname, pc, PCAplot)

## Not clear what Mike is doing here with two targets
## saveRDS(PCAplot, rdsname)
# wrapRTarget had (quantpca, scores, catname, pc, PCAplot)

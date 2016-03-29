cat("#######################  RTARGET ####################")

library(gdata)

quant <- na.omit(quant)

# These match
# complete_quant <- na.omit(quant)
# print(rownames(complete_quant))
# print(rownames(quant))

print(summary(quant))

quant$sum <- rowSums(quant)

pc <- prcomp(quant, scale=TRUE, center=FALSE)
print(pc$rotation)
plot(pc)

scores <- as.data.frame(predict(pc))
scores <- within(scores, {
	PC1 <- PC1/mean(PC1)
})

quant$score <- scores$PC1

cor(quant$score, quant$sum)

print(summary(scores))

# -1 to drop the spuriously generated row names column
quantpca <- (merge(quant, scores, by="row.names", sort=FALSE, all=TRUE))
rownames(quantpca) <- quantpca$Row.names
quantpca <- quantpca[-1]

# row.names(quantpca)
# row.names(scores)

# rdsave(quantpca, scores, catname, pc)

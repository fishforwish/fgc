library(ggplot2)

gg <- (ggplot(betadf
		, aes(x=reorder(variable,beta), y=beta, ymin=lower, ymax=upper, colour=inCI))
	+ geom_pointrange()
	+ scale_colour_manual(values=c("black","gray"))
	+ geom_hline(yintercept=0)
	+ coord_flip()
	+ theme_bw()
	+ ggtitle(rtargetname)
	+ xlab("predictors")
)

print(gg)


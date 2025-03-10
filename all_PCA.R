library(shellpipes)
startGraphics()

library(ggplot2)
library(ggfortify)
library(cowplot)

plist <- rdsReadList()

print(plot_grid(plist[[1]], plist[[2]], plist[[3]], plist[[4]], nrow=2))

for(i in 1:length(plist)){
	print(plist[[i]])
}

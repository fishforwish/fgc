library(ggplot2)
library(ggfortify)
library(cowplot)


plist <- list()
for(r in input_files){
	plist[[r]] <- readRDS(r)
  }

print(plot_grid(plist[[1]], plist[[2]], plist[[3]], plist[[4]], nrow=2))

for(i in seq_len(length(plist))){
	print(plist[[i]])
}


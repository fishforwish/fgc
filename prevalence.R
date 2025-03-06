
library(shellpipes); manageConflicts()
startGraphics()

library(dplyr)
library(ggplot2)
library(tidyr)
library(ggforce)

combined_dat <- rdsReadList() |> bind_rows()

groupdat <- (combined_dat
	%>% select(clusterId, CC,contains("group"))
	%>% distinct()
	%>% gather(key = type, value = prevalence, -c(CC, clusterId))
	%>% mutate_if(is.character, as.factor)
)

print(combined_dat)

print(ggplot(groupdat, aes(prevalence))
	+ facet_wrap(~interaction(CC,type), scale= "free")
	+ geom_histogram()
	+ theme_bw()
)

print(combined_dat)

for(i in seq_len(nlevels(groupdat$type))){
	print(ggplot(groupdat, aes(prevalence,group=CC))
		+ facet_wrap_paginate(~interaction(CC,type), scale = "free", ncol=2, nrow=2, page = i)
		+ geom_histogram()
		+ theme_bw()
	)
}

rdsSave(combined_dat)

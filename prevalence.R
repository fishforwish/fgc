library(dplyr)
library(ggplot2)
library(tidyr)
library(ggforce)

combined_dat <- data.frame()
for(r in input_files){
  combined_dat <- bind_rows(combined_dat, readRDS(r))
}

print(head(combined_dat))

combined_dat <- (combined_dat
	%>% mutate_if(sapply(.,is.character),as.factor)
)


groupdat <- (combined_dat
	%>% select(clusterId, CC,contains("group"))
	%>% distinct()
	%>% gather(key = type, value = prevalence, -c(CC, clusterId))
	%>% mutate_if(sapply(.,is.character),as.factor)
)

print(ggplot(groupdat, aes(prevalence))
	+ facet_wrap(~interaction(CC,type), scale= "free")
	+ geom_histogram()
	+ theme_bw()
)

for(i in seq_len(nlevels(groupdat$type))){
print(ggplot(groupdat, aes(prevalence,group=CC))
	+ facet_wrap_paginate(~interaction(CC,type), scale = "free", ncol=2, nrow=2, page = i)
	+ geom_histogram()
	+ theme_bw()
)
}
# rdsave(combined_dat)

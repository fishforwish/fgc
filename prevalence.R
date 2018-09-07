library(dplyr)
library(ggplot2)

combined_dat <- data.frame()
for(r in input_files){
  combined_dat <- bind_rows(combined_dat, readRDS(r))
}

combined_dat <- (combined_dat
	%>% mutate_if(sapply(.,is.character),as.factor)
)


print(summary(combined_dat))
groupdat <- (combined_dat
	%>% select(clusterId, contains("group"))
	%>% distinct()
)


print(summary(groupdat))

print(hist(groupdat$group_fgc))
print(hist(groupdat$group_futurefgc))
print(hist(groupdat$group_futurefgcDau))

print(hist(groupdat$group_bene))
print(hist(groupdat$group_att))
print(hist(groupdat$group_media))
print(hist(groupdat$group_edu))
print(hist(groupdat$group_wealth))

# rdsave(combined_dat)

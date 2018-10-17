##df for mcmcglmm fit

library(dplyr)

Answers <- (Answers 
  %>% mutate(id=1:nrow(.))
  )

# number of Yes/ total and then divided by the mean. 
# mean score will be 1
beneframe <- scoring(Answers, "bene", rightfactor, Answers$id)
attframe <- scoring(Answers, "att", yesnodk, Answers$id)
mediaframe <- scoring(Answers, "media", rightfactor, Answers$id)

attframe <- (attframe
	%>% mutate(gender = 1-att)
)

Answers <- (Answers
	%>% left_join(., beneframe)
	%>% left_join(., attframe)
	%>% left_join(., mediaframe)
	%>% group_by(clusterId)
	%>% mutate(
		group_fgc = mean(fgc, na.rm = TRUE)
      , group_futurefgcDau = mean(futurefgcDau01, na.rm = TRUE)
      , group_futurefgc = mean(futurefgc01, na.rm = TRUE)
	   , group_bene = mean(bene, na.rm = TRUE)
	   , group_gender = mean(gender, na.rm = TRUE)
	   , group_media = mean(media, na.rm = TRUE)
	   , group_edu = mean(edu, na.rm = TRUE)
	   , group_wealth = mean(wealth, na.rm = TRUE)
	)
)

print(hist(Answers$group_fgc))
print(hist(Answers$group_futurefgc))
print(hist(Answers$group_futurefgcDau))

print(summary(Answers))
saveRDS(Answers, rdsname)

# rdnosave

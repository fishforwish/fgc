## norm
## we want to calculate the community avg but not including the individual
## the logic to do it is:
## create the denominator (d1) by taking the number of people in the community
## create the new_numerator (n1) by taking the sum of all responses minus the individual of interest
## new_denominator (d2) = d1-1
## new group mean = new_numerator/new_denominator

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
	%>% mutate(fgc_d = sum(!is.na(fgc))
		, fgc_n = sum(fgc,na.rm=TRUE) - fgc
		, group_fgc = fgc_n/(fgc_d-1)
		, futurefgcDau_d = sum(!is.na(futurefgcDau))
		, futurefgcDau_n = sum(futurefgcDau01, na.rm=TRUE) - futurefgcDau01
      , group_futurefgcDau = futurefgcDau_n/(futurefgcDau_d-1)
		, futurefgc_d = sum(!is.na(futurefgc))
		, futurefgc_n = sum(futurefgc01, na.rm=TRUE) - futurefgc01
      , group_futurefgc = futurefgc_n/(futurefgc_d - 1)
	   , bene_d = sum(!is.na(bene))
		, bene_n = sum(bene, na.rm=TRUE) - bene
		, group_bene = bene_n/(bene_d - 1)
		, gender_d = sum(!is.na(gender))
	   , gender_n = sum(gender, na.rm = TRUE) - gender
		, group_gender = gender_n/(gender_d - 1)
		, media_d = sum(!is.na(media))
		, media_n = sum(media, na.rm=TRUE) - media
	   , group_media = media_n/(media_d - 1)
		, edu_d = sum(!is.na(edu))
		, edu_n = sum(edu, na.rm=TRUE) - edu
		, group_edu = edu_n/(edu_d - 1) 
		, wealth_d = sum(!is.na(wealth))
	   , wealth_n = sum(wealth, na.rm = TRUE) - wealth
		, group_wealth = wealth_n/ (wealth_d - 1)
	)
)

print(head(Answers,60),n=60)

print(summary(Answers))
saveRDS(Answers, rdsname)

# rdnosave

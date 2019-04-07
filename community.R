## norm
## we want to calculate the community avg but not including the individual
## the logic to do it is:
## create the denominator (d1) by taking the sum
## create the numerator (n1) by taking the mean of the group * d1
## new denominator (d2) = d1-1
## new numerator n1 - my response 

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
		, fgc_n = mean(fgc,na.rm=TRUE)*fgc_d - fgc
		, group_fgc = fgc_n/(fgc_d-1)
		, futurefgcDau_d = sum(!is.na(futurefgcDau))
		, futurefgcDau_n = mean(futurefgcDau01, na.rm=TRUE)*futurefgcDau_d - futurefgcDau01
      , group_futurefgcDau = futurefgcDau_n/(futurefgcDau_d-1)
		, futurefgc_d = sum(!is.na(futurefgc))
		, futurefgc_n = mean(futurefgc01, na.rm=TRUE)*futurefgc_d - futurefgc01
      , group_futurefgc = futurefgc_n/(futurefgc_d - 1)
	   , bene_d = sum(!is.na(bene))
		, bene_n = mean(bene, na.rm=TRUE)*bene_d - bene
		, group_bene = bene_n/(bene_d - 1)
		, gender_d = sum(!is.na(gender))
	   , gender_n = mean(gender, na.rm = TRUE)
		, group_gender = gender_n/(gender_d - 1)
		, media_d = sum(!is.na(media))
		, media_n = mean(media, na.rm=TRUE)*media_d - media
	   , group_media = media_n/(media_d - 1)
		, edu_d = sum(!is.na(edu))
		, edu_n = mean(edu, na.rm=TRUE)*edu_d - edu
		, group_edu = edu_n/(edu_d - 1) 
		, wealth_d = sum(!is.na(wealth))
	   , wealth_n = mean(wealth, na.rm = TRUE)*wealth_d - wealth
		, group_wealth = wealth_n/ (wealth_d - 1)
	)
)

print(head(Answers,60),n=60)

print(summary(Answers))
saveRDS(Answers, rdsname)

# rdnosave


library(shellpipes); manageConflicts()

loadEnvironments()
Answers <- rdsRead()

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
	%>% mutate(genderAware = 1-att)
)

Answers <- (Answers
	%>% left_join(., beneframe)
	%>% left_join(., attframe)
	%>% left_join(., mediaframe)
	%>% group_by(clusterId)
	%>% mutate(fgc_d = sum(!is.na(fgc))
		, fgc_n = sum(fgc,na.rm=TRUE) - fgc
		, group_fgc = fgc_n/(fgc_d-1)
		, daughterPlan_d = sum(!is.na(daughterPlan))
		, daughterPlan_n = sum(daughterPlan01, na.rm=TRUE) - daughterPlan01
      , group_daughterPlan = daughterPlan_n/(daughterPlan_d-1)
		, Persist_d = sum(!is.na(Persist))
		, Persist_n = sum(Persist01, na.rm=TRUE) - Persist01
      , group_Persist = Persist_n/(Persist_d - 1)
	   , bene_d = sum(!is.na(bene))
		, bene_n = sum(bene, na.rm=TRUE) - bene
		, group_bene = bene_n/(bene_d - 1)
		, genderAware_d = sum(!is.na(genderAware))
	   , genderAware_n = sum(genderAware, na.rm = TRUE) - genderAware
		, group_genderAware = genderAware_n/(genderAware_d - 1)
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

rdsSave(Answers)


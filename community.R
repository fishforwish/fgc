##df for mcmcglmm fit

library(dplyr)

Answers <- (Answers 
  %>% mutate(id=1:nrow(.))
  )
																			 
																			 
beneframe <- scoring(Answers, "beneframe", rightfactor, Answers$id)
attframe <- scoring(Answers, "attframe", yesnodk, Answers$id)
mediaframe <- scoring(Answers, "mediaframe", rightfactor, Answers$id)

Answers <- (Answers
	%>% left_join(., beneframe)
	%>% left_join(., attframe)
	%>% left_join(., mediaframe)
	%>% group_by(clusterId)
	%>% mutate(group_benef = mean(beneframe, na.rm = TRUE)
		, group_attf = mean(attframe, na.rm = TRUE)
		, group_mediaf = mean(mediaframe, na.rm = TRUE)
		)
)

# rdsave(Answers)
saveRDS(Answers, rdsname)

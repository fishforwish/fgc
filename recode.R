## Recode problematic DHS entries

library(shellpipes); manageConflicts()
loadEnvironments()

## library(gdata)
library(dplyr)

Answers <- (Answers
## subset: Don't want people who never heard of FGC (heardFGC and heardGC) and visitors
	%>% filter((!is.na(heardFGC) & substr(heardFGC, 1, 3) == "Yes")
		| (!is.na(heardGC) & substr(heardGC, 1, 3) == "Yes")
		)
	%>% filter(!is.na(visitorResident) & !grepl("Visitor", visitorResident))
)

## Maybe use G116 daughterToFgc as the main response variable for daughterFuture analysis

Answers <- (Answers
	%>% mutate(
		daughterFgced = if_else(is.numeric(numDaughterFgced) 
			& as.numeric(numDaughterFgced) > 0 
			& as.numeric(numDaughterFgced) < 90
			, "Yes", "No"
		)
		, daughterFgced = if_else(is.na(numDaughterFgced), as.character(NA), daughterFgced)
		, daughterFgced = factor(daughterFgced)
		, continueFgc = ifelse(continueFgc == "Don't know", "Depends", as.character(continueFgc))
		, continueFgc = factor(continueFgc)
		, daughterNotFgced = ifelse(daughterNotFgced == "Don't know", NA, as.character(daughterNotFgced))
		, daughterNotFgced = factor(daughterNotFgced)
		, CC = substring(survey, 1, 2)
		, CC = as.factor(CC)
		, recode = substring(survey, 3, 3)
		, recode = as.numeric(recode)
		, region = as.factor(paste(CC, region, sep="_"))
		, clusterId = as.factor(paste(survey, clusterId, sep="_"))
	  , ethni = as.factor(paste(CC, ethni, sep="_"))
    , religion = tableRecode(religion, "religion", maxCat=4)
    , maritalStat = tableRecode(maritalStat, "partnership", maxCat=4)
    , wealth = wealth/100000
		, fgcstatus = fgc
		, fgc = rightfactor(fgc)
		, Education = edu
		, edu = rightfactor(edu)
		, edu = edu / mean(edu, na.rm = TRUE)
		, Persist = contfgc(continueFgc)
		, Persist01 = contfgc01(continueFgc)
		, daughterPlan = yesnodkFactor(daughterToFgc)
		, daughterPlan01 = yesnodk01(daughterToFgc)
		, Religion = religion
		, MaritalStatus = maritalStat
		, Residence = urRural
		, Job = job
		)
)

summary(Answers)
rdsSave(Answers)

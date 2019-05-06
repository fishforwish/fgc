## Recode all problematic DHS entries

print("#######################  RTARGET ####################")
library(gdata)
library(dplyr)
## Reweight before subsetting.

Answers <- (Answers
## Reweight before subsetting
	%>% mutate(sampleWeight = sampleWeight/sum(sampleWeight))
## subset: Don't want people who never heard of FGC (heardFGC and heardGC) and visitors
	%>% filter((!is.na(heardFGC) & substr(heardFGC, 1, 3) == "Yes")
		| (!is.na(heardGC) & substr(heardGC, 1, 3) == "Yes")
		)
	%>% filter(!is.na(visitorResident) & !grepl("Visitor", visitorResident))
)


# Ideally, I like to have a variable as daughterFGC (daughter's FGC status) which involves a few variables:  numDaughterFgced (already cut; 95 and 0=none cut), and daughterToFgc.  Those variables provides answers of yes (already cut), no (none cut), plan to cut, plan not to be cut, and don't know the plan yet.  I like to make it a single outcome measurement with 6 levels: yes/to be cut, yes/not to be cut, no/to be cut, no/not to be cut, yes/don't know, no/don't know.

Answers <- (Answers
	%>% mutate(daughterFgced = ifelse(numDaughterFgced == 95, "No", "Yes")
		, daughterFgced = ifelse(numDaughterFgced == 0, "Yes", daughterFgced)
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
		)
)

# rdsave(Answers)

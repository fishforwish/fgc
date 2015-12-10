print("#######################  RTARGET ####################")
library(gdata)

## Reweight before subsetting.
Answers <- within(Answers, {
	sampleWeight <- sampleWeight/sum(sampleWeight)
})

## subsets
# Don't want people who never heard of FGC (heardFGC and heardGC) and visitors:
Answers <- subset(Answers,
	(!is.na(heardFGC) & substr(heardFGC, 1, 3)=="Yes") |
	(!is.na(heardGC) & substr(heardGC, 1, 3)=="Yes")
)
Answers <- subset(Answers,
	!is.na(visitorResident) & !grepl("Visitor", visitorResident)
)

# Ideally, I like to have a variable as daughterFGC (daughter's FGC status) which involves a few variables:  numDaughterFgced (already cut; 95 and 0=none cut), and daughterToFgc.  Those variables provides answers of yes (already cut), no (none cut), plan to cut, plan not to be cut, and don't know the plan yet.  I like to make it a single outcome measurement with 6 levels: yes/to be cut, yes/not to be cut, no/to be cut, no/not to be cut, yes/don't know, no/don't know.

Answers <- within(Answers, {

	# make numDaughterFgced as a binary:
	daughterFgced <- ifelse(numDaughterFgced==95, "No", "Yes")
	daughterFgced[numDaughterFgced==0] <- "Yes"
	daughterFgced <- as.factor(daughterFgced)

	if(sum(!is.na(continueFgc))>0){
		levels(continueFgc)[levels(continueFgc)=="Don't know"] <- "Depends"
	}

	if(sum(!is.na(daughterNotFgced))>0){
		levels(daughterNotFgced)[levels(daughterNotFgced)=="Don't know"] <- NA}
})

Answers <- within(Answers, {
	CC <- substring(survey, 1, 2)
	CC <- as.factor(CC)
	recode <- as.numeric(substring(survey, 3, 3))
})

Answers <- within(Answers, {
	region <- as.factor(paste(CC, region, sep="_"))
	clusterId <- as.factor(paste(survey, clusterId, sep="_"))

	ethni <- as.factor(paste(CC, ethni, sep="_"))

	religion <- tableRecode(religion, "religion", maxCat=4)

	maritalStat <- tableRecode(maritalStat, "partnership", maxCat=4)

	wealth <- wealth/100000

	# Make cluster ID into a factor!
	clusterId <- as.factor(clusterId)
})

# rdsave(Answers)

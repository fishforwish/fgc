library(shellpipes)

loadEnvironments()

vtypef <- function(v){
	if (grepl("beneHygiene", v)) {return("beneHygiene")}
	if (grepl("beneAcceptance", v)) {return("beneAcceptance")}
	if (grepl("beneMarriage", v)) {return("beneMarriage")}
	if (grepl("benePreventPreSex", v)) {return("benePreventPreSex")}
	if (grepl("benePleasureM", v)) {return("benePleasureM")}
	if (grepl("beneReligion", v)) {return("beneReligion")}
	if (grepl("beneRedPromis", v)) {return("beneRedPromis")}
	if (grepl("beneRedSTD", v)) {return("beneRedSTD")}
	if (grepl("beneOther", v)) {return("beneOther")}
	return("WHAT_IS_THIS")
}

print(v <- sapply(rownames(pc$rotation), vtypef))
# rownames or row.names?

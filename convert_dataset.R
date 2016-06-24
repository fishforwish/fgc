library(foreign)

if (!exists("input_files"))
	stop(paste("No input file defined for", rtargetname))

df <- read.spss(input_files[[1]], to.data.frame=TRUE)

vl <- attr(df, "variable.labels")

n <- names(df)
n <- sub("^MV", "V", n)
n <- sub("^SM", "S", n)
n <- sub("^FGM", "FG", n)
n <- sub("^MCASEID", "CASEID", n)

names(df) <- n
names(vl) <- names(df)
Answers <- data.frame(row.names=rownames(df))
Questions <- character(0)
Dropped <- character(0)

for (n in names(df)){
	if(sum(!is.na(df[[n]])>0)){
		Answers[[n]] <- df[[n]]
		Questions[[n]] <- vl[[n]]
	} else {
		Dropped[[n]] <- vl[[n]]
	}
}
# rdsave(Answers, Questions, Dropped)

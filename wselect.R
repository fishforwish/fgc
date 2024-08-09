
library(shellpipes)

loadEnvironments()
 
raw <- readLines(matchFile(ext="csv"))
sel <- grep("^[^#]", raw, value=TRUE)
 
NewAnswers <- data.frame(row.names=row.names(Answers))
NewQuestions <- character(0)
 
for (s in sel){
	l <- scan(text=s, sep=",", what="character",
		strip.white=TRUE, quiet=TRUE
	)
 
	new <- l[[1]]
 
	if (new %in% names(NewAnswers)){
		stop("Replicated new name ", s, " in .csv")
	}
 
	pick <- intersect(l[-1], names(Answers))
	if (length(pick) > 0) {
		if (length(pick) > 1) {
			print(paste("Multiple matches to ", s, "in .csv:"))
		}
		for (p in 1:length(pick)){
			sel <- ifelse(p==1, "Selected: ", "Not used: ")
			print(paste("** ", sel, pick[[p]], Questions[[pick[[p]]]]))
		}
	}
	if (length(pick)>=1) {
		NewAnswers[[new]] <- Answers[[pick[[1]]]]
		NewQuestions[[new]] <- Questions[[pick[[1]]]]
	}
	if (length(pick)==0){
		NewQuestions[[new]] <- NA
		NewAnswers[[new]] <- NA
		print(paste("Did not find variable ", s, "in .csv"))
	}
}
 
Answers <- NewAnswers
Questions <- NewQuestions
 
print(data.frame(Question=Questions))
 
saveVars(Answers, Questions)

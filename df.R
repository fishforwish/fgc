##df for mcmcglmm fit

library(dplyr)

Answers <- (Answers 
  %>% mutate(id=1:nrow(.))
  )

scoring <- function(dat, type,funct,idvec=NULL,colnam=NULL){
	if(is.null(colnam)) colnam = type
	if(!is.null(idvec))(dat <- dat %>% filter(id %in% idvec))
	if(is.null(idvec)) idvec <- 1:nrow(dat)
	typeNames <- grepl(type, names(Answers))
	cols <- sum(typeNames)
	tempdat <- (dat[typeNames] 
		%>% rowwise()
		%>% summarise_each(funs(funct)) 
		%>% mutate(id=idvec) 
		%>% transmute(total = rowMeans(.[,1:cols],na.rm=TRUE)
			, id=id
			)
		%>% ungroup() 
		%>% mutate(Score=total/mean(total,na.rm=TRUE)) 
		%>% select(-total)
		)
	colnames(tempdat) <- c("id", colnam)
	return(tempdat)
}
																			 
																			 
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

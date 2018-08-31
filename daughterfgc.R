library(dplyr)

yesnodk <- function(x){
  y <- as.numeric(factor(x,levels(x)[c(1,3,2)]))-1
  return(y)
}

yesnodkFactor <- function(x){
  y <- factor(x,levels(x)[c(1,3,2)])
  return(y)
}

contfgc <- function(x){
  y <- factor(x,levels(x)[c(2,3,1)])
  return(y)
}

rightfactor <- function(x){
  y <- as.numeric(x)-1
  return(y)
}

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


beneframe <- scoring(Answers, "bene", rightfactor, Answers$id)
attframe <- scoring(Answers, "att", yesnodk, Answers$id)
mediaframe <- scoring(Answers, "media", rightfactor, Answers$id)


covDat <- (Answers
	%>% select(fgc, clusterId, age, id, edu, wealth, ethni
		, religion , maritalStat, job, urRural
		)
	%>% left_join(., beneframe, by = "id")
	%>% left_join(., attframe, by = "id")
	%>% left_join(., mediaframe, by = "id")
	%>% mutate(fgcstatusMom = fgc
		, fgc = rightfactor(fgc)
		, edu = rightfactor(edu)
		, edu = edu / mean(edu, na.rm = TRUE)
		)
	%>% group_by(clusterId)
	%>% mutate(group_bene = mean(bene, na.rm = TRUE)
		, group_att = mean(att, na.rm = TRUE)
		, group_media = mean(media, na.rm = TRUE)
		, group_fgc = mean(fgc, na.rm = TRUE)
		, group_edu = mean(edu, na.rm = TRUE)
		, group_wealth = mean(wealth, na.rm = TRUE)
		)
  %>% select(-fgc)
)


responseDat <- (Answers 
  %>% select(c(daughterToFgc,id)) 
  %>% mutate(futurefgcDau = yesnodkFactor(daughterToFgc)
  ) 
  %>% select(-c(daughterToFgc))
)

combinedDat <- (left_join(responseDat,covDat,by="id") 
  %>% filter(complete.cases(.)) 
)



# rdsave(combinedDat)

summary(combinedDat)

saveRDS(combinedDat, rdsname)

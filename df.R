##df for mcmcglmm fit

library(dplyr)
##Response: 
## Y1 = overall FGC future (continueFgc) 
## Y2 = daughter's future fgc status (daughterToFgc)

yesnodk <- function(x){
	y <- as.numeric(factor(x,levels(x)[c(1,3,2)]))-1
	return(y)
}

yesnodk2 <- function(x){
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
	tempdat <- dat[typeNames] %>% 
	  rowwise() %>% 
	  summarise_each(funs(funct)) %>%
	  mutate(id=idvec) %>% 
	  transmute(total = rowMeans(.[,1:cols],na.rm=TRUE)
	            , id=id) %>%
	  ungroup() %>%
	  mutate(Score=total/mean(total,na.rm=TRUE)) %>% 
	  select(-total)
	colnames(tempdat) <- c("id", colnam)
	return(tempdat)
}

Answers <- Answers %>% mutate(id=1:nrow(.))

responseDat <- Answers %>%  
	select(c(continueFgc,daughterToFgc,id)) %>%
	mutate(futurefgc = contfgc(continueFgc),
	       futurefgcDau = yesnodk2(daughterToFgc)) %>%
	select(-c(continueFgc,daughterToFgc)) 
	
covDat <- (Answers
	%>% select(c(
	  fgc,clusterId,age,id,edu,wealth,ethni
	 ,religion,maritalStat, job,urRural,CC,beneAcceptance,attArgue,mediaRadio 
	))
	%>% mutate(fgcstatusMom = rightfactor(fgc))
	%>% select(-fgc)
)

tempcombDat <- left_join(responseDat,covDat,by="id") %>% 
  filter(complete.cases(.)) %>% select(-c(beneAcceptance,attArgue,mediaRadio))


beneframe <- scoring(Answers,"bene",rightfactor,tempcombDat$id)
attframe <- scoring(Answers,"att",yesnodk,tempcombDat$id)
mediaframe <- scoring(Answers, "media",rightfactor,tempcombDat$id)



combinedDat <- tempcombDat %>% 
	left_join(.,beneframe,by="id") %>%
	left_join(.,attframe,by="id") %>%
	left_join(.,mediaframe, by= "id")

combinedDat <- (combinedDat %>%
	group_by(clusterId)
	%>% mutate(
		group_bene = mean(bene,na.rm=TRUE)
	  	, group_att = mean(att,na.rm=TRUE)
	  	, group_media= mean(media,na.rm=TRUE)
	  	, group_fgc= mean(fgcstatusMom,na.rm=TRUE)
	)
)

# rdsave(combinedDat)
## need JD's help, brute force atm

summary(combinedDat)

saveRDS(combinedDat, rdsname)


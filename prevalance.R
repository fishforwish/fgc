library(dplyr)
library(ggplot2)

for (r in grep("Rds$", input_files, value=TRUE)){
  if (exists("dat"))
    dat <- rbind(dat, readRDS(r))
  else
    dat <- readRDS(r)
}

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

print(summary(dat))

groupdat <- (dat
	%>% select(fgc, daughterToFgc, clusterId, age, id, edu, wealth, ethni
		, religion, maritalStat, job, urRural
		, beneframe, attframe, mediaframe 
	)
	%>% mutate(fgcstatusMom = fgc
		, fgc = rightfactor(fgc)
		, edu = rightfactor(edu)
		, edu = edu / mean(edu, na.rm = TRUE)
		, daughterToFgc = yesnodk(daughterToFgc)
		)
	%>% group_by(clusterId)
	%>% summarise(group_fgc = mean(fgc, na.rm = TRUE)
		, group_daughterToFgc = mean(daughterToFgc, na.rm = TRUE)
		, group_bene = mean(beneframe, na.rm = TRUE)
		, group_att = mean(attframe, na.rm = TRUE)
		, group_media = mean(mediaframe, na.rm = TRUE)
		, group_edu = mean(edu, na.rm = TRUE)
		, group_wealth = mean(wealth, na.rm = TRUE)
		)
)

print(hist(groupdat$group_fgc))
print(hist(groupdat$group_daughterToFgc))
#print(hist(groupdat$group_bene))
#print(hist(groupdat$group_att))
#print(hist(groupdat$group_media))
#print(hist(groupdat$group_edu))
#print(hist(groupdat$group_wealth))


## Helper functions to recode DHS answers

library(shellpipes)


tfun <- function(q, qmax, qmin=-1e7, dk=98, nalist=c(99)){
	q[q==dk] <- qmax
	q[q>qmax] <- qmax
	q[q<qmin] <- qmin
	return(q)
}

tableRecode <- function(v, tableName, 
	matchStart=FALSE, matchEnd=FALSE, matchCase=FALSE, maxCat=NULL
){
	inf <- grep(tableName, fileSelect(), value=1)
	if(length(inf)!=1){
		stop("Wrong number of ", tableName, " files in: ", paste(fileSelect(), collapse=" "))
	}
	tab <- read.table(inf, sep=":", strip.white=TRUE, header=FALSE,
		stringsAsFactors=FALSE, na.strings=""
	)

	v <- as.character(v)
	w <- rep(NA, length(v))

	for(r in 1:nrow(tab)){
		s <- tab[r, 1]
		if(matchStart) 
			s <- sub("^", "^", s)
		if(matchEnd)
			s <- sub("$", "$", s)

		z <- grepl(s, v, ignore.case=!matchCase, useBytes=TRUE)

		conflict <- z & !is.na(w) & w != tab[r, 2]
		if(sum(conflict) > 0){
			stop("Conflicting matches for",
				sub("^", " * ", unique(v[conflict]))
			)
		}

		if(sum(z)>0){
			print(paste("Replacing: {{",
				paste(unique(v[z]), collapse="|"), 
				"}} with ", tab[r, 2]
			))
			w[z] <- tab[r, 2]
		}
	}

	none <- is.na(w) & !is.na(v)
	if(sum(none) > 0){
		stop("No matches for ", 
				sub("(.*)", "* |\\1| ", unique(v[none]))
		)
	}

	w[w=="NA"] <- NA
	w <- as.factor(w)

	if(!is.null(maxCat))
		if(length(levels(w))>maxCat)
			stop("Too many levels", paste(levels(w), collapse=" : "))
	return(w)
}

scoring <- function(dat, type,funct,idvec=NULL,colnam=NULL){
  if(is.null(colnam)) colnam = type
  if(!is.null(idvec))(dat <- dat %>% filter(id %in% idvec))
  if(is.null(idvec)) idvec <- 1:nrow(dat)
  typeNames <- grepl(type, names(dat))
  cols <- sum(typeNames)
  tempdat <- (dat[typeNames] 
              %>% rowwise()
              %>% summarise_each(funs(funct)) 
              %>% mutate(id=idvec) 
              %>% transmute(total = rowMeans(.[,1:cols],na.rm=TRUE)
                            , id=id
              )
              %>% ungroup() 
              %>% mutate(Score=total/max(total,na.rm=TRUE)) 
              %>% select(-total)
  )
  colnames(tempdat) <- c("id", colnam)
  return(tempdat)
}

yesnodk <- function(x){
  y <- as.numeric(yesnodkFactor(x))-1
  return(y)
}

yesnodk01 <- function(x){
  yesnodk(x)/max(yesnodk(x),na.rm=TRUE)
}

yesnodkFactor <- function(x){
  y <- factor(x,levels = c("No", "Don't know", "Yes"))
  return(y)
}

contfgc <- function(x){
  y <- factor(x,levels=c("Discontinued","Depends","Continued"))
  return(y)
}

contfgc01 <- function(x){
  y = as.numeric(contfgc(x)) -1
  return(y/max(y, na.rm=TRUE))
}

rightfactor <- function(x){
  y <- as.numeric(x)-1
  return(y)
}

saveEnvironment()

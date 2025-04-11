
library(shellpipes)

## This code does not apparently do anything?
rtargetname <- targetname()
resp_mod <- unlist(strsplit(unlist(strsplit(rtargetname,"[.]"))[1],"_"))
resp <- NULL
if(resp_mod[1] == "daughterfgc"){resp = "Daughter FGC"}
if(resp_mod[1] == "futurefgc"){resp = "Future FGC"}
if(resp_mod[1] == "futurefgcDau"){resp = "Future Daughter FGC"}

sigName <- function(n, P){
  if(!is.null(P)){
    Pstr <- sprintf("(P=%5.3f)", P)
    Pstr <- sub("=0.000", "<0.001", Pstr)
    n <- paste(n, Pstr)
    if(P<0.05) n <- paste(n, "*", sep="")
    if(P<0.01) n <- paste(n, "*", sep="")
  }
  return(n)
}

numplot <- function(pf, xname, ylab=resp, P=NULL){
  xname <- sigName(xname, P)
  (qplot(pf[[1]], fit, data=pf,
         geom="line", xlab=xname, ylab=ylab
  )
  + geom_line(aes(y=lwr),lty=2)
  + geom_line(aes(y=upr),lty=2)
  )
}

fplot <- function(pf, xname, ylab=resp, P=NULL){
  lNames <- levels(pf[[1]])
  
  for(rn in rownames(catNames)){
    lNames <- sub(rn, catNames[[rn, 1]], lNames)
  }
  
  levels(pf[[1]]) <- lNames
  
  xname <- sigName(xname, P)
  
  qplot(pf[[1]], fit,
        ymin=lwr,ymax=upr,  
        geom="pointrange", data=pf,
        xlab=xname, ylab=ylab
  ) + theme(axis.text.x = element_text(size=6,angle = 30, hjust = 1))
}

varPlot <- function(pf, ylab=resp, P=NULL){
  if(is.numeric(pf[[1]])){
    numplot(pf, names(pf)[[1]], ylab, P)
  } else {
    fplot(pf, names(pf)[[1]], ylab, P)
  }
}

panelPlot <- function(pf, r, c, ylab=resp, P=NULL){
  varNames <- names(pf)[[1]]
  
  for(rn in rownames(predNames)){
    varNames <- sub(rn, predNames[[rn, 1]], varNames)
  }
  
  if(is.numeric(pf[[1]])){
    p <- numplot(pf, varNames, ylab=ylab, P=P)
  } else {
    p <- fplot(pf, varNames, ylab=ylab, P=P)
  }
  print(p, vp=viewport(
    layout.pos.row = r, layout.pos.col = c
  ))
}

listPlot <- function(predList, ylab=resp){
  lapply(predList, varPlot, ylab=ylab)
}


saveEnvironment()

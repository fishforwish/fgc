ordTrans <- function(v, a){
  sapply(v, function(n){
    return(sum(plogis(n-a)))
  })
}

ordpred <- function(mod, n, modAns){
  v <- varpred(mod, n, modAns, isolate=TRUE)
  v$fit <- ordTrans(v$fit, mod$alpha)
  v$lwr <- ordTrans(v$lwr, mod$alpha)
  v$upr <- ordTrans(v$upr, mod$alpha)
  return(v)
}


varpred <- function(mod, varname, frame, isolate=FALSE, isoValue=NULL, level=0.05, steps=101, dfspec=100, vv=NULL){
  # Service functions
  eff <- function(mod){
    if (inherits(mod, "lm")) return (coef(mod))
    if (inherits(mod, "mer")) return (fixef(mod))
    if (inherits(mod, "clmm"))
    {
      ef <- c(0, mod$beta)
      names(ef) <- c("(Intercept)", names(mod$beta))
      return (ef)
    }
    stop("Don't recognize model type")
  }
  
  varfun <- function(vcol, steps){
    if(is.numeric(vcol)){
      if(is.null(steps)){return(sort(unique(vcol)))}
      return(seq(min(vcol), max(vcol), length.out=steps))
    }
    return(unique(vcol))
  }
  
  # Stats
  df <- ifelse(
    grepl("df.residual", paste(names(mod), collapse="")), 
    mod$df.residual, dfspec
  )
  mult <- qt(1-level/2, df)
  
  # Eliminate rows that were not used
  rframe <- frame[rownames(model.frame(mod)), ]
  
  # Find variable in data frame
  # ISSUE: Can't have a variable name that's a subset of another name
  pat <- paste("\\b", varname, sep="")
  fnames <- names(rframe)
  
  # print(pat); print(fnames)
  fCol <- grep(pat, fnames)
  
  print(paste("Selected variable", fnames[fCol]))
  if(length(fCol)<1) {
    stop(paste("No matches to", varname, "in the frame", collapse=" "))
  }
  if(length(fCol)>1) {
    stop(paste("Too many matches:", fnames[fCol], collapse=" "))
  }
  
  if(is.null(vv)) {vv <- varfun(rframe[[fCol]], steps)}
  steps <- length(vv)
  
  # Mean row of model matrix
  modTerms <- delete.response(terms(mod))
  mm <- model.matrix(modTerms, rframe)
  rowbar<-matrix(apply(mm, 2, mean), nrow=1)
  mmbar<-rowbar[rep(1, steps), ]
  
  # Find variable in model matrix
  mmNames <- colnames(mm)
  mmCols <- grep(pat, mmNames)
  print(paste(c("Selected columns:", mmNames[mmCols], "from the model matrix"), collapse=" "))
  if (length(mmCols)<1) 
    stop(paste("No matches to", varname, "in the model matrix", collapse=" "))
  
  # Model matrix with progression of focal variable 
  varframe <- rframe[rep(1, steps), ]
  varframe[fCol] <- vv
  mmvar <- mmbar
  mmnew <- model.matrix(modTerms, varframe)
  
  for(c in mmCols){
    mmvar[, c] <- mmnew[, c]
  }
  
  ef <- eff(mod)
  vc <- vcov(mod)
  if (inherits(mod, "clmm")){
    f <- c(names(mod$alpha)[[1]], names(mod$beta))
    vc <- vc[f, f]
  }
  
  if(!identical(colnames(mm), names(ef))){
    print(setdiff(colnames(mm), names(ef)))
    print(setdiff(names(ef), colnames(mm)))
    stop("Effect names do not match: check for empty factor levels?")
  }
  pred <- mmvar %*% eff(mod)
  
  # (Centered) predictions for SEs
  if (isolate) {
    if(!is.null(isoValue)){
      rframe[fCol] <- 0*rframe[fCol]+isoValue	
      mm <- model.matrix(modTerms, rframe)
      rowbar<-matrix(apply(mm, 2, mean), nrow=1)
      mmbar<-rowbar[rep(1, steps), ]
    }
    mmvar <- mmvar-mmbar
  }
  
  pse_var <- sqrt(diag(mmvar %*% tcrossprod(vc, mmvar)))
  
  df <- data.frame(
    var = vv,
    fit = pred,
    lwr = pred-mult*pse_var,
    upr = pred+mult*pse_var
  )
  names(df)[[1]] <- varname
  return(df)
}
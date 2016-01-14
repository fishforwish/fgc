library(cpcbp)

ke5 <- readRDS("ke5.mediaQuant.RDS")
ml5 <- readRDS("ml5.mediaQuant.RDS")
ng5 <- readRDS("ng5.mediaQuant.RDS")
sl5 <- readRDS("sl5.mediaQuant.RDS")

## deal with NAs?

ke5 <- ke5[complete.cases(ke5),]
ml5 <- ml5[complete.cases(ml5),]
ng5 <- ng5[complete.cases(ng5),]
sl5 <- sl5[complete.cases(sl5),]


dat <- list(ke5,ml5,ng5,sl5)

vardat <- lapply(dat,var)
ndat <- unlist(lapply(dat,nrow))
ndat2 <- lapply(dat,nrow)

class(ndat)

mediacpc <- new_cpc(vardat,n=ndat)

evals <- list()
covs <- list()
for (j in 1:4) {
  evals[[j]] <- diag(t(mediacpc) %*% vardat[[j]] %*% 
                       mediacpc)
  covs[[j]] <- mediacpc %*% diag(evals[[j]]) %*% 
    t(mediacpc)
}

evals
covs

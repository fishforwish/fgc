library(dplyr)
library(ggplot2)

mod1 <- futurefgc_ind
mod2 <- futurefgc_full

q <- c(0.025,0.05,0.25,0.5,0.75,0.95,0.975)

ind <- data.frame(mod1$Sol)
ind <- (ind 
  %>% select(c(fgcstatusMom
    , bene
    , media
    , att
    , edu)
    )
)

indsum<-apply(ind2,2,function(v){quantile(v,q)})


full <- data.frame(mod2$Sol)
full <- (full 
  %>% select(c(fgcstatusMom
  , bene
  , media
  , att
  , edu
  , group_bene
  , group_att
  , group_media
  , group_fgc
  , group_edu)
  )
)

fullsum<-apply(full,2,function(v){quantile(v,q)})



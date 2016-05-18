library(MCMCglmm)
library(dplyr)
library(ggplot2)
input_files <- c("all_countries_futurefgc", "ke5.futurefgc.Rds", "ng5.futurefgc.Rds", "sl5.futurefgc.Rds", "ml5.futurefgc.Rds")
for (r in grep("Rds$", input_files, value=TRUE)){
  if (exists("dat"))
    dat <- rbind(dat, readRDS(r))
  else
    dat <- readRDS(r)
}

load(".all.futurefgc.RData")

predsd <- (dat
  %>% ungroup()
  %>% summarise_each(funs(sd))
)

ind_df <- data.frame(futurefgc_ind$Sol)
full_df <- data.frame(futurefgc_full$Sol)

adjust <- function(x,sddf,df){
  tempvec <- df[,x]*t(sddf[,x])
  return(tempvec)
}

q <- c(0.025,0.05,0.25,0.5,0.75,0.95,0.975)

pred_ind <- c("fgcstatusMom","bene","att","media","edu")
pred_full <- c("fgcstatusMom","group_fgcstatusMom"
               , "bene", "group_bene" 
               , "att", "group_att"
               , "media", "group_media"
               , "edu", "group_edu")
pred_ind <- c("fgcstatusMom","bene","att","media","edu")
adjust_ind <- (adjust(pred_ind,predsd,ind_df) 
  %>% summarise_each(funs(mean))
)

print(adjust_ind)
adjust_full <- (adjust(pred_full,predsd,full_df) 
  %>% summarise_each(funs(mean))
)

print(adjust_full)

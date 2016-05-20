library(MCMCglmm)
library(dplyr)
library(ggplot2)

pred_ind <- c("fgcstatusMom","bene","att","media","edu")
pred_full <- c("fgcstatusMom","group_fgcstatusMom"
               , "bene", "group_bene" 
               , "att", "group_att"
               , "media", "group_media"
               , "edu", "group_edu")

predsd_ind <- (dat
  %>% ungroup() 
  %>% select(c(fgcstatusMom,bene,att,media,edu))
  %>% summarise_each(funs(sd))
)

print(predsd_ind)
# 
# ind_df <- data.frame(futurefgc_ind$Sol)
# full_df <- data.frame(futurefgc_full$Sol)
# 
# q <- c(0.025,0.05,0.25,0.5,0.75,0.95,0.975)
# 
# pred_ind <- c("fgcstatusMom","bene","att","media","edu")
# pred_full <- c("fgcstatusMom","group_fgcstatusMom"
#                , "bene", "group_bene" 
#                , "att", "group_att"
#                , "media", "group_media"
#                , "edu", "group_edu")
# 
# 
# adjust_ind <- (adjust(pred_ind,predsd,ind_df) 
#   %>% summarise_each(funs(mean))
# )
# 
# print(adjust_ind)
# adjust_full <- (adjust(pred_full,predsd,full_df) 
#   %>% summarise_each(funs(mean))
# )
# 
# print(adjust_full)

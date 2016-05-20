library(MCMCglmm)
library(dplyr)
library(tidyr)
library(reshape2)

load(".all.futurefgcDau.RData")
pred_ind <- c("fgcstatusMom","futurefgc","bene","att","media","edu")
pred_full <- c("fgcstatusMom","group_fgcstatusMom"
               , "futurefgc", "group_futurefgc"
               , "bene", "group_bene" 
               , "att", "group_att"
               , "media", "group_media"
               , "edu", "group_edu")
interval <- c("post.mean","l-95% CI","u-95% CI")
predsd_ind <- (dat
               %>% ungroup() 
               %>% select(c(fgcstatusMom,bene,att,media,edu))
               %>% summarise_each(funs(sd))
)

ind_df <- summary(futurefgcDau_ind)$solution[pred_ind,interval]

ind_scaled <- as.numeric(predsd_ind)*ind_df
ind_scaled <- data.frame(ind_scaled
                         , model="ind"
                         , type=row.names(ind_scaled)
                         , cov=row.names(ind_scaled))

predsd_full <- (dat
                %>% ungroup() 
                %>% select(c(fgcstatusMom, group_fgcstatusMom
                             , bene, group_bene
                             , att, group_att
                             , media, group_media
                             , edu, group_edu)
                )
                %>% summarise_each(funs(sd))
)

full_df <- summary(futurefgcDau_full)$solution[pred_full,interval]
full_scaled <- as.numeric(predsd_full)*full_df
full_scaled <- data.frame(full_scaled
                          , model="full"
                          , type=rep(row.names(ind_scaled),each=2)
                          , cov=row.names(full_scaled))

all_df <- rbind(ind_scaled,full_scaled)

melt_df <- melt(all_df,id.vars = c("model","type","cov"))
futurefgcDau_df <- (melt_df 
                 %>% unite(model_cov,model,cov)
                 %>% mutate(model="futurefgcDau")
)



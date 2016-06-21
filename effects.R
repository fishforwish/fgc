library(ordinal)
library(effects)
library(splines)
library(dplyr)
library(ggplot2)

# all <- allEffects(mod=futurefgc_full)

sum.df <- function(modobj,mod,model){
  pred_full <- c("futurefgc", "group_futurefgc"
                 , "fgcstatusMom","group_fgcstatusMom"
                 , "bene", "group_bene" 
                 , "att", "group_att"
                 , "media", "group_media"
                 , "edu", "group_edu")
  tempdf <- data.frame(Est=confint(modobj,level=0)[,1]
                       , Lower=confint(modobj,level=0.95)[,1]
                       , Upper=confint(modobj,level=0.95)[,2])
  tempdf <- data.frame(Variable=row.names(tempdf),tempdf)
  df <- data.frame()
  for(i in pred_full){
    iname <- unlist(strsplit(i,split = "_"))
    ifelse(length(iname)==1,iname<-c("ind",iname[1]),iname)
    tdf <- (tempdf 
            %>% filter(Variable == i)
            %>% mutate(Variable = paste(mod,i,sep="_")
               , Var = iname[2]
               , Type = ifelse(mod=="full",paste("full",iname[1],sep="_"),iname[1])
               , Model = model
            )
    )
    df <- rbind(df,tdf)
  }
  return(df)
}
            
  
combdf <- rbind(sum.df(futurefgc_ind,"ind","futurefgc")
                , sum.df(futurefgc_full,"full","futurefgc")
                , sum.df(futurefgcDau_ind,"ind","futurefgcDau")
                , sum.df(futurefgcDau_full,"full","futurefgcDau")
)
  

g1 <- (ggplot(combdf,aes(x=Variable,y=Est,ymin=Lower,ymax=Upper,group=Var,color=Type))
       + geom_pointrange()
       + facet_grid(Model~Var,scale="free")
       + theme_bw()
       + geom_hline(yintercept = 0)
       + ggtitle("Simply extracting from clmm object")
       + theme(axis.text.x = element_text(angle=90,hjust=1))
)

g1

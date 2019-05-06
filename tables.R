library(ordinal)
library(splines)
library(dplyr)

# Answers <- subset(Answers, CC != "LS")
# Answers (Answers
#   %>% select(-c(Age,baseAge,interviewYear, oldMC, MCcat,))
# )
# Answers <- Answers[complete.cases(Answers),]
Ans <- model.frame(
  daughterPlan ~ Persist + fgcstatus + CC 
  + age + Residence + Religion + MaritalStatus + Job 
  + mediaNpmg + mediaRadio + mediaTv
  + attNoTell + attNegKids + attArgue + attRefuseSex + attBurnFood
  + heardFGC + heardGF 
  + beneHygiene + beneAcceptance + beneMarriage + benePreventPreSex
  + benePleasureM beneReligion + beneRedPromis + beneRedSTD + beneOther
  + daughterPlan  + daughterFgced 
  , data=combined_dat, na.action=na.exclude, drop.unused.levels=TRUE
)

CCtable <- function(x){
  return(table(Ans[,x],Ans[,"CC"]))
}

predictors <- c("age","Residence","Religion","Education","Job","MaritalStatus","maxLastcondom"
                   ,"ExtraPartnerYear", "MC", "maxLastPartner", "MCprovider2","knowledgeCondomsProtect"
                   ,"knowledgeLessPartnerProtect", "knowledgeHealthyGetAids","mediaNpMg"
                   ,"mediaRadio","mediaTv")


tablist <- lapply(predictors,CCtable)

print(head(tablist[[1]]))

quit()

combdf <- function(pred,lldf){
  tempdf <- as.data.frame.matrix(lldf)
  df <- data.frame(Category=pred,Sub_Category=rownames(tempdf),tempdf)
  return(df)
}

ddtab <- data.frame()
for(i in seq_along(predictors)){
  ddtab <- rbind(ddtab,combdf(predictors[i],tablist[[i]]))
}

row.names(ddtab) <- NULL

ddtab2 <- (ddtab 
  %>% mutate(Total = KE+LS+MW+MZ+NM+RW+TZ+UG+ZM+ZW)
)


ddtabpercent <- (ddtab2
  %>% group_by(Category)
  %>% mutate(Category2 = Sub_Category
  , KE = round(KE*100/sum(KE),1)
  , LS = round(LS*100/sum(LS),1)
  , MW = round(MW*100/sum(MW),1)
  , MZ = round(MZ*100/sum(MZ),1)
  , NM = round(NM*100/sum(NM),1)
  , RW = round(RW*100/sum(RW),1)
  , TZ = round(TZ*100/sum(TZ),1)
  , UG = round(UG*100/sum(UG),1)
  , ZM = round(ZM*100/sum(ZM),1)
  , ZW = round(ZW*100/sum(ZW),1)
  )
  %>% select(-c(Sub_Category))
)


ddtab3 <- (ddtab2
  %>% select(-Sub_Category)
  %>% group_by(Category)
  %>% summarise_each(funs(sum)) 
  %>% ungroup()
  %>% mutate(Category2=as.factor("Total"))
  %>% bind_rows(ddtabpercent,.)
  %>% arrange(Category)
  %>% ungroup()
  %>% select(Category,Category2,KE:ZW,Total)
)


tabtotal <- (ddtab3
	%>% filter(Category2 == "Total")
	%>% select(Total)
	%>% filter(row_number()==1)
)



ddtab4 <- ddtab3 %>% mutate(totalper = round(Total*100/tabtotal[[1]],1))

print(ddtab4)

print(ddtab4[,10:13])

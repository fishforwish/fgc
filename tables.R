library(ordinal)
library(splines)
library(dplyr)

# Answers <- subset(Answers, CC != "LS")
# Answers (Answers
#   %>% select(-c(Age,baseAge,interviewYear, oldMC, MCcat,))
# )
# Answers <- Answers[complete.cases(Answers),]
Ans <- (combined_dat
	%>% select(Persist, fgcstatus, CC 
  , age , Residence , Religion , MaritalStatus , Job , Education
  , mediaNpmg , mediaRadio , mediaTv
  , attNoTell , attNegKids , attArgue , attRefuseSex , attBurnFood
  , heardFGC
  , beneHygiene , beneAcceptance , beneMarriage , benePreventPreSex
  , benePleasureM , beneReligion , beneRedPromis , beneRedSTD , beneOther
  , daughterPlan  , daughterFgced 
	)
	%>% mutate(AgeGroup = ifelse(between(age,14,19),"14-19"
		, ifelse(between(age,20,24),"20-24"
		, ifelse(between(age,25,29),"25-29"
		, ifelse(between(age,30,34),"30-34"
		, ifelse(between(age,35,39),"35-39"
		, ifelse(between(age,40,44),"40-44"
		, ifelse(between(age,45,49),"45-49",NA)
		))))))
		)
)

CCtable <- function(x){
  return(table(Ans[,x],Ans[,"CC"]))
}

predictors <- c("AgeGroup","Residence","Religion","Education","Job"
	,"MaritalStatus"
	, "heardFGC", "fgcstatus", "daughterPlan", "daughterFgced", "Persist"
	, "mediaNpmg","mediaRadio","mediaTv" 
	, "beneHygiene", "beneAcceptance", "beneMarriage", "benePreventPreSex"
	, "benePleasureM", "beneReligion", "beneRedPromis", "beneRedSTD", "beneOther"
	, "attNoTell", "attNegKids", "attArgue", "attRefuseSex", "attBurnFood"
)

tablist <- lapply(predictors,CCtable)

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
  %>% mutate(Total = KE+ML+SL+NG)
)


print(ddtab2)

ddtabpercent <- (ddtab2
  %>% group_by(Category)
  %>% mutate(Category2 = Sub_Category
  , KE = round(KE*100/sum(KE),1)
  , ML = round(ML*100/sum(ML),1)
  , NG = round(NG*100/sum(NG),1)
  , SL = round(SL*100/sum(SL),1)
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
  %>% select(Category,Category2,KE:SL,Total)
)


tabtotal <- (ddtab3
	%>% filter(Category2 == "Total")
	%>% select(Total)
	%>% filter(row_number()==1)
)



ddtab4 <- ddtab3 %>% mutate(totalper = round(Total*100/tabtotal[[1]],1))

print(ddtab4)

# print(ddtab4[,10:13])

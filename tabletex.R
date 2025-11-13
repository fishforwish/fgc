library(shellpipes)
manageConflicts()

library(dplyr)

tab <- rdsRead()
loadEnvironments()

Country <- (tab
  %>% filter(Category2=="Total") 
  %>% filter(row_number()==1)
  %>% select(-c(Category,Category2,totalper))
)

print(latex(Country))


cat("\\bf{Survey Year} & 2008/09 & 2006 & 2008 & 2008 &\\\\"
  , "\\bf{Sample Size} &" , latex(Country) ## sample size 
  , "\\bf{Category (in percentage)}", spaces
  , hline
  , "\\bf{Age Group}" , spaces
  , latex(dfill(tab,"AgeGroup"))
  , "\\bf{Residence}" , spaces
  , latex(dfill(tab,"Residence"))
  , "\\bf{Education}" , spaces
  , latex(dfill(tab,"Education"))
  , "\\bf{Religion}" , spaces 
  , latex(dfill(tab,"Religion"))
  , "\\bf{Marital Status}" , spaces
  , latex(dfill(tab,"MaritalStatus"))
  , "\\bf{Job}" , spaces
  , latex(dfill(tab,"Job"))
  , "\\bf{Heard FGC}" , spaces
  , latex(dfill(tab,"heardFGC"))
  , "\\bf{FGC Status}" , spaces
  , latex(dfill(tab,"fgcstatus"))
  , "\\bf{Daughter Plan}" , spaces
  , latex(dfill(tab,"daughterPlan"))
  , "\\bf{Daughter FGCed}" , spaces
  , latex(dfill(tab,"daughterFgced"))
  , "\\bf{Should FGC be continued?}" , spaces
  , latex(dfill(tab,"Persist"))
  , "\\bf{Media}" , spaces
  , space , "\\bf{Newspaper and Magazines}" , spaces
  , latex(dfill(tab,"mediaNpmg"),space=TRUE)
  , space , "\\bf{Radio}" , spaces
  , latex(dfill(tab,"mediaRadio"),space=TRUE)
  , space , "\\bf{TV}" , spaces
  , latex(dfill(tab,"mediaTv"),space=TRUE)
  , "\\bf{FGC Benefit}", spaces
  , space , "\\bf{Hygiene}", spaces
  , latex(dfill(tab,"beneHygiene"),space=TRUE)
  , space , "\\bf{Social Acceptance}", spaces
  , latex(dfill(tab,"beneAcceptance"),space=TRUE)
  , space , "\\bf{Better Marriage}", spaces
  , latex(dfill(tab,"beneMarriage"),space=TRUE)
  , space , "\\bf{Prevent Premartial Sex}", spaces
  , latex(dfill(tab,"benePreventPreSex"),space=TRUE)
  , space , "\\bf{Religion}", spaces
  , latex(dfill(tab,"beneReligion"),space=TRUE)
  ## , space , "\\bf{Reduce STD}", spaces
  ## , latex(dfill(tab,"beneRedSTD"),space=TRUE)
  , space , "\\bf{Sexual Pleasure for Men}", spaces
  , latex(dfill(tab,"benePleasureM"),space=TRUE)
  ## , space , "\\bf{Reduce Promiscuity}", spaces
  ## , latex(dfill(tab,"beneRedPromis"),space=TRUE)
  , space , "\\bf{Other}", spaces
  , latex(dfill(tab,"beneOther"),space=TRUE)
  , "\\bf{Gender Awareness: Wife beaten justified}" , spaces
  , space , "\\bf{Going out without telling}" , spaces
  , latex(dfill(tab,"attNoTell"),space=TRUE)
  , space , "\\bf{Neglict Kids}" , spaces
  , latex(dfill(tab,"attNegKids"),space=TRUE)
  , space , "\\bf{Arguing}" , spaces
  , latex(dfill(tab,"attArgue"),space=TRUE)
  , space , "\\bf{Refuse Sex}" , spaces
  , latex(dfill(tab,"attRefuseSex"),space=TRUE)
  , space , "\\bf{Burn Food}" , spaces
  , latex(dfill(tab,"attBurnFood"),space=TRUE)
  , file="table_output.tex")


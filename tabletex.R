library(dplyr)


Country <- (ddtab4 
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
  , latex(dfill(ddtab4,"AgeGroup"))
  , "\\bf{Residence}" , spaces
  , latex(dfill(ddtab4,"Residence"))
  , "\\bf{Education}" , spaces
  , latex(dfill(ddtab4,"Education"))
  , "\\bf{Religion}" , spaces 
  , latex(dfill(ddtab4,"Religion"))
  , "\\bf{Marital Status}" , spaces
  , latex(dfill(ddtab4,"MaritalStatus"))
  , "\\bf{Job}" , spaces
  , latex(dfill(ddtab4,"Job"))
  , "\\bf{Heard FGC}" , spaces
  , latex(dfill(ddtab4,"heardFGC"))
  , "\\bf{FGC Status}" , spaces
  , latex(dfill(ddtab4,"fgcstatus"))
  , "\\bf{Daughter Plan}" , spaces
  , latex(dfill(ddtab4,"daughterPlan"))
  , "\\bf{Daughter FGCed}" , spaces
  , latex(dfill(ddtab4,"daughterFgced"))
  , "\\bf{Should FGC be continued?}" , spaces
  , latex(dfill(ddtab4,"Persist"))
  , "\\bf{Media}" , spaces
  , space , "\\bf{Newspaper and Magazines}" , spaces
  , latex(dfill(ddtab4,"mediaNpmg"),space=TRUE)
  , space , "\\bf{Radio}" , spaces
  , latex(dfill(ddtab4,"mediaRadio"),space=TRUE)
  , space , "\\bf{TV}" , spaces
  , latex(dfill(ddtab4,"mediaTv"),space=TRUE)
  , "\\bf{FGC Benefit}", spaces
  , space , "\\bf{Hygiene}", spaces
  , latex(dfill(ddtab4,"beneHygiene"),space=TRUE)
  , space , "\\bf{Social Acceptance}", spaces
  , latex(dfill(ddtab4,"beneAcceptance"),space=TRUE)
  , space , "\\bf{Better Marriage}", spaces
  , latex(dfill(ddtab4,"beneMarriage"),space=TRUE)
  , space , "\\bf{Prevent Premartial Sex}", spaces
  , latex(dfill(ddtab4,"benePreventPreSex"),space=TRUE)
  , space , "\\bf{Religion}", spaces
  , latex(dfill(ddtab4,"beneReligion"),space=TRUE)
  , space , "\\bf{Reduce STD}", spaces
  , latex(dfill(ddtab4,"beneRedSTD"),space=TRUE)
  , space , "\\bf{Sexual Pleasure for Men}", spaces
  , latex(dfill(ddtab4,"benePleasureM"),space=TRUE)
  , space , "\\bf{Reduce Promiscuity}", spaces
  , latex(dfill(ddtab4,"beneRedPromis"),space=TRUE)
  , space , "\\bf{Other}", spaces
  , latex(dfill(ddtab4,"beneOther"),space=TRUE)
  , "\\bf{Gender Awareness: Wife beaten justified}" , spaces
  , space , "\\bf{Going out without telling}" , spaces
  , latex(dfill(ddtab4,"attNoTell"),space=TRUE)
  , space , "\\bf{Neglict Kids}" , spaces
  , latex(dfill(ddtab4,"attNegKids"),space=TRUE)
  , space , "\\bf{Arguing}" , spaces
  , latex(dfill(ddtab4,"attArgue"),space=TRUE)
  , space , "\\bf{Refuse Sex}" , spaces
  , latex(dfill(ddtab4,"attRefuseSex"),space=TRUE)
  , space , "\\bf{Burn Food}" , spaces
  , latex(dfill(ddtab4,"attBurnFood"),space=TRUE)
  , file="table_output.tex")


library(dplyr)


Country <- (ddtab4 
  %>% filter(Category2=="Total") 
  %>% filter(row_number()==1)
  %>% select(-c(Category,Category2,totalper))
)

cat("\\bf{Survey Year} & 2014 & 2014 & 2015-16 & 2011 & 2013 & 2014-15 & 2009-10 & 2011 & 2013-14 & 2015 & \\\\"
  , "\\bf{Sample Size} &" , latex(Country) ## sample size 
  , "\\bf{Category (in percentage)}", spaces
  , hline
  , "\\bf{Age Group}" , spaces
  , latex(dfill(ddtab4,"ageGroup"))
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
  , "\\bf{Condom Usage}" , spaces
  , latex(dfill(ddtab4,"maxLastcondom"))
  , "\\bf{Non-cohabiting Partners}" , spaces
  , latex(dfill(ddtab4,"ExtraPartnerYear"))
  , "\\bf{Circumcised}" , spaces
  , latex(dfill(ddtab4,"MC"))
  , "\\bf{MC Provider}" , spaces
  , latex(dfill(ddtab4,"MCprovider2"))
  , "\\bf{The Riskiest Sexual Partner}" , spaces
  , latex(dfill(ddtab4,"maxLastPartner"))
  , "\\bf{HIV Knowledge}" , spaces
  , space , "\\bf{Condoms Protect}" , spaces
  , latex(dfill(ddtab4,"knowledgeCondomsProtect"),space=TRUE)
  , space , "\\bf{Less Partner Protect}" , spaces
  , latex(dfill(ddtab4,"knowledgeLessPartnerProtect"),space=TRUE)
  , space , "\\bf{Healthy People Get Aids}" , spaces
  , latex(dfill(ddtab4,"knowledgeHealthyGetAids"),space=TRUE)
  , hline
  , "\\bf{Media}" , spaces
  , space , "\\bf{Newspaper and Magazines}" , spaces
  , latex(dfill(ddtab4,"mediaNpMg"),space=TRUE)
  , space , "\\bf{Radio}" , spaces
  , latex(dfill(ddtab4,"mediaRadio"),space=TRUE)
  , space , "\\bf{TV}" , spaces
  , latex(dfill(ddtab4,"mediaTv"),space=TRUE)
  , file="table_output.tex")


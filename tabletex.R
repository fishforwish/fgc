library(dplyr)


Country <- (ddtab4 
  %>% filter(Category2=="Total") 
  %>% filter(row_number()==1)
  %>% select(-c(Category,Category2,totalper))
)

print(latex(Country))


cat("\\bf{Survey Year} & 2015 & 2015 & 2015 & 2015 &\\\\"
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
  , "\\bf{Media}" , spaces
  , space , "\\bf{Newspaper and Magazines}" , spaces
  , latex(dfill(ddtab4,"mediaNpmg"),space=TRUE)
  , space , "\\bf{Radio}" , spaces
  , latex(dfill(ddtab4,"mediaRadio"),space=TRUE)
  , space , "\\bf{TV}" , spaces
  , latex(dfill(ddtab4,"mediaTv"),space=TRUE)
  , "\\bf{Benefit}", spaces
  , space , "\\bf{Hygiene}", spaces
  , latex(dfill(ddtab4,"beneHygiene"),space=TRUE)
  , file="table_output.tex")


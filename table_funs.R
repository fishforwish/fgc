library(dplyr)
dfill <- function(dat,x){
  return(dat
         %>% filter(Category==x)
         %>% filter(Category2!="Total")
         %>% select(-c(Total,Category))
  )
}

latex <- function(x,spaces=FALSE){
  n <- nrow(x)
  string <- knitr:::kable(x,format="latex",digits=3,align="l",col.names = NULL,booktabs=FALSE)
  tab <- unlist(strsplit(string[1],"\n"))
  if(spaces){
    return(paste("\\hspace{0.2in}",tab[c(2+2*1:n)]))
  }
  return(tab[c(2+2*1:n,2+2*n+1)])
}

header <- c("
  \\documentclass{article}
  \\usepackage[top=0.01in,left=1in]{geometry}
  \\usepackage[T1]{fontenc}
            
  \\begin{document}
  \\begin{table}{}
  \\scriptsize{
  \\begin{tabular}{|l|rrrrrrrrrr|r|}
  \\hline
  \\bf{Country} & KE & LS & MW & MZ & NM & RW & TZ & UG & ZM & ZW & Total \\\\
  \\hline
")

footer <- c("
  \\hline
  \\end{tabular}
  }
  \\end{table}
  \\end{document}
")

space <- c("
  \\hspace{0.2in}
")
hline <- c("
  \\hline
")  

spaces <- c("&&&&&\\\\")

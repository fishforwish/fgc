library(ordinal)
library(dplyr)
library(tidyr)

library(shellpipes)

loadEnvironments()

beta_est <- coef(mod)
beta_ci <- confint(mod)

beta_dat <- cbind(beta_est,beta_ci)
dd <- data.frame(beta_dat, variable=rownames(beta_dat))
colnames(dd) <- c("beta", "lower", "upper", "variable")

mm <- as.data.frame(modAns)

## changing all categorical variables to numeric
mm2 <- (mm
  %>% rowwise()
  %>% dplyr:::summarise_all(funs(as.numeric(.)))
)
x_keep <- (mm
  %>% dplyr:::summarise_all(funs(as.numeric(!is.numeric(.))*length(unique(.))))
  %>% gather(variable,levels)
  %>% filter(levels<=2)
)

betadf <- (mm2
   %>% dplyr:::summarise_all(funs(sd))
   %>% gather(variable,sd)
   %>% left_join(.,x_keep) ## creating keep 
   %>% mutate(variable = ifelse(variable == "fgcstatus","fgcstatusYes",variable)
        , variable = ifelse(variable == "job","jobYes",variable)
		  , variable = ifelse(variable == "urRural","urRuralRural",variable)
		  )
   %>% left_join(.,dd) ## joining beta df
   %>% filter(complete.cases(.))
   %>% rowwise()
   %>% mutate(beta = beta*sd
              , lower = lower*sd
              , upper = upper*sd
              , inCI = between(0,lower,upper)
   )
	%>% left_join(.,rename_dat)
)

print(betadf)

rdsSave(betadf)

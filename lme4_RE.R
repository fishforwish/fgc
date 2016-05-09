library(lme4)

a <- rep(c("aa","bb"),10)
b <- rep(c("x","y","z","w"),5)
x <- rnorm(20)
y <- rnorm(20,mean=4)

dat <- data.frame(a,b,x,y)
mod <- lmer(y~x+a + (0+x+a | b),data=dat) 
summary(mod)

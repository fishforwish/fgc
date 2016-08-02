library(brms)
library(splines)
library(effects)

me <- marginal_effects(futurefgc)

for(eff in me){
  plot(eff)
}

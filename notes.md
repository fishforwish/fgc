
Basically, this paper is about norm and behaviors.
We studied KMNS: Kenya 2008/9, Mali 2006 (C: the report was in French), Nigeria 2008 and Sierra Leone 2008.

Research Questions:

* The main research question (all multivariate) is what the associations are among women's beliefs in FGC benefits, their position on whether to continue FGC practice in the future, and whether to cut their daughters. (only women with daughter to be cut are included)
* The secondary question (all future fgc):  what the associations are among women's beliefs in FGC benefits and their position on whether to continue FGC practice in the future (all the women are included)
* Third question:  daughter vs. whether to continue (only women with daughter included) (We migh need it.  This is a model we hope can provide more details to explain the first question).
* We are going to run versions of our two main models, but without group level covariates.


Variables:
* In the main model, the predictors are women’s FGC status and FGC benefits  (see the list of FGC benefits at table--) and the response variables are women’s opinion on whether the practice of FGC, and whether to cut their daughters.  In the secondary model, women’s gender awareness is the predictor and beliefs of FGC benefits the response.
* other covariates:  country \cf{We don’t need this if we analyze each country separately}, age, education, wealth, ethnicity, religion, marital status, work status, residence (urban vs. rural), media use (another PCA or score?) and gender awareness.
* covariates at a community level:  education, wealth, media use, FGC benefits, gender awareness and FGC prevalence
* Cluster is treated as the only random effect; while ethinicity and religion are fixed.

Basic Information:
* att (gender awareness: no=0, DK=1 and yes=2):  the higher the score is, the LESS aware of gender equality a woman feels.  FGC bene (no=0, yes=1):  the higher the score, the stronger in believing FGC beneifts.  Media use (not at all=0..., almost everyday=3):  the higher the score, the more in using media.
* media scores from 0-3 (3 questions), att 0-2 (5 questions), bene 0-2 (9 questions).

Other issues and questions:
* to think about the fourth question?
* studying threshold/tipping point: to test if when FGC prevalence reaches certain point , the behaviors start to change (either direction), and if the association of benefit and prevalence also play a crucial role in the "tipping point"?
* Efferson etc's paper (15):  What can it tell us about heterogeniety ("a singel critical threshold is unlikely to exist"). They argued that FGC is not a socially conditined norm.  Will our findings support or rebut it?
* to investigate the associations of women’s gender awareness, and their beliefs of FGC benefits.  It is presumed that gender awareness interrelate to FGC beliefs.  By testing the relations of the two factors allows us to gather information for a better interpretation of the main model. (which group of women?  with or withtout daughers to be cut?)
* to study contrast of countries.

Decisions:
* This study is about testing hypothesis not prediction.
* We agree on using spline for age and wealth (to keep more power, correct?)
* We used score (instead of PCA) to represent Media use, FGC benefits, gender awareness.
* to include wealth, and education at the community level.
* to make ethnicity a random because we don't need the power for the result.  We have enough levels for our reason; and we are not particularly interested in ethnicity for our study.  __BUT__ we latter decided to put it back as a fixed variable.
* We decided to run versionso our two main models, but without group level covariates. (Apr 20, 15)

---------------------------------------------------------------------
July 14:
+ The higher the score of gender attitude (att), the less awareness of gender equality.  For example:
+ V744E: Wife beating justified if she burns the food
+ Categories    score
+ No               0

Yes              2

Don't know       1


On the other hand, the higher the score of fgc benefit, the more benefits seen of fgc
+ Circumcision benefits: social acceptance
+ Categories   score

No             0

Yes            1
----------------------------------------------------------------------

14 June

+ Futurefgc and FuturefgcDau ran without problems but daughterfgc_ind *failed* to estimate variance-covariance for fixed effects. Can we bottleneck the daughter model and move on with futurefgc and futurefgcDau because futurefgc and futurefgcDau are the models of interest. How much do we *lose* skipping the daughter model? BB suggest we can extract the hessian from the clmm object and compute the vcov ourselves (daughterfgc_ind). This leads to my next question of how to do *effect* plots. The hessian and vcov have a bunch of extra stuff (ST's) and the effects packages does work with our model (maybe RE's). I can always extract what I need and feed into effects, but not sure if it is correct. 

+ Based on the results of the 6 models (futurefgc, daughter fgc with future, and daughter fgc; each with individual and full models), we will go ahead and do plots, etc. despite the fact that there are still some confusions with the individual daughter fgc model.
+ Jonathan emailed Ben about all the NA and ST in the individual daughter fgc model.
+ Mike will add group mom fgc in the daughter fgc full model.
## 20 Apr 2016

* We want to start with a model that has no group-level covariates. The idea is mostly about power: it will often be hard to see whether a covariate is operating at the individual level, group level, or both: first we want to know whether it's operating at all.
---------------------------------------------------------------------
7 June

The largest model took 81 hours to fit via clmm. The errors are consistent with the problems noted on May 4th. We have more than one RE and clmm spits back NA's for se.error. Quadrature methods are not available with more than one RE term. 

---------------------------------------------------------------------
20 May

Mike has made a beautiful picture, but we're having trouble interpreting some of the details. Should we be worried about the mixing in MCMCglmm? Can we try to address with priors? 

We apparently didn't switch back to ordinal because of something to do with random effects. Can that be overcome? Mike also thinks there's a problem with the quadrature.

----------------------------------------------------------------------

May 10th

DO NOT DO ANY DPLYR RIGHT BEFORE MCMCGLMM
Running into a lot of trouble with priors.
Error in MCMCglmm(as.factor(futurefgc) ~ fgcstatusMom + bene + media +  : 
  ill-conditioned cross-product: can't form Cholesky factor 

with nu=0.0002 without singular.ok

Error in MCMCglmm(as.factor(futurefgc) ~ fgcstatusMom + bene + media +  : 
  ill-conditioned G/R structure (CN = 8630392281685741.000000): use proper priors if you haven't or rescale data if you have 

nu=0.0002 with singular.ok or high nu no singular.ok

We are out spl(age) and spl(wealth) country RE __because of the G/R problem__. Finished all models, running on yushan now.
----------------------------------------------------------------------

May 9th

ML: The reason why ns (spline) did not work the before thus via splines:::ns is because MCMCglmm has its own spline function (spl) and it __claims__ it does orthgonial spline design. I figured out how to do the proposed models from last meeting and now running futurefgc_ind and futurefgc_full on yushan. I still have 4 more models to do (daughter_ind/full and futuredau_ind/full) 
---------------------------------------------------------------------
4 May

We don't want to wait until we're able to do multivariate-response models, so we are going forward with a set of "structural" univariate-response models:

futurefgc ~ indiv-level covariates
fgcDau ~ indiv-level covariates
fgcDau ~ indiv-level covariates + futurefgc

We're defining this as the main model

The next step will be to try to disentangle individual vs group effects from these models. The idea will be that if we put in normalized individual-level and group-level covariates, they should compete to explain the effects seen in the individual-level models. We're putting this off a bit because we're not sure how we will visualize this for the multi-parameter variables wealth and age, so we want to see what we can do with the individual-level models first.

----------------------------------------------------------------------

## 4th May 2016
Let's simplify the problem and do the countries separately. The baseline problem is actually a big deal because we don't want to compare against the "baseline" ie. ke.no_job to ml.yes_job..." 
MCMCglmm does not seem to have anova/ something to test variable level statistics, ie, don't have something to test the question "does ethnicity in general affect futurefgc"
Went back and have a better understanding of ordinal and clmm's. clmm (or clmm1) can do multiple RE but via LA and blows up/ spits back NAs for sd.err. clmm2 can do AGQ but only do one RE (back then we were trying to do response AND clusterID and didn't follow up and gave up). 

We can test "norms" now via anova LRT. 

Question: Are we happy? Does it make sense? More validation? Use MCMCglmm vs ordinal? 
* Is there a guideline for baseline?  e.g., ethinicity?


----------------------------------------------------------------------
Unfortunately, we can't put country back in in this framework! Should we go back to mcmcglmm, but still try to simplify?

One idea, an mcmcglmm model with
* ethnicity, country and cluster all as random effects
* country should be associated with random slopes for all the key variables as well. In lme4 syntax

futurefgc~
  fgcstatusMom
  + bene + media + att
  + splines::ns(age, 4) + splines::ns(wealth, 4)
  + edu + maritalStat + job + urRural
  + religion
  + (1 | ethnicity) + (1 | clusterId)
  + (bene + media + att 
    + splines::ns(age, 4) + splines::ns(wealth, 4)
  | country)

Alternatively, we could use the similar model we already have (with country as a fixed effect with interactions) if we can solve part of the centering problem (maybe simply by using weighted sum-to-zero contrasts on country).

Another option that we considered is to simply do a different model for each country because of this computer problem. JD is against that. ML thinks that these proposals are too hard.

ML will do a better job documenting and sharing important obstacles. Maybe we can overcome some of them.

----------------------------------------------------------------------
3rd May 2016
Meng, X. L. (1994). Posterior predictive p-values. Ann. Statist. 22, 1142-1160.
----------------------------------------------------------------------
26 Apr 2016

* Can we get medians instead of means in the main summary? If not, where do we get medians and how do we manipulate them?

* Two different (?) things about contrasts and manipulating co-ordinates:
  * Make _prediction_ plots that show the effect of each variable with respect to the model center
    * This is also important for the splined variables, since we don't have variable-level P values (what does it mean that we don't understand what this would mean in a Bayesian context?)
  * Use _contrasts_ to have the main effects show up as _averaged_ over countries
    * BB says that `broom` is "relevant" but not "ready"

* Should we try to make general manipulation tools, or should we be taking advantage of our current Bayesian framework to do stuff the easy way?










   

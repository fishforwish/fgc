
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
* to make ethnicity a random because we don't need the power for the result.  We have enough levels for our reason; and we are not particularly interested in ethnicity for our study.  BUT we latter decided to put it back as a fixed variable.
* We decided to run versionso our two main models, but without group level covariates. (Apr 20, 15)

## 20 Apr 2016

* We want to start with a model that has no group-level covariates. The idea is mostly about power: it will often be hard to see whether a covariate is operating at the individual level, group level, or both: first we want to know whether it's operating at all.

## 26 Apr 2016

* Can we get medians instead of means in the main summary? If not, where do we get medians and how do we manipulate them?

* Two different (?) things about contrasts and manipulating co-ordinates:
  * Make _prediction_ plots that show the effect of each variable with respect to the model center
    * This is also important for the splined variables, since we don't have variable-level P values (what does it mean that we don't understand what this would mean in a Bayesian context?)
  * Use _contrasts_ to have the main effects show up as _averaged_ over countries
    * BB says that `broom` is "relevant" but not "ready"

* Should we try to make general manipulation tools, or should we be taking advantage of our current Bayesian framework to do stuff the easy way?


## 3rd May 2016
Meng, X. L. (1994). Posterior predictive p-values. Ann. Statist. 22, 1142-1160. 
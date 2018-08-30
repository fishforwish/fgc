* Basically, this paper is about norm and behaviors.
* We studied KMNS: Kenya 2008/9, Mali 2006 (C: the report was in French), Nigeria 2008 and Sierra Leone 2008.

Research Questions:

Main model: daughter plan ~ others (women's attitudes in fgc beliefs and their fgc status).
*  women with daughters to be fgc

Model 2: fgc future ~ others (women's attitudes in fgc beliefs predicting fgc future)
* 2a:  all women
* 2b: women with daughters to be fgc

Model 3: daughter plan ~ fgc future and others (only women with daughter included)
*  women with daughters to be fgc

* All models to be run with and without group-level covariates
	* We said we want to do this for power reasons

Models:
* Daughter plan (main):
system.time(mod<- clmm(
  futureDau ~ futurefgc 
  + fgcstatusMom + bene + media + att + edu + maritalStat
  + job + urRural + religion
  + ns(wealth,3) + ns(age,4) 
  + group_futurefgc + group_fgcstatusMom + group_bene + group_media + group_att + group_edu + ns(group_wealth,3)
  + (1|clusterId) + (1|ethni)
  + (1|CC)
  , data=modAns)
)

* FGC continuity (secondary):
system.time(mod <- clmm(
  futurefgc ~ fgcstatusMom 
  + bene + media + att + edu  + maritalStat + job + urRural + religion
  + ns(wealth,3) + ns(age,4) 
  + group_fgcstatusMom + group_bene + group_media + group_att + group_edu + ns(group_wealth,3)
  + (1|clusterId) + (1|ethni)
    + (1|CC)
  , data=modAns)
)

Decisions:
* This study is about testing hypothesis not prediction.
* We agree on using spline for age and wealth (to keep more power, correct?)
* We used score (instead of PCA) to represent Media use, FGC benefits, gender awareness.
* to include wealth,fgcstatusMom, fgc benefit, media, gender attitudes and education at the community level; and futurefgc in the main model.
* to make ethnicity a random because we don't need the power for the result.  We have enough levels for our reason; and we are not particularly interested in ethnicity for our study.  __BUT__ we latter decided to put it back as a fixed variable.

Basic Information:
* att (gender awareness: no=0, DK=1 and yes=2):  the higher the score is, the LESS aware of gender equality a woman feels.  FGC bene (no=0, yes=1):  the higher the score, the stronger in believing FGC beneifts.  Media use (not at all=0..., almost everyday=3):  the higher the score, the more in using media.
* media scores from 0-3 (3 questions), att 0-2 (5 questions), bene 0-1 (9 questions).

* list of FGC benefits in DHS:
G117A: Circumcision benefits: cleanliness/hygiene
G117B: Circumcision benefits: social acceptance
G117C: Circumcision benefits: better marriage prospects
G117D: Circumcision benefits: virginity/prevent premarital sex
G117E: Circumcision benefits: more sexual pleasure for men
G117F: Circumcision benefits: religious approval
G117G: Circumcision benefits: reduce promiscuity/ reduce sex drive
G117H: Circumcision benefits: reduce STD and AIDS infections
G117X: Circumcision benefits: other
G117Y: Circumcision benefits: no benefit (Did we use this one? to check.)

Other issues and questions:
* studying threshold/tipping point: to test if when FGC prevalence reaches certain point, the behaviors start to change (either direction), and if the association of benefit and prevalence also play a crucial role in the "tipping point"?
* Efferson etc's paper (15):  What can it tell us about heterogeniety ("a singel critical threshold is unlikely to exist"). They argued that FGC is not a socially conditined norm.  Will our findings support or rebut it?
* to investigate the associations of women’s gender awareness, and their beliefs of FGC benefits.  It is presumed that gender awareness interrelate to FGC beliefs.  By testing the relations of the two factors allows us to gather information for a better interpretation of the main model. (which group of women?  with or withtout daughers to be cut?)
* to study contrast of countries.
* Who are the women we should include?  So far, we included all women in the fgc continuity model, and only women with daughters who are not fgced in the daughter model.  We have the following variables to consider how we want to make the best use of the samples.
1. G108: Number of  daughters circumcised (we recoded it as y/n)
2. G113: Age of daughter at circumcision (if we wanted to consider only women whose circumcised daighter is under certain age).
3. G115: Any daughter who is not circumcised (This is the main variable we used for the daughter model)
4. G116: Intends to have daughter(s) circumcised in future (This is the main variable we used for the daughter model)
We are also interested in any changes of mother's attitudes on FGC.  We can find information of this by testing women who already have daughters fgced and more to (or not to) be fgced.  This is be interesting, especially at a community level.


* We are also interested in GPS data.  We can map fgc concentraion and location by showing where fgc are mostly practiced.  Here are an artical we can lear from: http://journals.plos.org/plosmedicine/article?id=10.1371/journal.pmed.1001626: "WSS data were sourced from national household cluster-sample surveys undertaken as part of multiple indicator cluster surveys (MICS) (http://www.childinfo.org/mics4_surveys.html; implementation supported by UNICEF), Demographic and Health Surveys (DHS) and national malaria and AIDS indicator surveys (MIS/AIS) (http://www.measuredhs.com/data/available-datasets.cfm; USAID) and living standard measurement studies (LSMS) (http://iresearch.worldbank.org/lsms/lsmssurveyFinder.htm; World Bank). "

However,none of the countries had GPS data.  In terms of the lastest surveys, Kenya 2014, Mali 2012-3 and Nigeria 2013 have no value modules.  Sierra Leone 2013 does.  Should we use Sierra Leone 2008 or 2013? 2008 data is closer to the other data in terms of time period. It seems more convincing to if the data is all in a similar time span.  On the other hand, it is a much recent data and provides a more updated view{]}. 

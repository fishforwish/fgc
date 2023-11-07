
# Journals to consider:

BMJ
Am J Public Health
Sexually Transmitted Infections
Soc Sci Med
Plos one
BMC Public Health
Glob Public Health
BMJ Open
J Health Soc Behav
Reproductive Health
Cult Health Sexuality

Project proposal:

Basically, this paper is about norm and behaviors.
We studied KMNS: Kenya 2008/9, Mali 2006 (C: the report was in French), Nigeria 2008 and Sierra Leone 2008. *** Guinea 2005 shall be included (The 2012, 2018 include only basic fgc questions)!!!***
Updated: by Nov 6, 2023, the newer data (Kenya 2014, Mali 2012-3/18, Nigeria 2013/18 and Sierra Leon 2019) did not have comparable datasets for the goals of this study, so we sticked to the current older datasets).  We also checked the other African countries with high FGC prevalene (i.e., countries with more than 20% of FGC prevalence:  Burkina Faso** (2010, 2021), Central African Republic(nd, no data), Chad**(2014-5), Cote Dlvoire**(2011-2), Djibouti(nd), Egypt(nd), Eritrea(nd), Ethiopia**(2016), Gambia (nd), Guinea Bissau (nd), Guinea** (2018), Liberia, Senegal**(2019, 2018, 2017,2016,2015,2014,2010-1,2005,), Somalia(na), and Sudan(na)) and found no data met our critera.  However Sierra leone 2013 DHS and Kenya 2022 do have similar data and that will allow us to do a quasi longitudinal comparison.  (** data with questions of religion and whether to continue the practice). Data before 2000 were not considered due to limited access and/or no related questionnaires found.
There are other perspectives we can explore beside the KMNS data with similar years: 
- Sierra Leone 2008 vs. 2013 (with norm questions)
- Sierra Leone 2008 vs. 2013 vs. 2019 (with religion and whether to stop the questions)
- The set of FGC questions in the Kenya 2022 (queations under "SGC") data can be comparable to its 2008/9 data.  The norm quations in 2022 are different from the 2008/9 but with some similarity.

Research Questions:

* The main research question (all multivariate) is what the associations are among women's beliefs in FGC benefits, their position on whether to continue FGC practice in the future, and whether to cut their daughters. (only women with daughter to be cut are included)
* The secondary question (all future fgc):  what the associations are among women's beliefs in FGC benefits and their position on whether to continue FGC practice in the future (all the women are included)
* Third question:  daughter vs. whether to continue (only women with daughter included) (We migh need it.  This is a model we hope can provide more details to explain the first question).
* We are going to run versions of our two main models, but without group level covariates.


Variables:
* In the main model, the predictors are women’s FGC status and FGC benefits  (see the list of FGC benefits at table--) and the response variables are women’s opinion on whether the practice of FGC, and whether to cut their daughters.  In the secondary model, women’s gender awareness is the predictor and beliefs of FGC benefits the response.
* other covariates:  country \cf{We don’t need this if we analyze each country separately}, age, education, wealth, religion, marital status, work status, residence (urban vs. rural), media use (another PCA or score?) and gender awareness.
* covariates at a community level:  education, wealth, media use, FGC benefits, gender awareness and FGC prevalence
* Cluster and ethnicity are treated as the only random effect.

Basic Information:
* att (gender awareness: no=0, DK=1 and yes=2):  the higher the score is, the LESS aware of gender equality a woman feels.  FGC bene (no=0, yes=1):  the higher the score, the stronger in believing FGC beneifts.  Media use (not at all=0..., almost everyday=3):  the higher the score, the more in using media.
* media scores from 0-3 (3 questions), att 0-2 (5 questions), bene 0-1 (9 questions).

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

-------------------------------

* We are also interested in GPS data.  We can map fgc concentraion and location by showing where fgc are mostly practiced.  Here are an artical we can lear from: http://journals.plos.org/plosmedicine/article?id=10.1371/journal.pmed.1001626: "WSS data were sourced from national household cluster-sample surveys undertaken as part of multiple indicator cluster surveys (MICS) (http://www.childinfo.org/mics4_surveys.html; implementation supported by UNICEF), Demographic and Health Surveys (DHS) and national malaria and AIDS indicator surveys (MIS/AIS) (http://www.measuredhs.com/data/available-datasets.cfm; USAID) and living standard measurement studies (LSMS) (http://iresearch.worldbank.org/lsms/lsmssurveyFinder.htm; World Bank). "

However,none of the countries had GPS data.  In terms of the lastest surveys, Kenya 2014, Mali 2012-3 and Nigeria 2013 have no value modules.  Sierra Leone 2013 does.  Should we use Sierra Leone 2008 or 2013? 2008 data is closer to the other data in terms of time period. It seems more convincing to if the data is all in a similar time span.  On the other hand, it is a much recent data and provides a more updated view{]}. 

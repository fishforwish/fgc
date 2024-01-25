Project proposal:  The Associations of Women's belief in Female Genital Cutting and the Likelihood of  Their Daughters' Circumcision Likelihood
(The manuscript format for now refers to https://github.com/covid19awareness/YouTube.  CS is confused why there are so many versions of ms in the Youtube projects!)

The reference should be from auto.bib and manual.bib

Basically, this paper is about 'norm and behaviors'.
We studied 'KMNS': Kenya 2008/9, Mali 2006 (C: the report was in French), Nigeria 2008 and Sierra Leone 2008. (To add Guinea 2005?)
DHS archives was updated by Nov 6, 2023, and the newer sets (Kenya 2014, Mali 2012-3/18, Nigeria 2013/18 and Sierra Leon 2019) did not have comparable questionnaire for this study, so we sticked to the older datasets 

We also checked the other African countries with high FGC prevalence (i.e., countries with more than 20\% of FGC prevalence) and found no data met our criteria:  Burkina Faso** (2010, 2021), Central African Republic(nd, no data), Chad**(2014-5), Cote Dlvoire**(2011-2), Djibouti(nd), Egypt(nd), Eritrea(nd), Ethiopia**(2016), Gambia (nd), Guinea Bissau (nd), Guinea** (2018), Liberia, Senegal**(2019, 2018, 2017, 2016, 2015, 2014, 2010-1, 2005), Somalia(na), and Sudan(na).   (** data with questions of religion and whether to continue the practice). Data before 2000 were not considered due to limited access and/or no related questionnaires found.  Sierra Leone 2013 DHS and Kenya 2022 do have similar data and that will allow us to do a quasi longitudinal comparison.

There are other perspectives we can explore beside the KMNS data within a reasonable year range: 
- Sierra Leone 2008 vs. 2013 (with norm questions)
- Sierra Leone 2008 vs. 2013 vs. 2019 (with questions of religious requirement and of whether to continue the practice)
- Kenya 2008/9 vs. 2022.  The Kenya 2022 (questions under "SGC") FGC data is different but similar and comparable to its 2008/9 data. (see https://github.com/fishforwish/fgc_Kenya)
- *** To add Guinea 2005 to the KMNS? ***

Research Questions:
* The first question: the association of daughter's FGC future and FGC beliefs.  
* The second question:  the association of FGC continuance and FGC beliefs.

Models:
Three models were made in response to the three questions above accordingly:
* A daughter model (all multivariate, only women with daughter to be cut are included): beliefs in FGC benefits (see the list of FGC benefits at table--) --> FGC continuance + to cut daughters.
* A continuance model (all future FGC, all the women are included), a structural model:  beliefs in FGC benefits --> to FGC continuance.  This model included all the women in the DHS data, whether they had or had no daughter for FGC consideration.
* A persistence model (only women with daughter included) for this:  FGC benefits and FGC continuance --> FGC intention on daughters (We might need it.  This is a model which we hope can provide more details to explain the first question).  This was a mixed and a structural model to understand how FGC continuance affect 

* We are going to run versions of our two main models, but without group level covariates.

Variables:
* The main response variables: FGC continuance, and to FGC daughters.
* The main predictors: women’s FGC status, and beliefs in FGC benefits.
* other covariates:  country \cf{We don’t need this if we analyze each country separately}, age, education, wealth, religion, marital status, work status, residence (urban vs. rural), media use (another PCA or score?) and gender awareness.
* covariates at a community level:  education, wealth, media use, FGC benefits, gender awareness and FGC prevalence
* Cluster and ethnicity are treated as the only random effect.

Basic Information:
* att (gender awareness: no=0, DK=1 and yes=2):  the higher the score is, the LESS aware of gender equality a woman feels.  FGC bene (no=0, yes=1):  the higher the score, the stronger in believing FGC beneifits.  Media use (not at all=0..., almost everyday=3):  the higher the score, the more in using media.
* media scores from 0-3 (3 questions), att 0-2 (5 questions), bene 0-1 (9 questions).

Other issues and questions:
* studying threshold/tipping point: to test if when FGC prevalence reaches certain point , the behaviors start to change (either direction), and if the association of benefit and prevalence also play a crucial role in the "tipping point"?
* Efferson etc's paper (15):  What can it tell us about heterogeneity ("a single critical threshold is unlikely to exist"). They argued that FGC is not a socially conditioned norm.  Will our findings support or refute it?
* to investigate the associations of women’s gender awareness, and their beliefs of FGC benefits.  It is presumed that gender awareness interrelate to FGC beliefs.  By testing the relations of the two factors allows us to gather information for a better interpretation of the main model. (which group of women?  with or without daughters to be cut?)
* to study contrast of countries.

Discussion:
* We will try to put country's FGC policy (i.e., whether there is an official ban on the practice) in context when interpreting the results.

Decisions:
* This study is about finding associations (is it a kind of prediction?) than testing hypothesis not prediction. (C:  can we just study associations than using hypothesis?)
* We agree on using spline for age and wealth (to keep more power, correct?)
* We used score (instead of PCA) to represent Media use, FGC benefits, gender awareness.
* to include wealth, and education at the community level.
* to make ethnicity a random because we don't need the power for the result.  We have enough levels for our reason; and we are not particularly interested in ethnicity for our study.  __BUT__ we latter decided to put it back as a fixed variable.
* We decided to run versions of our two main models, but without group level covariates. (Apr 20, 15)

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

* list of variables included or to be considered:
# Blocks
clusterId, V001
region, SREGNAT, V101
ethni, V131
# Basic
survey, V000
sampleWeight, V005
age, V012
urRural, V025
edu, V106
religion, V130
visitorResident, V135
wealth, V191
maritalStat, V501
job, V714
# daughter:
# genderChild, B4
# LNchild, B16
# daughterHome, V203
# daughterElsewhere, V205
# daughterDead, V207
# LNdaughterFgced, G109
# ageDaughterFgced, G113
# Confounders 1
mediaNpmg, V157
mediaRadio, V158
mediaTv, V159
# Confounders 1:  gender attitude (or as a counfounder?)
attNoTell, V744A
attNegKids, V744B
attArgue, V744C
attRefuseSex, V744D
attBurnFood, V744E
# FGC Basic Info
requirReligion, G118, FG122
heardFGC, G100, FG100, S631D
heardGC, G101, S631E
# Predictors 1:
fgc, G102, FG103, S821, S1002, S631F
# predictor 2: FGC benefit
beneHygiene, G117A, FG119A
beneAcceptance, G117B, FG119B
beneMarriage, G117C, FG119C
benePreventPreSex, G117D, FG119D, FG121
benePleasureM, G117E, FG119E
beneReligion, G117F, FG119F
beneRedPromis, G117G,
beneRedSTD, G117H
beneOther, G117X, FG119X
# Response 1: daughter FGC status
numDaughterFgced, G108, FG110, S631I
daughterNotFgced, G115
daughterToFgc, G116, FG118
-------------------------------

* We are also interested in __GPS__ data.  We can map fgc concentration and location by showing where fgc are mostly practiced.  Here are some articles we can learn from: http://journals.plos.org/plosmedicine/article?id=10.1371/journal.pmed.1001626: "WSS data were sourced from national household cluster-sample surveys undertaken as part of multiple indicator cluster surveys (MICS) (http://www.childinfo.org/mics4_surveys.html; implementation supported by UNICEF), Demographic and Health Surveys (DHS) and national malaria and AIDS indicator surveys (MIS/AIS) (http://www.measuredhs.com/data/available-datasets.cfm; USAID) and living standard measurement studies (LSMS) (http://iresearch.worldbank.org/lsms/lsmssurveyFinder.htm; World Bank). "


# Journals to consider:

- BMJ
- Soc Sci Med
- Am J Public Health
- Sexually Transmitted Infections
- Plos one
- BMC Public Health
- Glob Public Health
- BMJ Open
- J Health Soc Behav
- Reproductive Health
- Cult Health Sexuality

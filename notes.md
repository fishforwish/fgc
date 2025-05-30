Research questions:  
* First, what is the association between mothers' beliefs about the benefits of FGC and their plans for their daughters' FGC future (For this model, we will use daughterPlan_clmm.Rout); 
* second, what is the association between woman's beliefs and their opinion about whether FGC should be continued.(For this model, we will use fgcPersist_clmm.Rout)

Figures and tables:
Our main findings will be based on the results of daughterPlan_effects.Plot.Rout.pdf (and fgcPersist_), and daughterPlan_isoplots.Rout.pdf (and fgcPersist_)
We also like to use the following figures to look for insights:
* daughterPlan_varlvlsum.Routput and fgcPersist_varlvlsum.Routput
* bene.Rout.pdf
* prevalence_Rout.pdf

2025 May 12
=================
* Redo the benefits csv
** We keep only benefit questions used in all the 4 countries.
** beneNone (G117Y, FG119Y) is a derived variable, not using.
** We use G118 (equired by religion) independently along with G117F (religious approval) which is part of the bene variables.

G117A: Circumcision benefits: cleanliness/hygiene (all)
G117B: Circumcision benefits: social acceptance (all)
G117C: Circumcision benefits: better marriage prospects (all)
G117D: Circumcision benefits: virginity/prevent premarital sex (all) 
G117E: Circumcision benefits: more sexual pleasure for men (all) 
G117F: Circumcision benefits: religious approval (all)
G117G: Circumcision benefits: reduce promiscuity/ reduce sex drive (K) 
** G117G: Circumcision benefits: don't know benefits (N)
G117H: Circumcision benefits: reduce STD and AIDS infections (KM)
G117X: Circumcision benefits: other (all)
G117Y: Circumcision benefits: no benefit (all) (Did we use this one? to check.) (0-No: no no benefit; 1-yes: yes no benefit)
G118 Circumcision is required by religion. (all)

2025 Apr 07 (Mon)
=================

Working towards isoplots

We don't want hybrid model anymore. What was it?

How should we share files so that Chyun can make things?

Figure out what to do with the .rmu files

2025 Mar 31 (Mon)
=================
J will read a draft of the manuscript.
To discuss norm and behavior using a newer DHS Kenya data

2025 Mar 24 (Mon)
=================
J tried to fix some weird problems of .Rout thought were fixed

2025 Mar 18 (Mon)
=================
How do we interpret pca, especially benePCA?

The PCA is a little interesting, but not very. The most salient feature is that “other benefits” is almost perpendicular to the main component in three of the four countries. It will be hard to interpret this, because we have no information about what other benefits respondents had in mind in the different countries.

The loadings are all consistent in sign, and we don't see any particular reason to use weightings, so we have decided not to. In particular, we wouldn't want to (effectively) drop “other benefits”.

2025 Mar 10 (Mon)
=================
Chyun had some git errors:
* tried to make daughterPlan_effects_plot.Rout but object 'mod' not found
* tried to make daughterPlan_isoplots.Rout with an error: object 'rtargetname' not found
* tried to make effects_plot.Rout but "betadf" not found.
* tried to make fgcPersist_effects_plot.Rout but found no package called ‘mod’
* tried to make fgcPersist_isoplots.Rout but found no package called ‘RVAideMemoire’

JD is working on PCA pipeline
* quals are working …
* quants are working …
* PCAs are working …
* all_PCA.Rout is working …
* now pcaPlots.pdf

2025 Mar 3 (Mon)
=================
* Git errors to be fixed: couldn't sync
	* This was a Dropbox legacy problem, fixed for Chyun now
* object 'combined_dat' not found in prevalence.Rout to make fgcPersist_clmm.Rout

Make sure scripts and rules are updated before trying to run. 
* There should be no .Rout dependencies
* Scripts should have a shellpipes call

Working on Mike's table stuff:
* several deprecated calls in tables.R
* updated tabletex, getting a mysterious error, and it's all pretty ugly

Anything with rdsave needs to be updated to saveVars or saveEnvironment.

2024 Dec 21 (Sat)
=================

Tried to make fgcPersist_clmm.Rout but failed because object 'combined_dat' not found.
Based on the to all_PCA.Rout.pdf, Chyun wonders how to decide if we prefer PCA- or average-based models.  Need help. 

2024 Dec 20 (Fri)
=================

daughterPlan_clmm.Rout is running now. It was ready to be repiped, because it doesn't use anything in the PCA pathway, apparently.

We need to decide if we prefer PCA- or average-based models. If we prefer average-based, we probably need to rescue the PCA stuff anyway and see what we learned from it.

We didn't look at the daughterPlan_clmm results yet because of fishing concerns.

2024 Dec 18 (Wed)
=================
For next meeting:
To look at all_PCA.Rout.pdf to decide if to exclude certain fgc benefit variables.

We decided the following based on comments from the data lunch and a meeting afterwards with Mike:

The number of don't know on daughterFuture is not really small (kind of on the boarder), so we decided not to drop it.

We will use clmm/ordinal, no brms.  It not working, we will use Ben's suggestions.We shall fit a small dataset of clmm and do experiment; or find a program to fit our small data to find out how it works.

2024 Dec 04 (Wed)
=================

stuck on tables.R; some sort of format errors

Look into values for the Persist variable

git rm *brms*.R

2024 Aug 21 
===========
G116: Intends to have daughter(s) circumcised in future.  This is our main predictor.  This question was answered by women who has daughter not yet cut. They were from G115 (Any daughter who is not circumcise) who answered yes and from G108 (Number of  daughters circumcised) who answered 95 (No daughter circumcised).   

Do we want to add the variable of womem who had daughters cut and yet to decide whether to cut other daughters.

Try to combine heardGC and heardFGC; look at descriptions first.

Why was fgc scaled?

NEED TO CHECK Edu. The recode.rout seems wrong except maybe Kenya.

Wealth code was weird in both recode and select.csv 

heardFGC and heardGC in ml5 recode and select.csv dont' seem to match the original data.

2024 Aug 09 (Fri)
=================

We should review the code in recode.R

I took out gdata because there were conflicts to manage and I thought I would test. Code runs without it – are there any concerns?
CF:  not to me.

Why do we have separate variables for heardGC and heardFGC? Should those have been combined upstream?
CF: make sense to me.  Is select.csv the upstream place to change them?

How does the comment at L20 relate to current code? Is this stuff we need to do?
* Updated now 2024 Aug 12 (Mon)

What is the logic for daughterFgced? We force it to "no" when the number is 95 or yes otherwise?? Then we force it to yes when numDaughterFgced is 0, but it will have already been forced above.
CF:  you are right.  I think we shall change numDaughterFgced to yes and no because we don't need data of how many daughters were cut.

For continueFgc, we set to "Depends" when the answer is "Don't know", but for daughterNotFgced, we use NA. I guess this part could be fine, but we should have notes about all of these decisions and their meaning.

We should not be renaming with “mutate” L49-52; these leaves extra copies of everything.

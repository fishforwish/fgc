Research questions:  
* First, what is the association between mothers' beliefs about the benefits of FGC and their plans for their daughters' FGC future (For this model, we will use daughterPlan_clmm.Rout); 
* second, what is the association between woman's beliefs and their opinion about whether FGC should be continued.(For this model, we will use fgcPersist_clmm.Rout)

Figures and tables:
We like to use the following figures in the ms or at least look at them for inspiration:
* daughterPlan_effects.Plot.Rout.pdf (and fgcPersist_)
* daughterPlan_isoplots.Rout.pdf (and fgcPersist_)
* all_PCA.Rout.pdf
* prevalence_Rout.pdf

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


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

Edu in mls5 recode seems wrong.

Wealth code was weried in both recode and select.csv 

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

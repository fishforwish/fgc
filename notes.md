
2024 Aug 09 (Fri)
=================

We should review the code in recode.R

I took out gdata because there were conflicts to manage and I thought I would test. Code runs without it – are there any concerns?

Why do we have separate variables for heardGC and heardFGC? Should those have been combined upstream?

How does the comment at L20 relate to current code? Is this stuff we need to do?

What is the logic for daughterFgced? We force it to "no" when the number is 95 or yes otherwise?? Then we force it to yes when numDaughterFgced is 0, but it will have already been forced above.

For continueFgc, we set to "Depends" when the answer is "Don't know", but for daughterNotFgced, we use NA. I guess this part could be fine, but we should have notes about all of these decisions and their meaning.

We should not be renaming with “mutate” L49-52; these leaves extra copies of everything.


THIS IS OUT OF DATE, SEE journal.txt

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

----------------------------------------------------------------------

July 25th 2016

ML reimplemented all models via brms and all models ran. There was one problematic model (futurefgcDau_full) and the current solution is increase the HMC sample size. It looks a little better. Moving onto effect plots now.


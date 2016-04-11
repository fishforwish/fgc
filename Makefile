# fgc
### Hooks for the editor to set the default target

current: target

target pngtarget pdftarget vtarget acrtarget: all.mcmcglmm_fit.Rout 

##################################################################

# make files

Sources = Makefile .gitignore README.md LICENSE.md journal.txt stuff.mk

include stuff.mk

##################################################################

### Data folder (since we can't make DHS data public)

Makefile: data

data:
	ln -fs $(Drop)/fgc $@

##################################################################

## Content

Sources += $(wildcard *.R)

Sources += $(wildcard *.ccsv *.tsv)

sets = ke5 ml5 ng5 sl5

#### Recodes
 
.PRECIOUS: %.recode.Rout
%.recode.Rout: data/%.women.RData recodeFuns.Rout religion_basic.ccsv partnership_basic.ccsv recode.R
	$(run-R)
 
recodes.output: $(sets:%=%.recode.Routput)
	cat $^ > $@
 
recodes.objects.output: $(sets:%=%.recode.objects.Routput)
	cat $^ > $@
 
recodes.summary.output: $(sets:%=%.recode.summary.Routput)
	cat $^ > $@

ke5.df.Rout: ke5.benePCA.Rout ke5.recode.Rout df.R
%.df.Rout: %.recode.Rout df.R
	   $(run-R)

%.multivariate_df.Rout: %.df.Rout multivariate_df.R
			$(run-R)

%.futurefgc.Rout: %.df.Rout futurefgc.R
		  $(run-R)

%.futurefgcDau.Rout: %.df.Rout futurefgcDau.R
		     $(run-R)



all.mcmcglmm_fit.Rout: ke5.multivariate_df.Rds ng5.multivariate_df.Rds sl5.multivariate_df.Rds ml5.multivariate_df.Rds mcmcglmm_fit.R
	$(run-R)

all_countries_%.Rout: ke5.%.Rout ng5.%.Rout sl5.%.Rout ml5.%.Rout

######################################################################

## Mike, why do we have so many .mk files? Can we pull these into a Makefile, would that be easier to read and navigate/

Sources += qual.mk quant.mk plots.mk comPlots.mk bioPlots.mk PCA.mk

#### Qual

-include qual.mk

#### Quant

-include quant.mk

#### PCA

-include PCA.mk

#### Plots

-include plots.mk
-include comPlots.mk
-include bioPlots.mk

######################################################################
### Crib

%: data/%
	$(copy)

### Makestuff

-include $(ms)/git.mk
-include $(ms)/visual.mk

-include $(ms)/wrapR.mk
# -include $(ms)/oldlatex.mk

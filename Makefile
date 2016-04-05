# fgc
### Hooks for the editor to set the default target
current: target

target pngtarget pdftarget vtarget acrtarget: ke5.benePCA.Rout 

##################################################################

# make files

Sources = Makefile .gitignore README.md LICENSE.md journal.txt
include stuff.mk

##################################################################

### Data folder (since we can't make DHS data public)

Makefile: data

data:
	ln -fs $(Drop)/fgc $@

##################################################################

## Content

Sources += $(wildcard *.R)

Sources += religion_basic.ccsv partnership_basic.ccsv

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

ke5.multi_fit.Rout: ke5.df.Rout multi_fit.R
%.multi_fit.Rout: %.df.Rout multi_fit.R
		  $(run-R)

ke5.mcmcglmm_fit.Rout: ke5.df.Rout mcmcglmm_fit.R
%.mcmcglmm_fit.Rout: %.df.Rout mcmcglmm_fit.R
		     $(run-R)

all_countries: ke5.df.Rout ng5.df.Rout sl5.df.Rout ml5.df.Rout

######################################################################

Sources += $(wildcard *.mk)

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



######################################################################
### Crib

%: data/%
	$(copy)

### Makestuff

## Change this name to download a new version of the makestuff directory
# Makefile: start.makestuff


-include $(ms)/git.mk
-include $(ms)/visual.mk

-include $(ms)/wrapR.mk
# -include $(ms)/oldlatex.mk

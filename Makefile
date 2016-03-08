# fgc
### Hooks for the editor to set the default target
current: target

target pngtarget pdftarget vtarget acrtarget: ke5.prelim_fit.Rout 

##################################################################

# make files

Sources = Makefile .gitignore README.md stuff.mk LICENSE.md journal.txt
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

ke5.prelim_fit.Rout: ke5.recode.Rout prelim_fit.R
%.prelim_fit.Rout: %.recode.Rout prelim_fit.R
		   $(run-R)

######################################################################

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

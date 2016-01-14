# fgc
### Hooks for the editor to set the default target
current: target

target pngtarget pdftarget vtarget acrtarget: beneQuals.summary.output 

##################################################################

# make files

Drop = ~/Dropbox
Sources = Makefile .gitignore README.md stuff.mk LICENSE.md
include stuff.mk

##################################################################

### Data folder (since we can't make DHS data public)

Makefile: data

data:
	ln -s $(Drop)/fgc $@

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

######################################################################

#### Qual

-include qual.mk

#### Quant

-include quant.mk

#### PCA

-include PCA.mk

######################################################################
##CPC test

cpctest.Rout:	mediaPCAs.summary.output *.mediaQuant.RData saveRDS.R CPCtest.R
		$(run-R)



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

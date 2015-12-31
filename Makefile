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


%.beneQual.Rout: %.recode.Rout bene.R qual.R
		 $(run-R)
 
beneQuals.output: $(sets:%=%.beneQual.Routput)
		  cat $^ > $@
 
beneQuals.objects.output: $(sets:%=%.beneQual.objects.Routput)
			  cat $^ > $@
 
beneQuals.summary.output: $(sets:%=%.beneQual.summary.Routput)
			  cat $^ > $@


######################################################################

%.attQual.Rout: %.recode.Rout att.R qual.R
		$(run-R)
 
attQuals.output: $(sets:%=%.attQual.Routput)
		 cat $^ > $@
 
attQuals.objects.output: $(sets:%=%.attQual.objects.Routput)
			 cat $^ > $@
 
attQuals.summary.output: $(sets:%=%.attQual.summary.Routput)
			 cat $^ > $@


######################################################################

%.mediaQual.Rout: %.recode.Rout media.R qual.R
		  $(run-R)
 
mediaQuals.output: $(sets:%=%.mediaQual.Routput)
		   cat $^ > $@
 
mediaQuals.objects.output: $(sets:%=%.mediaQual.objects.Routput)
			   cat $^ > $@
 
mediaQuals.summary.output: $(sets:%=%.mediaQual.summary.Routput)
			   cat $^ > $@

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

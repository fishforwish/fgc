
# FGC
### Hooks for the editor to set the default target
current: target
-include target.mk

##################################################################

# make files

Sources += Makefile .ignore 
Ignore += .gitignore

ms = makestuff
-include $(ms)/os.mk

# -include $(ms)/perl.def

Sources  += $(ms)
## Sources += $(ms)

Makefile: $(ms) $(ms)/Makefile
$(ms)/%.mk: $(ms)/Makefile ;
$(ms)/Makefile:
	git submodule update -i

Ignore += fgc_DHS
fgc_DHS: dir=~/Dropbox
fgc_DHS:
	$(linkdir)
fgc_DHS/%:
	$(MAKE) fgc_DHS

######################################################################

## notes

Sources += journal.txt notes.md

######################################################################

Sources += manuscript.tex
manuscript.pdf: manuscript.tex

######################################################################

hist.Rout: hist.R

######################################################################

# Refs

Sources += manual.bib auto.rmu
Ignore += refs.bib
refs.bib: auto.bib manual.bib
	$(cat)

######################################################################

# New set import. Carefully

# newwomen = $(newsets:%=fgc_DHS/%.women.RData)

######################################################################

## You need to uncomment these rules to import new data sets, apparently

## This did not work until I made it completely implicit, which is insane. 
## Changing back because working version is dangerous
# fgc_DHS/%.RData: convert_dataset.R
#  	$(MAKE) fgc_DHS/$*.Rout
#  	cd fgc_DHS && /bin/ln -fs .$*.RData $*.RData

# More danger
fgc_DHS/%.Rout: convert_dataset.R
	$(run-R)

######################################################################

fgc_DHS/ke5.Rout: fgc_DHS/KEIR52FL.SAV convert_dataset.R
	$(run-R)
fgc_DHS/ml5.Rout: fgc_DHS/MLIR53FL.SAV convert_dataset.R
	$(run-R)
fgc_DHS/ng5.Rout: fgc_DHS/NGIR53FL.SAV convert_dataset.R
	$(run-R)
fgc_DHS/sl5.Rout: fgc_DHS/SLIR51FL.SAV convert_dataset.R
	$(run-R)



##################################################################

## Content

Sources += $(wildcard *.R)

### Data sets
sets = ke5 ml5 ng5 sl5

######################################################################

### Selecting
select=$(sets:%=%.select.Rout)

## wselect.R needs to be moved to a general place
$(select): %.select.Rout: fgc_DHS/%.Rout select.csv wselect.R
	$(run-R)

Ignore += select.output
select.output: $(sets:%=%.select.Routput)
	cat $^ > $@
select.objects.output: $(sets:%=%.select.objects.Routput)
	cat $^ > $@

select.summary.output: $(sets:%=%.select.summary.Routput)
	cat $^ > $@

######################################################################

### Recoding
Sources += $(wildcard *.ccsv *.tsv)

.PRECIOUS: %.recode.Rout
ke5.recode.Rout: recode.R

%.recode.Rout: %.select.Rout recodeFuns.R religion_basic.ccsv partnership_basic.ccsv recode.R
	$(run-R)

recodes.output: $(sets:%=%.recode.Routput)
	cat $^ > $@

recodes.objects.output: $(sets:%=%.recode.objects.Routput)
	cat $^ > $@

recodes.summary.output: $(sets:%=%.recode.summary.Routput)
	cat $^ > $@

######################################################################

# sl5.benePCA.Rout ml5.benePCA.Rout ng5.benePCA.Rout

ke5.community.Rout: ke5.recode.Rout community.R
%.community.Rout: %.recode.Rout community.R
	$(run-R)



prevalance.Rout: ke5.community.Rds ng5.community.Rds sl5.community.Rds ml5.community.Rds prevalance.R
	$(run-R)


### stop here

%.futurefgc.Rout: %.df.Rout futurefgc.R
	$(run-R)
ke5.futurefgc.Rout: futurefgc.R
ng5.futurefgc.Rout:
sl5.futurefgc.Rout:
ml5.futurefgc.Rout:

%.daughterfgc.Rout: %.df.Rout daughterfgc.R
	$(run-R)

ke5.daughterfgc.Rout: daughterfgc.R
ng5.daughterfgc.Rout:
sl5.daughterfgc.Rout:
ml5.daughterfgc.Rout:


%.futurefgcDau.Rout: %.df.Rout futurefgcDau.R
	$(run-R)
ke5.futurefgcDau.Rout: futurefgcDau.R

%.multivariate.Rout: %.df.Rout multivariate_df.R
			$(run-R)

all_countries_%: ke5.%.Rout ng5.%.Rout sl5.%.Rout ml5.%.Rout
	$(run)

all.%_ind_clmm.Rout: all_countries_% ke5.%.Rds ng5.%.Rds sl5.%.Rds ml5.%.Rds %_ind_clmm.R
	$(run-R) 

all.daughterfgc_ind_clmm.Rout: daughterfgc_ind_clmm.R
all.futurefgc_ind_clmm.Rout: futurefgc_ind_clmm.R
all.futurefgcDau_ind_clmm.Rout: futurefgcDau_ind_clmm.R

all.daughterfgc_full_clmm.Rout: daughterfgc_full_clmm.R
all.futurefgc_full_clmm.Rout: futurefgc_full_clmm.R
all.futurefgcDau_full_clmm.Rout: futurefgcDau_full_clmm.R

all.%_full_clmm.Rout: all_countries_% ke5.%.Rds ng5.%.Rds sl5.%.Rds ml5.%.Rds %_full_clmm.R
	$(run-R)

all.%_ind_varlvlsum.Rout: all.%_ind_clmm.Rout %_ind_varlvlsum.R
	$(run-R)

all.%_full_varlvlsum.Rout: all.%_full_clmm.Rout %_full_varlvlsum.R
	$(run-R)

%.isoplots.Rout: temp_results/all.%_varlvlsum.RData ordfuns.R plotFuns.R iso.R
	$(run-R)

daughterfgc_ind.isoplots.Rout: iso.R
daughterfgc_full.isoplots.Rout: iso.R

futurefgc_ind.isoplots.Rout: iso.R
futurefgc_full.isoplots.Rout: iso.R

futurefgcDau_ind.isoplots.Rout: iso.R
futurefgcDau_full.isoplots.Rout: iso.R

effects.Rout: all.futurefgc_clmm.Rout all.futurefgcDau_clmm.Rout effects.R
	$(run-R)

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

### Makestuff

-include $(ms)/git.mk
-include $(ms)/visual.mk

-include $(ms)/autorefs.mk
-include $(ms)/pandoc.mk
-include $(ms)/wrapR.mk
-include $(ms)/texdeps.mk

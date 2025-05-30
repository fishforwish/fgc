# FGC
### Hooks for the editor to set the default target
current: target
-include target.mk

##################################################################

Ignore += .gitignore

# -include makestuff/perl.def

######################################################################

## Don't know why this is currently suppressed
## Maybe very slow; we should separate data and target dirs
## mirrors += fgc_DHS
Ignore += fgc_DHS

Sources += $(wildcard *.lmk)
## Generic and specific Dropbox rules now in jd.lmk
-include local.mk

## testsetup: ; $(LNF) ../fgc_DHS . ln -s jd.lmk local.mk

######################################################################

## notes

Sources += journal.txt README.md Makefile notes.md
Sources += $(wildcard *.md)

######################################################################

autopipeR = defined

hist.Rout: hist.R

######################################################################

# Refs

Ignore += auto.html bibdir
auto.html: auto.rmu
auto.bib: auto.rmu
Sources += manual.bib auto.rmu
Ignore += refs.bib
refs.bib: auto.bib manual.bib
	$(cat)

######################################################################

## Chyun request 2025 May 26 (Mon)

creq += daughterPlan_effects_plot.Rout.pdf daughterPlan_isoplots.Rout.pdf
creq += fgcPersist_effects_plot.Rout.pdf fgcPersist_isoplots.Rout.pdf
creq += daughterPlan_varlvlsum.Routput and fgcPersist_varlvlsum.Routput
creq += bene.Rout.pdf prevalence_Rout.pdf

crp: $(creq:%=%.op)

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

alldirs += data
Makefile: | data
data:
	git clone https://github.com/dushoff/fgc_data.git $@

Ignore += data

######################################################################

cheat:
	cd fgc_DHS && $(CP) *.Rout *.rd* $(CURDIR)/data/

ifdef convert_files
data/ke8.Rout: fgc_DHS/KEIR8CFL.SAV convert_dataset.R
	$(pipeR)
data/ke5.Rout: fgc_DHS/KEIR52FL.SAV convert_dataset.R
	$(pipeR)
data/ml5.Rout: fgc_DHS/MLIR53FL.SAV convert_dataset.R
	$(run-R)
data/ng5.Rout: fgc_DHS/NGIR53FL.SAV convert_dataset.R
	$(run-R)
data/sl5.Rout: fgc_DHS/SLIR51FL.SAV convert_dataset.R
	$(run-R)
data/sl7.Rout: fgc_DHS/SLIR7AFL.SAV convert_dataset.R
	$(pipeR)	
endif

##################################################################

## Content

Sources += $(wildcard *.R)

### Data sets
sets = ke5 ml5 ng5 sl5
newsets = ke8 sl7

######################################################################

### Selecting
select=$(sets:%=%.select.Rout)

## select.R needs to be moved to a general place
$(select): %.select.Rout: data/%.rda select.csv select.R
	$(pipeR)
## ke8.select.Routput: select.R

Ignore += select.output
select.output: $(sets:%=%.select.Routput)
	cat $^ > $@
select.objects.output: $(sets:%=%.select.objects.Routput)
	cat $^ > $@

## ??? summary code missing?
select.summary.output: $(sets:%=%.select.summary.Routput)
	cat $^ > $@

######################################################################

### Recoding
Sources += $(wildcard *.ccsv *.tsv *.csv)

impmakeR += recode
.PRECIOUS: %.recode.Rout
## ke5.recode.Routput: recode.R
%.recode.Rout: recode.R %.select.rda recodeFuns.rda religion_basic.ccsv partnership_basic.ccsv
	$(pipeR)

recodeFuns.Rout: recodeFuns.R

Ignore += *.output
recodes.output: $(sets:%=%.recode.Routput)
	cat $^ > $@

## ke5.recode.dd.mg.pdf:

######################################################################

## Code for this is in PCA.mk
# sl5.benePCA.Rout ml5.benePCA.Rout ng5.benePCA.Rout
# sl5.benePCA.Rout:

## Make community-level variables
## ke5.community.Rout: community.R
impmakeR += community
%.community.Rout: community.R %.recode.rds recodeFuns.rda
	$(pipeR)

## Combine data sets, make a bunch of plots
prevalence.Rout: prevalence.R ke5.community.rds ng5.community.rds sl5.community.rds ml5.community.rds
	$(pipeR)

## Histogram of wealth. Why?
wealth.Rout: wealth.R prevalence.rds
	$(run-R)

## Table
tables.Rout: tables.R prevalence.rds
	$(pipeR)

table_funs.Rout: table_funs.R
	$(wrapR)

tabletex.Rout: tabletex.R table_funs.rda tables.rds
	$(pipeR)

Ignore += table_output.tex
## table_output.tex: tabletex.R
table_output.tex: tabletex.Rout ; touch $@

Sources += fgc_table.tex
## fgc_table.pdf: fgc_table.tex
fgc_table.pdf: table_output.tex

######################################################################

## fitting using clmm

daughterPlan_clmm.Rout: daughterPlan_clmm.R prevalence.rds
fgcPersist_clmm.Rout: fgcPersist_clmm.R prevalence.rds

## Not updated 2025 Mar 03 (Mon); I have deleted the downstream stuff, which I guess was parallel to daughterPlan and fgcPersist
## hybrid_clmm.Rout: prevalence.Rout hybrid_clmm.R

## calculating variable level p-values

rename_dat.Rout: rename_dat.R
	$(wrapR)

varlvlsums: daughterPlan_varlvlsum.Rout fgcPersist_varlvlsum.Rout
	bash -cl banner

daughterPlan_varlvlsum.Rout: varlvlsum.R daughterPlan_clmm.rda
	$(pipeR)
fgcPersist_varlvlsum.Rout: varlvlsum.R fgcPersist_clmm.rda varlvlsum.R
	$(pipeR)

%_isoplots.Rout: iso.R %_clmm.rda %_varlvlsum.rda ordfuns.rda plotFuns.rda rename_dat.rda
	$(pipeR)
## daughterPlan_isoplots.Rout: iso.R 
## fgcPersist_isoplots.Rout: iso.R

## Have we lost anything that we want?
## all_full_models: futurefgc_full_clmm.Rout futurefgcDau_full_clmm.Rout daughterfgc_full_clmm.Rout

fgcPersist_effects.Rout: single_var_effect.R fgcPersist_clmm.rda rename_dat.rda
	$(pipeR)

daughterPlan_effects.Rout: single_var_effect.R daughterPlan_clmm.rda rename_dat.rda
	$(pipeR)

fgcPersist_effects_plot.Rout: effects_plot.R fgcPersist_effects.rds
	$(pipeR)

daughterPlan_effects_plot.Rout: effects_plot.R daughterPlan_effects.rds
	$(pipeR)

######################################################################

## Mike, why do we have so many .mk files? Can we pull these into a Makefile, would that be easier to read and navigate/

Sources += qual.mk quant.mk plots.mk comPlots.mk bioPlots.mk PCA.mk

#### Qual

-include qual.mk

quals: beneQuals.output mediaQuals.output attQuals.output

#### Quant

-include quant.mk
quants: beneQuants.output mediaQuants.output attQuants.output

#### PCA

-include PCA.mk
PCAs: benePCAs.output mediaPCAs.output attPCAs.out
## pcaPlots.pdf: all_PCA.R

#### Plots

-include plots.mk
-include comPlots.mk
-include bioPlots.mk

######################################################################

### Makestuff

msrepo = https://github.com/dushoff

Makefile: makestuff/01.stamp
makestuff/%.stamp:
	- $(RM) makestuff/*.stamp
	(cd makestuff && $(MAKE) pull) || git clone --depth 1 $(msrepo)/makestuff
	touch $@

-include makestuff/os.mk

-include makestuff/autorefs.mk
-include makestuff/pipeR.mk
-include makestuff/texj.mk
-include makestuff/makegraph.mk
-include makestuff/mirror.mk

-include makestuff/git.mk
-include makestuff/visual.mk

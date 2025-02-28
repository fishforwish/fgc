# FGC
### Hooks for the editor to set the default target
current: target
-include target.mk

##################################################################

Ignore += .gitignore

# -include makestuff/perl.def

######################################################################

Sources += $(wildcard *.lmk)

mirrors += fgc_DHS

Ignore += fgc_DHS
-include local.mk
drop ?= ~/Dropbox

fgc_DHS: dir=$(drop)
fgc_DHS:
	$(linkdir)
fgc_DHS/%:
	$(MAKE) fgc_DHS

testsetup:
	$(LNF) ../fgc_DHS .
	ln -s jd.lmk local.mk

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


fgc_DHS/sl7.Rout: fgc_DHS/SLIR7AFL.SAV convert_dataset.R
	$(pipeR)	

ifdef convert_files
fgc_DHS/ke8.Rout: fgc_DHS/KEIR8CFL.SAV convert_dataset.R
	$(pipeR)
fgc_DHS/ke5.Rout: fgc_DHS/KEIR52FL.SAV convert_dataset.R
	$(pipeR)
fgc_DHS/ml5.Rout: fgc_DHS/MLIR53FL.SAV convert_dataset.R
	$(run-R)
fgc_DHS/ng5.Rout: fgc_DHS/NGIR53FL.SAV convert_dataset.R
	$(run-R)
fgc_DHS/sl5.Rout: fgc_DHS/SLIR51FL.SAV convert_dataset.R
	$(run-R)

endif

##################################################################

## Content

Sources += $(wildcard *.R)

### Data sets
sets = ke5 ml5 ng5 sl5 ke8 sl7

######################################################################

### Selecting
select=$(sets:%=%.select.Rout)

## select.R needs to be moved to a general place
$(select): %.select.Rout: fgc_DHS/%.rda select.csv select.R
	$(pipeR)
## ke8.select.Routput: select.R

Ignore += select.output
select.output: $(sets:%=%.select.Routput)
	cat $^ > $@
select.objects.output: $(sets:%=%.select.objects.Routput)
	cat $^ > $@

select.summary.output: $(sets:%=%.select.summary.Routput)
	cat $^ > $@

######################################################################

### Recoding
Sources += $(wildcard *.ccsv *.tsv *.csv)

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

tabletex.Rout: tables.Rout table_funs.R tabletex.R
	$(pipeR)

Ignore += table_output.tex
table_output.tex: tabletex.Rout ; touch $@

Sources += fgc_table.tex
fgc_table.pdf: table_output.tex


## fitting using clmm

daughterPlan_clmm.Rout: daughterPlan_clmm.R prevalence.rds
fgcPersist_clmm.Rout: prevalence.Rout fgcPersist_clmm.R
hybrid_clmm.Rout: prevalence.Rout hybrid_clmm.R

## calculating variable level p-values


daughterPlan_varlvlsum.Rout: daughterPlan_clmm.Rout varlvlsum.R
	$(pipeR)
fgcPersist_varlvlsum.Rout: fgcPersist_clmm.Rout varlvlsum.R
	$(pipeR)
hybrid_varlvlsum.Rout: hybrid_clmm.Rout varlvlsum.R
	$(pipeR)


daughterPlan_isoplots.Rout: daughterPlan_clmm.Rout daughterPlan_varlvlsum.Rout ordfuns.Rout plotFuns.Rout rename_dat.Rout iso.R
	$(pipeR)

fgcPersist_isoplots.Rout: fgcPersist_clmm.Rout fgcPersist_varlvlsum.Rout ordfuns.Rout plotFuns.Rout rename_dat.Rout iso.R
	$(pipeR)

hybrid_isoplots.Rout: hybrid_clmm.Rout hybrid_varlvlsum.Rout ordfuns.Rout plotFuns.Rout rename_dat.Rout iso.R
	$(pipeR)

all_full_models: futurefgc_full_clmm.Rout futurefgcDau_full_clmm.Rout daughterfgc_full_clmm.Rout

fgcPersist_effects.Rout: fgcPersist_clmm.Rout rename_dat.Rout single_var_effect.R
	$(pipeR)

daughterPlan_effects.Rout: daughterPlan_clmm.Rout rename_dat.Rout single_var_effect.R
	$(pipeR)

hybrid_effects.Rout: hybrid_clmm.Rout rename_dat.Rout single_var_effect.R
	$(pipeR)

fgcPersist_effects_plot.Rout: fgcPersist_effects.Rout effects_plot.R
	$(pipeR)

daughterPlan_effects_plot.Rout: daughterPlan_effects.Rout effects_plot.R
	$(pipeR)

hybrid_effects_plot.Rout: hybrid_effects.Rout effects_plot.R
	$(pipeR)
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

msrepo = https://github.com/dushoff

Makefile: makestuff/00.stamp
makestuff/%.stamp:
	- $(RM) makestuff/*.stamp
	(cd makestuff && $(MAKE) pull) || git clone --depth 1 $(msrepo)/makestuff
	touch $@

-include makestuff/os.mk

## -include makestuff/autorefs.mk
-include makestuff/pipeR.mk
-include makestuff/texi.mk
-include makestuff/makegraph.mk
-include makestuff/mirror.mk

-include makestuff/git.mk
-include makestuff/visual.mk

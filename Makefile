# FGC
### Hooks for the editor to set the default target
current: target

target pngtarget pdftarget vtarget acrtarget: refs.bib 

##################################################################

# make files

Sources += Makefile .ignore 
Ignore += .gitignore

msrepo = https://github.com/dushoff
ms = makestuff
Ignore += local.mk
-include local.mk
-include $(ms)/os.mk

# -include $(ms)/perl.def

Sources  += $(ms)
## Sources += $(ms)

Makefile: $(ms) $(ms)/Makefile
$(ms)/%.mk: $(ms)/Makefile ;
$(ms)/Makefile:
	git submodule update -i

fgc_DHS: dir=~/Dropbox
fgc_DHS:
	$(linkdir)
fgc_DHS/%:
	$(MAKE) fgc_DHS

######################################################################

# Overleaf

overleaf:
	git clone https://git.overleaf.com/6853862bvhsgcwxybdq $@

ofiles = refs.bib

opush = $(ofiles:%=%.po)

$(opush): %.po: %
	$(CP) $< overleaf
	touch $@

opush: $(opush)
	cd overleaf && git add $(^:%.po=%) $ && touch Makefile && $(MAKE) sync

######################################################################

# Refs

Sources += manual.bib auto.rmu
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

fgc_DHS/ke5.new.Rout: fgc_DHS/KEIR52SV/KEIR52FL.SAV
fgc_DHS/ml5.new.Rout: fgc_DHS/MLIR53SV/MLIR53FL.SAV
fgc_DHS/ng5.new.Rout: fgc_DHS/NGIR53SV/NGIR53FL.SAV
fgc_DHS/sl5.new.Rout: fgc_DHS/SLIR51SV/SLIR51FL.SAV

##################################################################

## Content

Sources += $(wildcard *.R)

### Data sets
sets = ke5 ml5 ng5 sl5

######################################################################

### Selecting
select=$(sets:%=%.select.Rout)

## wselect.R needs to be moved to a general place
$(select): %.select.Rout: fgc_DHS/%.new.Rout select.csv wselect.R
	$(run-R)

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
%.recode.Rout: %.select.Rout recodeFuns.Rout religion_basic.ccsv partnership_basic.ccsv recode.R
	$(run-R)

recodes.output: $(sets:%=%.recode.Routput)
	cat $^ > $@

recodes.objects.output: $(sets:%=%.recode.objects.Routput)
	cat $^ > $@

recodes.summary.output: $(sets:%=%.recode.summary.Routput)
	cat $^ > $@

######################################################################

ke5.df.Rout: ke5.benePCA.Rout ke5.recode.Rout df.R
%.df.Rout: %.recode.Rout df.R
	$(run-R)

%.futurefgc.Rout: %.df.Rout futurefgc.R
	$(run-R)

%.daughterfgc.Rout: %.df.Rout daughterfgc.R
	$(run-R)

%.futurefgcDau.Rout: %.df.Rout futurefgcDau.R
	$(run-R)

%.multivariate.Rout: %.df.Rout multivariate_df.R
			$(run-R)

all_countries_%: ke5.%.Rout ng5.%.Rout sl5.%.Rout ml5.%.Rout
	$(run)

all.futurefgc.Rout: futurefgc_fit.R
all.daughterfgc.Rout: daughterfgc_fit.R
all.futurefgcDau.Rout: futurefgcDau_fit.R
all.multivariate.Rout: multivariate_fit.R
all.%.Rout: all_countries_% ke5.%.Rds ng5.%.Rds sl5.%.Rds ml5.%.Rds %_fit.R
	$(run-R)

all.%_ind_clmm.Rout: all_countries_% ke5.%.Rds ng5.%.Rds sl5.%.Rds ml5.%.Rds %_ind_clmm.R
	$(run-R) 


all.%_full_clmm.Rout: all_countries_% ke5.%.Rds ng5.%.Rds sl5.%.Rds ml5.%.Rds %_full_clmm.R
	$(run-R)

all.%_ind_varlvlsum.Rout: all.%_ind_clmm.Rout %_ind_varlvlsum.R
	$(run-R)

all.%_full_varlvlsum.Rout: all.%_full_clmm.Rout %_full_varlvlsum.R
	$(run-R)


%.isoplots.Rout: fgc/.all.%_varlvlsum.RData ordfuns.R plotFuns.R iso.R
	$(run-R)




all.futurefgc_brms.Rout: futurefgc_brms.R
all.daughterfgc_brms.Rout: daughterfgc_brms.R
all.futurefgcDau_brms.Rout: futurefgcDau_brms.R

all.futurefgc_full_brms.Rout: futurefgc_full_brms.R
all.daughterfgc_full_brms.Rout: daughterfgc_full_brms.R
all.futurefgcDau_full_brms.Rout: futurefgcDau_full_brms.R

all.%_brms.Rout: all_countries_% ke5.%.Rds ng5.%.Rds sl5.%.Rds ml5.%.Rds %_brms.R
	$(run-R) 

all.%_full_brms.Rout: all_countries_% ke5.%.Rds ng5.%.Rds sl5.%.Rds ml5.%.Rds %_full_brms.R
	$(run-R) 

effects.Rout: all.futurefgc_clmm.Rout all.futurefgcDau_clmm.Rout effects.R
	$(run-R)

all.futurefgc.effects_brms.Rout: all.futurefgc_brms.Rout effects_brms.Rout
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

-include $(ms)/linkdirs.mk
export autorefs = autorefs
-include autorefs/inc.mk


-include $(ms)/wrapR.mk
# -include $(ms)/oldlatex.mk

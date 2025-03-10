#### Qual

bene.Rout: bene.R
	$(wrapR)

%.beneQual.Rout: qual.R	%.recode.rds bene.rda
	$(pipeR)

## ke8.beneQual.Rout:
 
beneQuals.output:	$(sets:%=%.beneQual.Routput)
			cat $^ > $@

att.Rout: att.R
	$(wrapR)
%.attQual.Rout: qual.R %.recode.rds att.rda
	$(pipeR)
 
attQuals.output:	$(sets:%=%.attQual.Routput)
			cat $^ > $@

media.Rout: media.R
	$(wrapR)

%.mediaQual.Rout:qual.R	%.recode.rds media.rda 
	$(pipeR)
 
mediaQuals.output: $(sets:%=%.mediaQual.Routput)
		   cat $^ > $@

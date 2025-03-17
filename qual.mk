#### Qual

bene.Rout: bene.R
	$(wrapR)

impmakeR += beneQual
%.beneQual.Rout: qual.R	%.recode.rds bene.rda
	$(pipeR)

## ke8.beneQual.Rout:
 
beneQuals.output:	$(sets:%=%.beneQual.Routput)
			cat $^ > $@

## This would be cuter with pipeStar()
att.Rout: att.R
	$(wrapR)

impmakeR += attQual
%.attQual.Rout: qual.R %.recode.rds att.rda
	$(pipeR)
 
attQuals.output:	$(sets:%=%.attQual.Routput)
			cat $^ > $@

media.Rout: media.R
	$(wrapR)

impmakeR += mediaQual
%.mediaQual.Rout:qual.R	%.recode.rds media.rda 
	$(pipeR)
 
mediaQuals.output: $(sets:%=%.mediaQual.Routput)
		   cat $^ > $@

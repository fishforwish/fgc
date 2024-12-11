#### Qual

bene.Rout: bene.R
	$(wrapR)

## sl5.beneQual.Rout: qual.R
%.beneQual.Rout: qual.R	%.recode.rds bene.rda
	$(pipeR)
 
beneQuals.output:	$(sets:%=%.beneQual.Routput)
			cat $^ > $@

%.attQual.Rout:	%.recode.Rout att.R qual.R
		$(run-R)
 
attQuals.output:	$(sets:%=%.attQual.Routput)
			cat $^ > $@
 
attQuals.objects.output:	$(sets:%=%.attQual.objects.Routput)
				cat $^ > $@
 
attQuals.summary.output:	$(sets:%=%.attQual.summary.Routput)
				cat $^ > $@

######################################################################

%.mediaQual.Rout:	%.recode.Rout media.R qual.R
			$(run-R)
 
mediaQuals.output: $(sets:%=%.mediaQual.Routput)
		   cat $^ > $@
 
mediaQuals.objects.output:	$(sets:%=%.mediaQual.objects.Routput)
				cat $^ > $@
 
mediaQuals.summary.output:	$(sets:%=%.mediaQual.summary.Routput)
				cat $^ > $@


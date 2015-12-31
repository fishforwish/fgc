#### Qual


%.beneQual.Rout:	%.recode.Rout bene.R qual.R
			$(run-R)
 
beneQuals.output:	$(sets:%=%.beneQual.Routput)
			cat $^ > $@
 
beneQuals.objects.output:	$(sets:%=%.beneQual.objects.Routput)
				cat $^ > $@
 
beneQuals.summary.output:	$(sets:%=%.beneQual.summary.Routput)
				cat $^ > $@


######################################################################

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


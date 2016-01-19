
%.benePCA.Rout: %.beneQuant.Rout catPCA.R
	$(run-R)

benePCAs.output: $(benefits:%=%.benePCA.Routput)
	cat $^ > $@

benePCAs.objects.output: $(benefits:%=%.benePCA.objects.Routput)
	cat $^ > $@

benePCAs.summary.output: $(benefits:%=%.benePCA.summary.Routput)
	cat $^ > $@

%.attPCA.Rout: %.attQuant.Rout catPCA.R
	$(run-R)

attPCAs.output: $(sets:%=%.attPCA.Routput)
	cat $^ > $@

attPCAs.objects.output: $(sets:%=%.attPCA.objects.Routput)
	cat $^ > $@

attPCAs.summary.output: $(sets:%=%.attPCA.summary.Routput)
	cat $^ > $@

%.mediaPCA.Rout: %.mediaQuant.Rout catPCA.R
	$(run-R)

mediaPCAs.output: $(sets:%=%.mediaPCA.Routput)
	cat $^ > $@

mediaPCAs.objects.output: $(sets:%=%.mediaPCA.objects.Routput)
	cat $^ > $@

mediaPCAs.summary.output: $(sets:%=%.mediaPCA.summary.Routput)
	cat $^ > $@

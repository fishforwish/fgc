
all_PCA.Rout: ke5.benePCA.Rds ml5.benePCA.Rds sl5.benePCA.Rds ng5.benePCA.Rds all_PCA.R
	$(pipeR)

## sl5.benePCA.Rout: catPCA.R
%.benePCA.Rout: %.beneQuant.rda catPCA.R
	$(pipeR)

benePCAs.output: $(sets:%=%.benePCA.Routput)
	cat $^ > $@

benePCAs.objects.output: $(sets:%=%.benePCA.objects.Routput)
	cat $^ > $@

benePCAs.summary.output: $(sets:%=%.benePCA.summary.Routput)
	cat $^ > $@

%.attPCA.Rout: %.attQuant.rda catPCA.R
	$(pipeR)

attPCAs.output: $(sets:%=%.attPCA.Routput)
	cat $^ > $@

attPCAs.objects.output: $(sets:%=%.attPCA.objects.Routput)
	cat $^ > $@

attPCAs.summary.output: $(sets:%=%.attPCA.summary.Routput)
	cat $^ > $@

%.mediaPCA.Rout: %.mediaQuant.rda catPCA.R
	$(pipeR)

mediaPCAs.output: $(sets:%=%.mediaPCA.Routput)
	cat $^ > $@

mediaPCAs.objects.output: $(sets:%=%.mediaPCA.objects.Routput)
	cat $^ > $@

mediaPCAs.summary.output: $(sets:%=%.mediaPCA.summary.Routput)
	cat $^ > $@

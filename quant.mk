
%.beneQuant.Rout: %.beneQual.rda levelcodes_bene.tsv quant.R
	$(pipeR)

beneQuants.output: $(sets:%=%.beneQuant.Routput)
	cat $^ > $@

beneQuants.objects.output: $(sets:%=%.beneQuant.objects.Routput)
	cat $^ > $@

beneQuants.summary.output: $(sets:%=%.beneQuant.summary.Routput)
	cat $^ > $@

%.attQuant.Rout: %.attQual.rda levelcodes_att.tsv quant.R
	$(pipeR)

attQuants.output: $(sets:%=%.attQuant.Routput)
	cat $^ > $@

attQuants.objects.output: $(sets:%=%.attQuant.objects.Routput)
	cat $^ > $@

attQuants.summary.output: $(sets:%=%.attQuant.summary.Routput)
	cat $^ > $@

## ke5.mediaQuant.Rout: quant.R levelcodes_media.tsv
%.mediaQuant.Rout: %.mediaQual.rda levelcodes_media.tsv quant.R
	$(pipeR)

mediaQuants.output: $(sets:%=%.mediaQuant.Routput)
	cat $^ > $@

mediaQuants.objects.output: $(sets:%=%.mediaQuant.objects.Routput)
	cat $^ > $@

mediaQuants.summary.output: $(sets:%=%.mediaQuant.summary.Routput)
	cat $^ > $@

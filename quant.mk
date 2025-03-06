
## ke5.beneQuant.Rout: quant.R levelcodes_bene.tsv
%.beneQuant.Rout: %.beneQual.rda levelcodes_bene.tsv quant.R
	$(run-R)

beneQuants.output: $(sets:%=%.beneQuant.Routput)
	cat $^ > $@

beneQuants.objects.output: $(sets:%=%.beneQuant.objects.Routput)
	cat $^ > $@

beneQuants.summary.output: $(sets:%=%.beneQuant.summary.Routput)
	cat $^ > $@

%.attQuant.Rout: %.attQual.Rout levelcodes_att.tsv quant.R
	$(run-R)

attQuants.output: $(sets:%=%.attQuant.Routput)
	cat $^ > $@

attQuants.objects.output: $(sets:%=%.attQuant.objects.Routput)
	cat $^ > $@

attQuants.summary.output: $(sets:%=%.attQuant.summary.Routput)
	cat $^ > $@

%.mediaQuant.Rout: %.mediaQual.Rout levelcodes_media.tsv quant.R
	$(run-R)

mediaQuants.output: $(sets:%=%.mediaQuant.Routput)
	cat $^ > $@

mediaQuants.objects.output: $(sets:%=%.mediaQuant.objects.Routput)
	cat $^ > $@

mediaQuants.summary.output: $(sets:%=%.mediaQuant.summary.Routput)
	cat $^ > $@

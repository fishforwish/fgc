%.benePlot.Rout: %.benePCA.Rout benePlots.R
	$(run-R)

benePlots.output: $(sets:%=%.benePlot.Routput)
	cat $^ > $@


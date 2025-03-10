%.benePlot.Rout: %.benePCA.Rout benePlots.R
	$(pipeR)

benePlots.output: $(sets:%=%.benePlot.Routput)
	cat $^ > $@


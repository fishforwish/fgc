## ke5.benePlot.Rout: benePlots.R
%.benePlot.Rout: benePlots.R %.benePCA.rda
	$(pipeR)

benePlots.output: $(sets:%=%.benePlot.Routput)
	cat $^ > $@


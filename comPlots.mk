%.comPlot.Rout: %.benePlot.Rout comPlots.R
	$(run-R)

comPlots.output: $(sets:%=%.comPlot.Routput)
	cat $^ > $@


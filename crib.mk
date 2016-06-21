%.Rout: $(Drop)/fgc/.%.RData
	/bin/cp -f $< .
	touch $@


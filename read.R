raw <- readLines(input_files[[1]])
sel <- grep("^[^#]", raw, value=TRUE)


print(sel)

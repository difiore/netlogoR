library(nlrx)

# Example
##### -----
netlogopath <- file.path("/Users/ad26693/Desktop/NetLogo 6.2.0 from tar")
modelpath <- file.path(netlogopath, "app/models/Sample Models/Biology/Wolf Sheep Predation.nlogo")
outpath <- file.path("/Users/ad26693/Desktop")

nl <- nl(nlversion = "6.2.0",
	nlpath = netlogopath,
	modelpath = modelpath,
	jvmmem = 1024)

nl@experiment <- experiment(expname="wolf-sheep",
	outpath=outpath,
	repetition=1,
	tickmetrics="true",
	idsetup="setup",
	idgo="go",
	runtime=50,
	evalticks=seq(40,50),
	metrics=c("count sheep", "count wolves", "count patches with [pcolor = green]"),
	variables = list('initial-number-sheep' = list(min=50, max=150, qfun="qunif"),
									 'initial-number-wolves' = list(min=50, max=150, qfun="qunif")),
	constants = list("model-version" = "\"sheep-wolves-grass\"",
	"grass-regrowth-time" = 30,
	"sheep-gain-from-food" = 4,
	"wolf-gain-from-food" = 20,
	"sheep-reproduce" = 4,
	"wolf-reproduce" = 5,
	"show-energy?" = "false"))

nl@simdesign <- simdesign_lhs(nl=nl,
	samples=2,
	nseeds=2,
	precision=3)

# Evaluate nl object:
eval_variables_constants(nl)
print(nl)

# Run all simulations (loop over all siminputrows and simseeds)
results <- run_nl_all(nl)

setsim(nl, "simoutput") <- results

# Write output to outpath of experiment within nl
write_simoutput(nl)

# Do further analysis:
analyze_nl(nl)

# MINE
##### -----

# Although the documentation says this:
# "MacOS, please use the Linux tar.gz version of
# NetLogo (either from the NetLogo Homepage or
# by using the download_netlogo() function).
# The dmg version from the NetLogo homepage is
# not compatible with nlrx." the following still seems to work if the model is in the models folder

# netlogopath <- file.path("/Applications/NetLogo 6.2.0")
# modelpath <- file.path("/Applications/NetLogo 6.2.0/models/GENESYS 6.1.1-2021-06-15-no-R generic version.nlogo")

netlogopath <- file.path("/Users/ad26693/Desktop/NetLogo 6.2.0 from tar")

modelpath <- file.path("/Users/ad26693/Desktop/NetLogo 6.2.0 from tar/app/models/GENESYS 6.1.1-2021-06-15-no-R generic version.nlogo")

outpath <- file.path("/Users/ad26693/Desktop/")

nl <- nl(nlversion = "6.2.0", nlpath = netlogopath,
	modelpath = modelpath,
	jvmmem = 1024)

nl@experiment <- experiment(expname="experiment",
	outpath = outpath,
	repetition = 1, # should be one unless random seed is set new in netlogo model itself
	tickmetrics = "false",
	idsetup = c("startup", "get-all-data-filename", "load-all-data"),
	idgo = c("run-simulation"),
	runtime = 0,
	metrics = c("count turtles"),
	variables = list(),
	constants = list(
		"years-to-run" = 100,
		"export-freq" = 25,
		# "set-rand-seed" = 0,
		"by-age-and-sex" = "false",
		"infanticide" = "false",
		"p-long-distance" = 0.15,
		"export-excel" = "false",
		"export-fstat" = "false",
		"output-video" = "false",
		"mutation-exp" = -1,
		"M-dispersal" = 0.2,
		"F-dispersal" = 0.2,
		"F-suppression" = "true",
		"female-litter-size" = 2,
		"home-range-r" = 17.442,
		"p-survive-inbreed" = 1,
		"max-N-dispersals" = 3,
		"male-skew" = 0.5,
		"p-males-mating" = 0.5,
		"number-loci" = 20,
		"ignore-type" = "true",
		"immigration" = "true",
		"plots-on" = "false",
		"shape-on" = "false",
		"p-EG-paternity" = 0.1,
		"current-year" = 2014,
		"p-subadults" = 0.128,
		"show-sire-links" = "false",
		"export-kingroup" = "false",
		"export-genalex" = "true",
		"p-adults" = 0.514,
		"total-groups" = 36,
		"pixels-per-step" = 18,
		"max-alleles" = 20,
		"image-on" = "false",
		"imm-per-year" = 5,
		"p-males" = 0.5,
		"raster-on" = "false",
		"number-pops" = 1,
		"zoom-level" = 1,
		"parallel-disp" = "false",
		"p-infants" = 0.212,
		"pop-to-plot" = 1,
		"transparency" = 100,
		"w-dependent" = "true",
		"export-genodive" = "true",
		"p-juveniles" = 0.146,
		"inbreed-w-sire" = "false",
		"recalc-frequency" = 25
# for some reason, cannot specific values for this
# GUI items/constants that are set in the model with
# choosers...
		# "lattice-type" = "square"
		# "imm-rate-set" = "as-a-constant",
		# "mutation-model" = "no mutation",
		# "genetic-background" = "all-individuals",
		# "output-to-file" = "yes",
		# "pedigree-format" = "kingroup (.csv)",
		# "dispersal-model" = "stepping-stone",
		# "output-to-screen" = "no",
		# "male-mating-model" = "MM-shared",
		# "ref-pop-for-imm-genos" = "all",
		# "bias-correction" = "none",
		# "data-format" = "genesys (.gen)",
		# "border-behavior" = "reflecting",
		# "regulation-model" = "keep-initial-number",
		## "imm-dispersal-model" = "stepping-stone"
		)
	)

nl@simdesign <- simdesign_simple(nl=nl, nseeds=1)
# nseeds = number of repetitions with same parameters and different seeds

# Evaluate nl object:
report_model_parameters(nl)
eval_variables_constants(nl)
print(nl)

# Run all simulations (loop over all siminputrows and simseeds)
results <- run_nl_all(nl)

setsim(nl, "simoutput") <- results

# Write output to outpath of experiment within nl
write_simoutput(nl)

# Do further analysis:
analyze_nl(nl)


######
######
######
library(kinship2)
library(tidyverse)
f <- "/Users/ad26693/Desktop/GENESYS OUTPUT 2021-06-19 18-14-28 SEED 0/PEDIGREE 2021-06-19 18-14-28.csv"
d <- read_csv(f,col_names = TRUE, skip = 4)
head(d,4)
d <- select(d, IDNUM, SIRE, DAM, SEX)
head(d,4)
e <- d %>% na_if(NA)
head(e,4)
e$SIRE <- tidyr::replace_na(e$SIRE, 0)
e$DAM <- tidyr::replace_na(e$DAM,0)
e$IDNUM <- as.integer(e$IDNUM)
e$SIRE <- as.integer(e$SIRE)
e$DAM <- as.integer(e$DAM)
head(e,4)

allid <- tibble(id = unique(c(e$IDNUM,e$SIRE, e$DAM)))
g <- left_join(allid, e, by= c("id" = "IDNUM"))
head(g,4)
names(g) <- c("id", "dadid", "momid", "sex")
h <- fixParents(id = g$id, dadid=g$dadid, momid=g$momid,sex=g$sex, missid=0)
head(h,4)
h <- h %>% filter(id != 0)
i <- pedigree(id=h$id,dadid = h$dadid, momid = h$momid, sex= h$sex, missid=0)
i
j <- kinship(i)
library(reshape2)
k <- setNames(melt(j), c('rows', 'vars', 'values'))
k <- filter(k, values > 0.5)

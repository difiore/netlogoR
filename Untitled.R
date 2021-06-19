library(RNetLogo)
nl.path <- "/Applications/NetLogo 6.2.0/NetLogo 6.2.0.app"
Sys.setenv(NOAWT=1)
library(JGR)
Sys.unsetenv("NOAWT")
JGR()
NLStart(nl.path)


Sys.setenv(NOAWT=1)
library(RNetLogo)
nl.path <- "/Applications/NetLogo 6.2.0/NetLogo 6.2.0.app"
nl.jarname <- "netlogo-6.2.0.jar"
NLStart(nl.path, gui = FALSE, nl.jarname = nl.jarname)


library(nlrx)

# Example
##### -----
netlogopath <- file.path("/Users/ad26693/Desktop/NetLogo 6.2.0")
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
netlogopath <- file.path("/Applications/NetLogo 6.2.0")

modelpath <- file.path("/Users/ad26693/Development/repos/genesys/GENESYS 6.1.1-2020-09-09 generic version.nlogo")
outpath <- file.path("/Users/ad26693/Desktop/")

nl <- nl(nlversion = "6.2.0", nlpath = netlogopath,
	modelpath = modelpath,
	jvmmem = 1024)

nl@experiment <- experiment(expname="experiment",
	outpath = outpath,
	repetition = 2,
	tickmetrics = "false",
	idsetup = c("startup","load-all-data"),
	idgo = c("run-simulation"),
	runtime = 0,
	variables = list("number-pops" = list(min = 1, max = 1, qfun = "qunif")),
constants = list("by-age-and-sex" = "false",
	"infanticide" = "false",
	"years-to-run" = 100,
	"p-long-distance" = 0.15,
	"export-excel" ="false",
	"export-fstat" = "false",
	"output-video" = "false",
	"lattice-type" = "square",
	"mutation-exp" = -1,
	"M-dispersal" = 0.2,
	"F-dispersal" = 0.2,
	"F-suppression" = "true",
	"imm-rate-set" = "as-a-constant",
	"female-litter-size" = 2,
	"immigration" = "true",
	"set-rand-seed" = 0,
	"home-range-r" = 17.442,
	"p-survive-inbreed" = 1,
	"ignore-type" = "true",
	"mutation-model" = "no mutation",
	"max-N-dispersals" = 3,
	"genetic-background" = "all-individuals",
	"male-skew" = 0.5,
	"p-males-mating" = 0.5,
	"number-loci" = 20,
	"plots-on" = "false",
	"pedigree-format" = "kingroup (.csv)",
	"p-EG-paternity" = 0.1,
	"shape-on" = "false",
	"current-year" = 2014,
	"dispersal-model" = "stepping-stone",
	"p-subadults" = 0.128,
	"output-to-screen" = "no",
	"show-sire-links" = "false",
	"output-to-file" = "yes",
	"export-kingroup" = "false",
	"export-genalex" = "true",
	"p-adults" = 0.514,
	"total-groups" = 36,
	"pixels-per-step" = 18,
	"male-mating-model" = "MM-shared",
	"max-alleles" = 20,
	"image-on" = "false",
	"imm-per-year" = 5,
	"p-males" = 0.5,
	"raster-on" = "false",
	"export-freq" = 50,
	"ref-pop-for-imm-genos" = "all",
	# "number-pops" = 1,
	"zoom-level" = 1,
	"bias-correction" = "none",
	"data-format" = "genesys (.gen)",
	"parallel-disp" = "false",
	"p-infants" = 0.212,
	"pop-to-plot" = 1,
	"border-behavior" = "reflecting",
	"transparency" = 100,
	"w-dependent" = "true",
	"regulation-model" = "keep-initial-number",
	"export-genodive" = "true",
	"p-juveniles" = 0.146,
	"imm-dispersal-model" = "stepping-stone",
	"inbreed-w-sire" = "false",
	"recalc-frequency" = 25))

nl@simdesign <- simdesign_lhs(nl=nl,
															samples=1,
															nseeds=1,
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



####  R test
####
# Example
##### -----
netlogopath <- file.path("/Users/ad26693/Desktop/NetLogo 6.2.0")
modelpath <- file.path(netlogopath, "app/models/tester.nlogo")
outpath <- file.path("/Users/ad26693/Desktop")

nl <- nl(nlversion = "6.2.0",
				 nlpath = netlogopath,
				 modelpath = modelpath,
				 jvmmem = 1024)

nl@experiment <- experiment(expname="tester",
														outpath=outpath,
														repetition=1,
														tickmetrics="false",
														idsetup="test",
														idgo="go",
														runtime=0,
														metrics=c("count turtles"),
														variables = list('num-t' = list(min=10, max=100, qfun="qunif"))
														)

nl@simdesign <- simdesign_lhs(nl=nl,
															samples=4,
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

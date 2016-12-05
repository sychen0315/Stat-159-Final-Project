# Run "make" to reproduce report

.PHONY: all data data_clean data_categorize train_test_split eda ols ridge lasso pcr plsr ols_cluster regressions report slides session clean tests

# Set variables
data_set = data/data-sets/original-data-set/Most-Recent-Cohorts-All-Data-Elements.csv
data_source = https://ed-public-download.apps.cloud.gov/downloads/Most-Recent-Cohorts-All-Data-Elements.csv

data_cleaning = code/scripts/data-cleaning.R
clean_data = data/data-sets/cleaned-data-set/clean-data.csv

data_categorize_script = code/scripts/categorize-script.R
categorized_data = data/data-sets/cleaned-data-set/categorized-data.csv

train_test_split = code/scripts/train-test-split.R
overall_train_set = data/data-sets/train-test-data-set/overall-train-set.csv
overall_test_set = data/data-sets/train-test-data-set/overall-test-set.csv
cluster_data = data/data-sets/train-test-data-set/overall-data-set-regression.csv

eda_script = code/scripts/eda-script.R

ols_script = code/scripts/ols-regression-overall.R
pcr_script = code/scripts/pcr-regression-overall.R
ridge_script = code/scripts/ridge-regression-overall.R
lasso_script = code/scripts/lasso-regression-overall.R
plsr_script = code/scripts/plsr-regression-overall.R

ols_cluster = code/scripts/ols-regression-cluster.R

# All target
all: data data_clean data_categorize eda regressions session report slides

# Data target: Download data from the url
data:
	cd data/data-sets/original-data-set && curl -O $(data_source)

# data_clean: Clean data
data_clean:  $(data_cleaning) $(data_set)
	Rscript $<

# data_categorize: Categorzie data into 8 groups based on region and major city.
data_categorize: $(data_categorize_script) $(clean_data)
	Rscript $<

# train_test_split: separate into test and train set
train_test_split: $(train_test_split) $(categorized_data)
	Rscript $<

# Eda target: Run eda script to calculate summary statistics
eda: $(eda_script) $(clean_data) $(categorized_data)
	Rscript $<

# ols target: Run ols regression and generate ols estimators
ols: $(ols_script) $(overall_train_set) $(overall_test_set) $(cluster_data)
	Rscript $<

# ridge target: Run ridge regression and generate ridge estimators
ridge: $(ridge_script) $(overall_train_set) $(overall_test_set) $(cluster_data)
	Rscript $<

# lasso target: Run lasso regression and generate lasso estimators
lasso: $(lasso_script) $(overall_train_set) $(overall_test_set) $(cluster_data)
	Rscript $<

# pcr target: Run pcr regression and generate pcr estimators
pcr: $(pcr_script) $(overall_train_set) $(overall_test_set) $(cluster_data)
	Rscript $<

# plsr target: Run plsr regression and generate plsr estimators
plsr: $(plsr_script) $(overall_train_set) $(overall_test_set) $(cluster_data)
	Rscript $<

#ols targe" run ols regression over clustered data
ols_cluster: $(ols_cluster) $(cluster_data)
	Rscript $<

# regressions target: Run all 6 regressions
regressions:
	make ols
	make ridge
	make lasso
	make pcr
	make plsr
	make ols_cluster

# Report target: Produce reports by compiling Rmarkdown to pdf
report: report/sections/*.Rnw
	cat report/sections/*.Rnw > report/report.Rnw
	cd report && Rscript -e "library(knitr); Sweave2knitr('report.Rnw', output = 'report.tex')"
	
# Slides target: Generate slides
slides:
	Rscript -e "library(rmarkdown); render('slides/slides.Rmd', 'ioslides_presentation')"

# Shiny target: Run the shiny app
shiny: $(clean_data)
	R -e "shiny::runApp('shiny-apps/', launch.browser=TRUE)"

# Session target: Run sessioninfo script
session:
	bash session.sh

# Tests target: Run unit test for regression_functions.R
tests: code/test-that.R code/tests/test-regression.R
	Rscript code/test-that.R

# Clean target: Delete report.pdf
clean:
	rm -f report/report.pdf

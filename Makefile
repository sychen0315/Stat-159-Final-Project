# Run "make" to reproduce report

.PHONY: all data data_clean data_categorize train_test_split eda ols ridge lasso pcr plsr ols_cluster regressions report slides session clean

# Set variables
data_set = data/data-sets/original-data-set/Most-Recent-Cohorts-All-Data-Elements.csv
data_source = https://ed-public-download.apps.cloud.gov/downloads/Most-Recent-Cohorts-All-Data-Elements.csv

data_cleaning = code/scripts/data-cleaning.R
clean_data = data/data-sets/cleaned-data-set/clean-data.csv

data_categorize = code/scripts/categrozie-script.R
categorized_data = data/data-sets/cleaned-data-set/categorized-data.csv

train_test_split = code/scripts/train-test-split.R


eda_script = code/scripts/eda-script.R

ols_script = code/scripts/ols-regression-overall.R
pcr_script = code/scripts/pcr-regression-overall.R
ridge_script = code/scripts/ridge-regression-overall.R
lasso_script = code/scripts/lasso-regression-overall.R
plsr_script = code/scripts/plsr-regression-overall.R

ols_cluster = code/scripts/ols-regression-cluster.R

# All target
all: data data_clean eda session regressions report slides

# Data target: Download data from the url
data:
	cd data/data-sets/original-data-set && curl -O $(data_source)

# data_clean: Clean data
data_clean:  $(data_cleaning) $(data_set)
	Rscript $<

# data_categorize: Categorzie data into 8 groups based on region and major city.
data_categorize: $(data_categorize) $(categorized_data)
	Rscript $<

# train_test_split: separate into test and train set
train_test_split: $(train_test_split)
	Rscript $<

# Eda target: Run eda script to calculate summary statistics
eda: $(eda_script) $(clean_data) $(categorized_data)
	Rscript $<

# ols target: Run ols regression and generate ols estimators
ols: $(ols_script)
	Rscript $<

# ridge target: Run ridge regression and generate ridge estimators
ridge: $(ridge_script)
	Rscript $<

# lasso target: Run lasso regression and generate lasso estimators
lasso: $(lasso_script)
	Rscript $<

# pcr target: Run pcr regression and generate pcr estimators
pcr: $(pcr_script)
	Rscript $<

# plsr target: Run plsr regression and generate plsr estimators
plsr: $(plsr_script)
	Rscript $<

ols_cluster: $(ols_cluster)
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
report: report/sections/*.Rmd
	cat report/sections/*.Rmd > report/report.Rmd
	cd report && Rscript -e "library(rmarkdown); render('report.Rmd', 'pdf_document')"


# slides target: Generate slides
slides:
	Rscript -e "library(rmarkdown); render('slides/slides.Rmd', 'ioslides_presentation')"

# Session target: Run sessioninfo script
session:
	bash session.sh

# Tests target: Run unit test for regression_functions.R
tests: code/test-that.R code/tests/test-regression.R
	Rscript code/test-that.R

# Clean target: Delete report.pdf
clean:
	rm -f report/report.pdf

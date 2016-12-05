# UC Berkeley Statistics 159 Fall 2016 Final Project

## Introduction

In this project, our objective is to explore the differences between similar schools in terms of demographics and programs offered and how those differences contribute to school competitiveness based on the dataset available on College Scorecard https://collegescorecard.ed.gov/data/. The client of our consulting project is a group of school administrators, and our data analysis is aimed to provide them with suggestions regarding what factors should they focus on and how to maximize their returns on investment in order to improve their school competitiveness. The requirement for this project can be found at https://github.com/ucb-stat159/stat159-fall-2016/blob/master/projects/proj03/stat159-final-project.pdf. 

## Structure

The structure of this project is listed as following:

```
stat159-fall2016-project2/
    .gitignore
    README.md
    LICENSE
    Makefile
    session-info.txt
    session.sh
    code/
      README.md
      functions/
        ...
      scripts/
        ...
      tests/
        ...
    data/
      README.md
      data-sets/
        ...
      eda-outputs/
	      ...
      regression-data/
	      ...
    images/
      README.md
      eda-images/
        ...
      regression-plot/
        ...
    slides/
      slides.html
      slides.Rmd
    report/
      report.Rmd
      report.pdf
      sections/
        ...
    shinyapp/
```

## Reproduction Steps

Install R packages used in this project:

```
install.packages("xtable")
install.packages("pls")
install.packages("glmnet")
install.packages("Matrix")
install.packages("testthat")
install.packages("devtools")
install.packages("knitr")
install.packages("ggplot2")
install.packages("ggmap")
install.packages("shiny")
install.packages("leaflet")
install.packages("RColorBrewer")
install.packages("dplyr")
install.packages("lattice")
```

To reproduce the analysis:

1. Clone this project.

2. Navigate to the folder Stat-159-Final-Project.

3. Run `make` in the terminal to regenerate all the output files, graphs and report. 

   Can also reproduce the result step by step by running:
 
  `make data` to download the data Credit.csv.
  
  `make data_clean` to clean the raw data and separate it into test and train set for model fitting.

  `make data_categorize` to separate the clean data into 8 clusters.

  `make train_test_split` to split the clean data into train set and test set.

  `make eda` to perform exploratory data analysis and generate summary statistics and correlation information.

  `make ols` to run ols regression and generate ols estimators.

  `make ridge` to run ridge regression and generate ridge estimators.

  `make lasso` to run lasso regression and generate lasso estimators.

  `make pcr` to run pcr regression and generate pcr estimators.

  `make plsr` to run plsr regression and generate plsr estimators.

  `make ols_cluster` to run ols regression over clustered data.

  `make regressions` to run all 6 regressions.

  `make session` to generate session-info.txt including R's session information and version of tools used in the project
  
  `make report` to combine different sections of the report into one Rmd file and generate the pdf version.
  
  `make slides` to generate the slides.
  
  `make clean` to delete the pdf version of the report. 

4. Run `make tests` to run unit tests for `regression-functions.R`. 

## Contributor

Aoyi Shan

UC Berkeley Class of 2017

Statistics, B.A. | Business Administration, B.S.

Email: aoyi95@berkeley.edu

Yukun(Diane) He

UC Berkeley Class of 2017

Statistics, B.A.

Email: yukunhe@berkeley.edu

Siyu Chen

UC Berkeley Class of 2017
 
Civil Engineering, B.S.

Email: siyu.chen@berkeley.edu

Shuotong Wu

UC Berkeley Class of 2017

Statistics, B.A. | Computer Science, B.A.

Email: spritewu@berkeley.edu

## License

All media contents are licensed under a [Creative Commons Attribution-ShareAlike 4.0 International License](http://creativecommons.org/licenses/by-sa/4.0/).

All code is licensed under [BSD-2.0](https://opensource.org/licenses/BSD-2-Clause).

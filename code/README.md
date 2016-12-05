## Code README

This code folder contains three sub-folders: functions, scripts and tests. 

* The functions folder contains eda-functions and regression-functions.
  
  * `eda-functions.R` contains functions used to automate the process of sinking summary statistics for each variable, quantitative and qualitative, and generating related graphs including histogram, boxplot and conditional boxplot. 
  
  * `regression-functions.R` contains functions used to calculate RSS, TSS, R^2, F-Statistic, and RSE.
  
* The scripts folder contains all of 13 scripts used in this project.
  
 * `session-info.R` contains code for generating information about our current session, including R packages we used and the R's session information.  
 
 * `data-cleaning.R` contains code for deleting NA values, dividing data by regions, adding additional necessary variables and creating a new dataframe for the clean data. 
 
 * `eda-script.R` contains our process of implementing exploratory data analysis such as calculating summary statistics and generate graphs. 

 * `categorize-script.R` contains code for dividing data into 8 clusters.

 * `anova.R` contains code for conducting anova analysis for each of 8 clusters.

 * `ols-regression-overall.R` contains code for conducting ols regression analysis.

 * `ridge-regression-overall.R` contains code for conducting ridge regression analysis.

 * `lasso-regression-overall.R` contains code for conducting lasso regression analysis. 

 * `pcr-regression-overall.R` contains code for conducting pcr regression analysis.

 * `plsr-regression-overall.R` contains code for conducting plsr regression analysis.

 * `train-test-split.R` contains code for spliting data into train set and test set.

 * `ols-regression-cluster.R` contains code for fitting ols regression model for data of each cluster.

 * `data-visualization.R` contains code for 

* The test folder contains unit test for `test-regression.R`. 

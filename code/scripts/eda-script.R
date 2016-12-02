source("code/functions/eda-functions.R")

clean_data <- read.csv("data/data-sets/cleaned-data-set/clean-data.csv")
categorized_data <- read.csv("data/data-sets/cleaned-data-set/categorized-data.csv")
quantitative_output_file <- "data/data-outputs/eda-outputs/eda-output-quantitative.txt"
qualitative_output_file <- "data/data-outputs/eda-outputs/eda-output-qualitative.txt"
correlation_output_file <- "data/data-outputs/eda-outputs/eda-output-correlation.txt"
anova_output_file <- "data/data-outputs/eda-outputs/eda-output-anova.txt"
cluster_output_file <- "data/data-outputs/eda-outputs/eda-output-cluster.txt"


sink(file = quantitative_output_file)

quantitative_variables <- c("UGDS_BLACK", "UGDS_HISP", "UGDS_ASIAN", "UGDS_ASIAN", "UGDS_AIAN", "UGDS_NHPI", 
                            "UGDS_2MOR","UGDS_NRA","UGDS_UNKN","UGDS_WHITE","UGDS","ADM_RATE","COSTT4_A","MD_EARN_WNE_P10",
                            "C100_4","PCTFLOAN","CIP_SUM","MINORATIO","STU_APPLIED")
for (i in quantitative_variables) {
  output_quantitative_stats(clean_data[,i], i, quantitative_output_file)
}

sink()

sink(file = qualitative_output_file)
qualitative_variables <- c("WEST", "MIDWEST", "NORTHEAST", "SOUTH","MAJOR_CITY","MINOQ1","MINOQ2","MINOQ3","MINOQ4")
for (i in qualitative_variables) {
  output_qualitative_stats(clean_data[,i], i, qualitative_output_file)
}
sink()

sink(file = correlation_output_file)
cat("Correlation Matrix \n\n", file = correlation_output_file, append = TRUE)
cor_matrix <- cor(clean_data[, quantitative_variables], clean_data[, quantitative_variables])
cor_matrix
sink()

for (i in quantitative_variables) {
  histogram_generator(clean_data[,i], i)
  boxplot_generator(clean_data[,i], i)
}


matrix_variables <- c("UGDS","ADM_RATE","COSTT4_A","MD_EARN_WNE_P10",
                      "C100_4","PCTFLOAN","CIP_SUM","MINORATIO","STU_APPLIED")
png("images/eda-images/scatterplot-matrix/scatterplot-matrix.png")
pairs(clean_data[, matrix_variables])
dev.off()

sink(file = anova_output_file)
fit <- aov(STU_APPLIED ~ WEST + MIDWEST + NORTHEAST + SOUTH + MAJOR_CITY+MINOQ1+MINOQ2+MINOQ3+MINOQ4, data = clean_data)
summary(fit)
sink()

condition_boxplot_generator("WEST")
condition_boxplot_generator("MIDWEST")
condition_boxplot_generator("NORTHEAST")
condition_boxplot_generator("SOUTH")
condition_boxplot_generator("MAJOR_CITY")
condition_boxplot_generator("MINOQ1")
condition_boxplot_generator("MINOQ2")
condition_boxplot_generator("MINOQ3")
condition_boxplot_generator("MINOQ4")


sink(file = "data/data-outputs/eda-outputs/interesting-factors.txt")
writeLines("Universities with more than 100000 students applied")
as.character(clean_data[clean_data$STU_APPLIED> 100000, ][['INSTNM']])
sink()


NO_OF_SCHOOLS <- NULL
for (i in 1:8) {
  NO_OF_SCHOOLS[i] = sum(categorized_data$cluster==i)
}

regression_variables <- c("STU_APPLIED", "MD_EARN_WNE_P10", "C100_4",
"PCTFLOAN",  "MAJOR_CITY", "MINORATIO", "WEST", "MIDWEST", "NORTHEAST")

sink(file = cluster_output_file)
for (i in 1:8) {
  for (i in regression_variables) {
    output_quantitative_stats(categorized_data[,i], i, cluster_output_file)
  }
}
sink()

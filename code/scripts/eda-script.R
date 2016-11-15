source("code/functions/eda-functions.R")

clean_data <- read.csv("data/data-sets/cleaned-data-set/clean-data.csv")
quantitative_output_file <- "data/data-outputs/eda-outputs/eda-output-quantitative.txt"
qualitative_output_file <- "data/data-outputs/eda-outputs/eda-output-qualitative.txt"
correlation_output_file <- "data/data-outputs/eda-outputs/eda-output-correlation.txt"
anova_output_file <- "data/data-outputs/eda-outputs/eda-output-anova.txt"

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

png("images/scatterplot-matrix/scatterplot-matrix.png")
pairs(clean_data[, quantitative_variables])
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





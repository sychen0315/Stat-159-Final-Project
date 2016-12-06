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
qualitative_variables <- c("WEST", "MIDWEST", "NORTHEAST", "SOUTH","MAJOR_CITY")
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


matrix_variables <- c("UGDS","ADM_RATE","COSTT4_A","MD_EARN_WNE_P10", "COSTT4_A",
                      "C100_4","PCTFLOAN","MINORATIO","STU_APPLIED")
png("images/eda-images/scatterplot-matrix/scatterplot-matrix.png")
pairs(clean_data[, matrix_variables])
dev.off()

sink(file = anova_output_file)
fit <- aov(STU_APPLIED ~ WEST + MIDWEST + NORTHEAST + SOUTH + MAJOR_CITY, data = clean_data)
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


regression_variables <- c("STU_APPLIED", "MD_EARN_WNE_P10", "C100_4", "COSTT4_A", 
"PCTFLOAN",  "MAJOR_CITY", "MINORATIO", "WEST", "MIDWEST", "NORTHEAST")

sink(file = cluster_output_file)
for (i in 1:8) {
  for (i in regression_variables) {
    output_quantitative_stats(categorized_data[,i], i, cluster_output_file)
  }
}
sink()

NUM_OF_SCHOOLS <- NULL
STU_APPLIED_mean <- NULL
STU_APPLIED_sd <- NULL
STU_APPLIED_min <- NULL
STU_APPLIED_max <- NULL
MD_EARN_WNE_P10_mean <- NULL
MD_EARN_WNE_P10_sd <- NULL
MD_EARN_WNE_P10_min <- NULL
MD_EARN_WNE_P10_max <- NULL
COSTT4_A_mean <- NULL
COSTT4_A_sd <- NULL
COSTT4_A_min <- NULL
COSTT4_A_max <- NULL
C100_4_mean <- NULL
C100_4_sd <- NULL
C100_4_min <- NULL
C100_4_max <- NULL
PCTFLOAN_mean <- NULL
PCTFLOAN_sd <- NULL
PCTFLOAN_min <- NULL
PCTFLOAN_max <- NULL
MINORATIO_mean <- NULL
MINORATIO_sd <- NULL
MINORATIO_min <- NULL
MINORATIO_max <- NULL


for (i in 1:8) {
  NUM_OF_SCHOOLS[i] = sum(categorized_data$cluster==i)
  STU_APPLIED_mean[i] <- mean(categorized_data[categorized_data$cluster==i,]$STU_APPLIED)
  STU_APPLIED_sd[i] <- sd(categorized_data[categorized_data$cluster==i,]$STU_APPLIED)
  STU_APPLIED_min[i] <- min(categorized_data[categorized_data$cluster==i,]$STU_APPLIED)
  STU_APPLIED_max[i] <- max(categorized_data[categorized_data$cluster==i,]$STU_APPLIED)
  MD_EARN_WNE_P10_mean[i] <- mean(categorized_data[categorized_data$cluster==i,]$MD_EARN_WNE_P10)
  MD_EARN_WNE_P10_sd[i] <- sd(categorized_data[categorized_data$cluster==i,]$MD_EARN_WNE_P10)
  MD_EARN_WNE_P10_min[i] <- min(categorized_data[categorized_data$cluster==i,]$MD_EARN_WNE_P10)
  MD_EARN_WNE_P10_max[i] <- max(categorized_data[categorized_data$cluster==i,]$MD_EARN_WNE_P10)
  COSTT4_A_mean[i] <- mean(categorized_data[categorized_data$cluster==i,]$COSTT4_A)
  COSTT4_A_sd[i] <- sd(categorized_data[categorized_data$cluster==i,]$COSTT4_A)
  COSTT4_A_min[i] <- min(categorized_data[categorized_data$cluster==i,]$COSTT4_A)
  COSTT4_A_max[i] <- max(categorized_data[categorized_data$cluster==i,]$COSTT4_A)
  C100_4_mean[i] <- mean(categorized_data[categorized_data$cluster==i,]$C100_4)
  C100_4_sd[i] <- sd(categorized_data[categorized_data$cluster==i,]$C100_4)
  C100_4_min[i] <- min(categorized_data[categorized_data$cluster==i,]$C100_4)
  C100_4_max[i] <- max(categorized_data[categorized_data$cluster==i,]$C100_4)
  PCTFLOAN_mean[i] <- mean(categorized_data[categorized_data$cluster==i,]$PCTFLOAN)
  PCTFLOAN_sd[i] <- sd(categorized_data[categorized_data$cluster==i,]$PCTFLOAN)
  PCTFLOAN_min[i] <- min(categorized_data[categorized_data$cluster==i,]$PCTFLOAN)
  PCTFLOAN_max[i] <- max(categorized_data[categorized_data$cluster==i,]$PCTFLOAN)
  MINORATIO_mean[i] <- mean(categorized_data[categorized_data$cluster==i,]$MINORATIO)
  MINORATIO_sd[i] <- sd(categorized_data[categorized_data$cluster==i,]$MINORATIO)
  MINORATIO_min[i] <- min(categorized_data[categorized_data$cluster==i,]$MINORATIO)
  MINORATIO_max[i] <- max(categorized_data[categorized_data$cluster==i,]$MINORATIO)
}

cluster_eda_stats = rbind(Size = NUM_OF_SCHOOLS, STU_APP_avg = STU_APPLIED_mean, 
                          STU_APP_sd = STU_APPLIED_sd,STU_APP_min = STU_APPLIED_min,
                          STU_APP_max = STU_APPLIED_max, MD_EARN_avg = MD_EARN_WNE_P10_mean, MD_EARN_sd = MD_EARN_WNE_P10_sd,
                          MD_EARN_min = MD_EARN_WNE_P10_min, MD_EARN_max = MD_EARN_WNE_P10_max,
                          COSTT4_mean = COSTT4_A_mean, COSTT4_sd = COSTT4_A_sd, COSTT4_min = COSTT4_A_min, COSTT4_max = COSTT4_A_max,
                          C100_4_avg = C100_4_mean,C100_4_sd = C100_4_sd, C100_4_min = C100_4_min,C100_4_max = C100_4_max, 
                          PCTFLOAN_avg = PCTFLOAN_mean,
                          PCTFLOAN_sd =  PCTFLOAN_sd,PCTFLOAN_min = PCTFLOAN_min, PCTFLOAN_max = PCTFLOAN_max,MINORITY_avg = MINORATIO_mean, MINORITY_sd = MINORATIO_sd,MINORITY_min = MINORATIO_min,
                          MINORITY_max = MINORATIO_max)
colnames(cluster_eda_stats) = c("WM", "WN","MM","MN","NM","NN","SM","SN")
  
save(cluster_eda_stats, file = "data/data-outputs/eda-outputs/cluster-eda-stats.RData")

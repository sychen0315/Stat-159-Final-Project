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


regression_variables <- c("STU_APPLIED", "MD_EARN_WNE_P10", "C100_4",
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
C100_4_mean <- NULL
C100_4_sd <- NULL
C100_4_min <- NULL
C100_4_max <- NULL
PCTFLOAN_mean <- NULL
PCTFLOAN_sd <- NULL
PCTFLOAN_min <- NULL
PCTFLOAN_max <- NULL
MAJOR_CITY_mean <- NULL
MAJOR_CITY_sd <- NULL
MAJOR_CITY_min <- NULL
MAJOR_CITY_max <- NULL
MINORATIO_mean <- NULL
MINORATIO_sd <- NULL
MINORATIO_min <- NULL
MINORATIO_max <- NULL
WEST_mean <- NULL
WEST_sd <- NULL
WEST_min <- NULL
WEST_max <- NULL
MIDWEST_mean <- NULL
MIDWEST_sd <- NULL
MIDWEST_min <- NULL
MIDWEST_max <- NULL
NORTHEAST_mean <- NULL
NORTHEAST_sd <- NULL
NORTHEAST_min <- NULL
NORTHEAST_max <- NULL

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
  C100_4_mean[i] <- mean(categorized_data[categorized_data$cluster==i,]$C100_4)
  C100_4_sd[i] <- sd(categorized_data[categorized_data$cluster==i,]$C100_4)
  C100_4_min[i] <- min(categorized_data[categorized_data$cluster==i,]$C100_4)
  C100_4_max[i] <- max(categorized_data[categorized_data$cluster==i,]$C100_4)
  PCTFLOAN_mean[i] <- mean(categorized_data[categorized_data$cluster==i,]$PCTFLOAN)
  PCTFLOAN_sd[i] <- sd(categorized_data[categorized_data$cluster==i,]$PCTFLOAN)
  PCTFLOAN_min[i] <- min(categorized_data[categorized_data$cluster==i,]$PCTFLOAN)
  PCTFLOAN_max[i] <- max(categorized_data[categorized_data$cluster==i,]$PCTFLOAN)
  MAJOR_CITY_mean[i] <- mean(categorized_data[categorized_data$cluster==i,]$MAJOR_CITY)
  MAJOR_CITY_sd[i] <- sd(categorized_data[categorized_data$cluster==i,]$MAJOR_CITY)
  MAJOR_CITY_min[i] <- min(categorized_data[categorized_data$cluster==i,]$MAJOR_CITY)
  MAJOR_CITY_max[i] <- max(categorized_data[categorized_data$cluster==i,]$MAJOR_CITY)
  MINORATIO_mean[i] <- mean(categorized_data[categorized_data$cluster==i,]$MINORATIO)
  MINORATIO_sd[i] <- sd(categorized_data[categorized_data$cluster==i,]$MINORATIO)
  MINORATIO_min[i] <- min(categorized_data[categorized_data$cluster==i,]$MINORATIO)
  MINORATIO_max[i] <- max(categorized_data[categorized_data$cluster==i,]$MINORATIO)
  WEST_mean[i] <- mean(categorized_data[categorized_data$cluster==i,]$WEST)
  WEST_sd[i] <- sd(categorized_data[categorized_data$cluster==i,]$WEST)
  WEST_min[i] <- min(categorized_data[categorized_data$cluster==i,]$WEST)
  WEST_max[i] <- max(categorized_data[categorized_data$cluster==i,]$WEST)
  MIDWEST_mean[i] <- mean(categorized_data[categorized_data$cluster==i,]$MIDWEST)
  MIDWEST_sd[i] <- sd(categorized_data[categorized_data$cluster==i,]$MIDWEST)
  MIDWEST_min[i] <- min(categorized_data[categorized_data$cluster==i,]$MIDWEST)
  MIDWEST_max[i] <- max(categorized_data[categorized_data$cluster==i,]$MIDWEST)
  NORTHEAST_mean[i] <- mean(categorized_data[categorized_data$cluster==i,]$NORTHEAST)
  NORTHEAST_sd[i] <- sd(categorized_data[categorized_data$cluster==i,]$NORTHEAST)
  NORTHEAST_min[i] <- min(categorized_data[categorized_data$cluster==i,]$NORTHEAST)
  NORTHEAST_max[i] <- max(categorized_data[categorized_data$cluster==i,]$NORTHEAST)
}

cluster_eda_stats = rbind(NUM_OF_SCHOOLS = NUM_OF_SCHOOLS, STU_APPLIED_mean = STU_APPLIED_mean, 
                          STU_APPLIED_sd = STU_APPLIED_sd,STU_APPLIED_min = STU_APPLIED_min,
                          STU_APPLIED_max = STU_APPLIED_max, MD_EARN_WNE_P10_mean = MD_EARN_WNE_P10_mean, MD_EARN_WNE_P10_sd = MD_EARN_WNE_P10_sd,
                          MD_EARN_WNE_P10_min = MD_EARN_WNE_P10_min,
                          MD_EARN_WNE_P10_max = MD_EARN_WNE_P10_max,C100_4_mean = C100_4_mean,C100_4_sd = C100_4_sd, C100_4_min = C100_4_min,C100_4_max = C100_4_max, 
                          PCTFLOAN_mean = PCTFLOAN_mean,
                          PCTFLOAN_sd =  PCTFLOAN_sd,PCTFLOAN_min = PCTFLOAN_min, PCTFLOAN_max = PCTFLOAN_max, MAJOR_CITY_mean = MAJOR_CITY_mean, MAJOR_CITY_sd = MAJOR_CITY_sd,
                          MAJOR_CITY_min = MAJOR_CITY_min, MAJOR_CITY_max = MAJOR_CITY_max,MINORATIO_mean = MINORATIO_mean, MINORATIO_sd = MINORATIO_sd,MINORATIO_min = MINORATIO_min,
                          MINORATIO_max = MINORATIO_max, WEST_mean = WEST_mean,WEST_sd = WEST_sd,WEST_min = WEST_min,WEST_max = WEST_max,MIDWEST_mean = MIDWEST_mean,
                          MIDWEST_sd= MIDWEST_sd, MIDWEST_min = MIDWEST_min, MIDWEST_max =  MIDWEST_max, NORTHEAST_mean = NORTHEAST_mean, NORTHEAST_sd = NORTHEAST_sd,
                          NORTHEAST_min = NORTHEAST_min,NORTHEAST_max=NORTHEAST_max)
colnames(cluster_eda_stats) = c("cluster1", "cluster2","cluster3","cluster4","cluster5","cluster6",
                                "cluster7","cluster8")
  
save(cluster_eda_stats, file = "data/data-outputs/eda-outputs/cluster-eda-stats.RData")

cluster_data <- read.csv("data/data-sets/cleaned-data-set/categorized-data.csv")
anova_output_file <- "data/data-outputs/mean-difference-anova.txt"
summary_output_file <- 

# Fit an overall regression model on all institutions
overall_fit <- lm(STU_APPLIED ~ PCTFLOAN + C100_4 + COSTT4_A + MARJOR_CITY + MINORATIO + WEST + MIDWEST + NORTHEAST, data = cluster_data)
save(overall_fit, file = "data/regression-data/overall-ols-model.RData")

aov_result <- aov(STU_APPLIED ~ cluster, data = cluster_data)

sink(file = anova_output_file)
summary(aov_result)
sink()

category <- list("WM", "WN", "MM", "MN", "NM", "NN", "SM", "SN")
models <- c()
summaries <- c()

for (i in category) {
  filtered_data <- cluster_data[cluster_data[,i] == 1, ]
  model <- lm(STU_APPLIED ~ PCTFLOAN + C100_4 + COSTT4_A + MINORATIO, data = filtered_data)
  models <- c(models, list(model))
  save(model, file = paste("data/regression-data/", i,"-ols-model.RData", sep = ""))
  summaries <- c(summaries,list(summary(model)))
}

save(summaries, file = "data/regression-data/summary-stats-for-ols-model.RData")





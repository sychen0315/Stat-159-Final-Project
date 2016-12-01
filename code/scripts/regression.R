
cluster_data <- read.csv("data/data-sets/cleaned-data-set/categorized-data.csv")
anova_output_file <- "data/data-outputs/mean-difference-anova.txt"
summary_output_file <- "data/regression-data/summary-stats-for-ols-model.RData"

# Fit an overall regression model on all institutions
ols_full_fit <- lm(STU_APPLIED ~ MD_EARN_WNE_P10 + PCTFLOAN + C100_4 + COSTT4_A + MAJOR_CITY + MINORATIO + WEST + MIDWEST + NORTHEAST, data = cluster_data)

# Replace 0 in the data set and take run log regression
indx <- which((cluster_data$PCTFLOAN == 0) == TRUE)
cluster_data$PCTFLOAN[indx] = 0.0001

indx <- which((cluster_data$COSTT4_A == 0) == TRUE)
cluster_data$COSTT4_A[indx] = 0.0001

indx <- which((cluster_data$C100_4 == 0) == TRUE)
cluster_data$C100_4[indx] = 0.0001

cluster_data$ln_STU_APPLIED <- log(cluster_data$STU_APPLIED)
cluster_data$ln_MD_EARN_WNE_P10 <- log(cluster_data$MD_EARN_WNE_P10)
cluster_data$ln_PCTFLOAN <- log(cluster_data$PCTFLOAN)
cluster_data$ln_C100_4 <- log(cluster_data$C100_4)
cluster_data$ln_COSTT4_A <- log(cluster_data$COSTT4_A)

# Train Test Split
n <- nrow(cluster_data)
train_num <- round(n/4*3)
test_num <- n - train_num

set.seed(12345)
train_sample = sample(1:n, train_num, replace = F)
overall_train_set = cluster_data[train_sample, ]
overall_test_set = cluster_data[-train_sample, ]

ols_mod = lm(ln_STU_APPLIED ~ ln_MD_EARN_WNE_P10 + ln_PCTFLOAN + ln_C100_4 + 
             ln_COSTT4_A + MAJOR_CITY + MINORATIO + WEST + MIDWEST + 
             NORTHEAST, data = overall_train_set)

# Use the fitted model on testset to calculate MSE

ind_var <- c(23, 24, 25, 26, 27, 28, 43, 44, 45, 46, 47)
ols_test_predict <- predict(ols_mod, overall_test_set[ind_var])
MSE_ols <- mean((ols_test_predict - overall_test_set[,33])^2)

# Fit the model in the original dataset to find estimated coefficients

ols_full_log_fit <- lm(ln_STU_APPLIED ~ ln_MD_EARN_WNE_P10 + ln_PCTFLOAN + ln_C100_4 + 
                         ln_COSTT4_A + MAJOR_CITY + MINORATIO + WEST + MIDWEST + 
                         NORTHEAST, data = cluster_data)
ols_fitted_coef <- coef(ols_full_log_fit)

save(ols_full_fit, ols_full_log_fit, ols_fitted_coef, MSE_ols, file = "data/regression-data/overall-ols-model.RData")










aov_result <- aov(STU_APPLIED ~ cluster, data = cluster_data)

sink(file = anova_output_file)
summary(aov_result)
sink()

save(aov_result, file = "data/data-outputs/anova.RData")

category <- list("WM", "WN", "MM", "MN", "NM", "NN", "SM", "SN")
models <- c()
summaries <- c()

for (i in category) {
  filtered_data <- cluster_data[cluster_data[,i] == 1, ]
  model <- lm(STU_APPLIED ~ MD_EARN_WNE_P10 + PCTFLOAN + C100_4 + COSTT4_A + MINORATIO, data = filtered_data)
  models <- c(models, list(model))
  save(model, file = paste("data/regression-data/", i,"-ols-model.RData", sep = ""))
  summaries <- c(summaries,list(summary(model)))
}

save(summaries, file = summary_output_file)





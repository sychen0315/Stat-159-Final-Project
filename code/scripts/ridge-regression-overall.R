library(glmnet)

# Read in data sets
overall_train_set = read.csv("data/data-sets/train-test-data-set/overall-train-set.csv")
overall_test_set = read.csv("data/data-sets/train-test-data-set/overall-test-set.csv")
overall_data_set_regresssion = read.csv("data/data-sets/train-test-data-set/overall-data-set-regression.csv")

# Fit ridge model to training set
ind_var <- c("ln_MD_EARN_WNE_P10", "ln_PCTFLOAN", "ln_C100_4", "ln_COSTT4_A", "MAJOR_CITY", "MINORATIO", "WEST", "MIDWEST", "NORTHEAST")
dependent_train <- as.matrix(overall_train_set["ln_STU_APPLIED"])
regressor_train <- as.matrix(overall_train_set[ind_var])
grid <- 10^seq(10, -2, length = 100)
set.seed(1235)
ridge_mod <- cv.glmnet(regressor_train, dependent_train, lambda = grid, alpha = 0)
best_lambda_ridge <- ridge_mod$lambda.min

# Save ridge regression plot
png('images/regression-plot/ridge-regression-plot.png')
plot(ridge_mod, main = "Overall Ridge Regressin Plot")
dev.off()

# Use the best fitted lambda on test set to calculate MSE
test_set_input <- as.matrix(overall_test_set[, ind_var])
ridge_test_predict <- predict(ridge_mod, s = best_lambda_ridge, newx = test_set_input)
ridge_test <- as.matrix(overall_test_set[,"ln_STU_APPLIED"])
MSE_ridge <- mean((ridge_test - ridge_test_predict)^2)

# Fit the model in the original dataset to find estimated coefficients
dependent_full <- as.matrix(overall_data_set_regresssion["ln_STU_APPLIED"])
regressor_full <- as.matrix(overall_data_set_regresssion[ind_var])
ridge_full_log_fit <- glmnet(regressor_full, dependent_full, alpha = 0, lambda = best_lambda_ridge)
ridge_fitted_coef <- coef(ridge_full_log_fit)

save(best_lambda_ridge, MSE_ridge, ridge_full_log_fit, ridge_fitted_coef, file = "data/regression-data/overall-ridge-model.RData")

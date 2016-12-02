library(glmnet)

# Read in data sets
overall_train_set = read.csv("data/data-sets/train-test-data-set/overall-train-set.csv")
overall_test_set = read.csv("data/data-sets/train-test-data-set/overall-test-set.csv")
overall_data_set_regresssion = read.csv("data/data-sets/train-test-data-set/overall-data-set-regression.csv")

# Fit lasso model to training set
ind_var <- c(24, 25, 26, 28, 29, 45, 46, 47, 48)
dependent_train <- as.matrix(overall_train_set[44])
regressor_train <- as.matrix(overall_train_set[ind_var])
grid <- 10^seq(10, -2, length = 1000)
set.seed(1235)
lasso_mod <- cv.glmnet(regressor_train, dependent_train, lambda = grid, alpha = 1)
best_lambda_lasso <- lasso_mod$lambda.min

# Save lasso regression plot
png('images/regression-plot/lasso-regression-plot.png')
plot(lasso_mod, main = "Overall Lasso Regressin Plot")
dev.off()

# Use the best fitted lambda on test set to calculate MSE
test_set_input <- as.matrix(overall_test_set[, ind_var])
lasso_test_predict <- predict(lasso_mod, s = best_lambda_lasso, newx = test_set_input)
lasso_test <- as.matrix(overall_test_set[,44])
MSE_lasso <- mean((lasso_test - lasso_test_predict)^2)

# Fit the model in the original dataset to find estimated coefficients
dependent_full <- as.matrix(overall_data_set_regresssion[44])
regressor_full <- as.matrix(overall_data_set_regresssion[ind_var])
lasso_full_log_fit <- glmnet(regressor_full, dependent_full, alpha = 1, lambda = best_lambda_lasso)
lasso_fitted_coef <- coef(lasso_full_log_fit)

save(best_lambda_lasso, MSE_lasso, lasso_full_log_fit, lasso_fitted_coef, file = "data/regression-data/overall-lasso-model.RData")

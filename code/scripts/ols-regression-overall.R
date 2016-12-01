overall_train_set = read.csv("data/data-sets/train-test-data-set/overall-train-set.csv")
overall_test_set = read.csv("data/data-sets/train-test-data-set/overall-test-set.csv")
overall_data_set_regresssion = read.csv("data/data-sets/train-test-data-set/overall-data-set-regression.csv")

# Fit an overall regression model on all institutions
ols_full_fit <- lm(STU_APPLIED ~ MD_EARN_WNE_P10 + PCTFLOAN + C100_4 + 
                   COSTT4_A + MAJOR_CITY + MINORATIO + WEST + MIDWEST 
                   + NORTHEAST, data = overall_data_set_regresssion)

ols_mod = lm(ln_STU_APPLIED ~ ln_MD_EARN_WNE_P10 + ln_PCTFLOAN + ln_C100_4 + 
             ln_COSTT4_A + MAJOR_CITY + MINORATIO + WEST + MIDWEST + 
             NORTHEAST, data = overall_train_set)

# Use the fitted model on testset to calculate MSE

ind_var <- c(24, 25, 26, 27, 28, 29, 45, 46, 47, 48)
ols_test_predict <- predict(ols_mod, overall_test_set[ind_var])
MSE_ols <- mean((ols_test_predict - overall_test_set[,44])^2)

# Fit the model in the original dataset to find estimated coefficients

ols_full_log_fit <- lm(ln_STU_APPLIED ~ ln_MD_EARN_WNE_P10 + ln_PCTFLOAN + ln_C100_4 + 
                         ln_COSTT4_A + MAJOR_CITY + MINORATIO + WEST + MIDWEST + 
                         NORTHEAST, data = overall_data_set_regresssion)
ols_fitted_coef <- coef(ols_full_log_fit)

save(ols_full_fit, ols_full_log_fit, ols_fitted_coef, MSE_ols, file = "data/regression-data/overall-ols-model.RData")













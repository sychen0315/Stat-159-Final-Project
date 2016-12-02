library(pls)

# Read in data sets
overall_train_set = read.csv("data/data-sets/train-test-data-set/overall-train-set.csv")
overall_test_set = read.csv("data/data-sets/train-test-data-set/overall-test-set.csv")
overall_data_set_regresssion = read.csv("data/data-sets/train-test-data-set/overall-data-set-regression.csv")

# Fit plsr model to training set
set.seed(1)
plsr_mod <- plsr(ln_STU_APPLIED ~ ln_MD_EARN_WNE_P10 + ln_PCTFLOAN + ln_C100_4 + 
                 ln_COSTT4_A + MAJOR_CITY + MINORATIO + WEST + MIDWEST + 
                 NORTHEAST, data = overall_train_set, validation = "CV", intercept = TRUE)

# Pick the m that will minimize the validation error 
validation_error <- plsr_mod$validation$PRESS
best_m_plsr <- which(validation_error == min(validation_error))

# Save plsr regression plot
png('images/regression-plot/plsr-regression-plot.png')
validationplot(plsr_mod, val.type = "MSEP", main = "PLSR Regression Plot")
dev.off()

# Use the best fitted m on testset to calculate MSE
ind_var <- c(24, 25, 26, 28, 29, 45, 46, 47, 48)
plsr_test_predict <- predict(plsr_mod, overall_test_set[ind_var], ncomp = best_m_plsr)
MSE_plsr <- mean((plsr_test_predict - overall_test_set[,44])^2)

# Fit the model in the original dataset to find estimated coefficients
plsr_full_log_fit <- plsr(ln_STU_APPLIED ~ ln_MD_EARN_WNE_P10 + ln_PCTFLOAN + ln_C100_4 + 
                          ln_COSTT4_A + MAJOR_CITY + MINORATIO + WEST + MIDWEST + 
                          NORTHEAST, data = overall_data_set_regresssion, ncomp = best_m_plsr, intercept = TRUE)
plsr_fitted_coef <- coef(plsr_full_log_fit)

save(best_m_plsr, MSE_plsr, plsr_full_log_fit, plsr_fitted_coef, file = "data/regression-data/overall-plsr-model.RData")



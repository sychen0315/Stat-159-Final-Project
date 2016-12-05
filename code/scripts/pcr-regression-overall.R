library(pls)

# Read in data sets
overall_train_set = read.csv("data/data-sets/train-test-data-set/overall-train-set.csv")
overall_test_set = read.csv("data/data-sets/train-test-data-set/overall-test-set.csv")
overall_data_set_regresssion = read.csv("data/data-sets/train-test-data-set/overall-data-set-regression.csv")

# Fit pcr model to training set
set.seed(123)
pcr_mod <- pcr(ln_STU_APPLIED ~ ln_MD_EARN_WNE_P10 + ln_PCTFLOAN + ln_C100_4 + 
                 ln_COSTT4_A + MAJOR_CITY + MINORATIO + WEST + MIDWEST + 
                 NORTHEAST, data = overall_train_set, validation = "CV", intercept = TRUE)

# Pick the m that will minimize the validation error 
validation_error <- pcr_mod$validation$PRESS
best_m_pcr <- which(validation_error == min(validation_error))

# Save pcr regression plot
png('images/regression-plot/pcr-regression-plot.png')
validationplot(pcr_mod, val.type = "MSEP", main = "PCR Regression Plot")
dev.off()

# Use the best fitted m on testset to calculate MSE
ind_var <- c("ln_MD_EARN_WNE_P10", "ln_PCTFLOAN", "ln_C100_4", "ln_COSTT4_A", "MAJOR_CITY", "MINORATIO", "WEST", "MIDWEST", "NORTHEAST")
pcr_test_predict <- predict(pcr_mod, overall_test_set[ind_var], ncomp = best_m_pcr)
MSE_pcr <- mean((pcr_test_predict - overall_test_set[,"ln_STU_APPLIED"])^2)

# Fit the model in the original dataset to find estimated coefficients
pcr_full_log_fit <- pcr(ln_STU_APPLIED ~ ln_MD_EARN_WNE_P10 + ln_PCTFLOAN + ln_C100_4 + 
                        ln_COSTT4_A + MAJOR_CITY + MINORATIO + WEST + MIDWEST + 
                        NORTHEAST, data = overall_data_set_regresssion, ncomp = best_m_pcr, intercept = TRUE)
pcr_fitted_coef <- coef(pcr_full_log_fit)

save(best_m_pcr, MSE_pcr, pcr_full_log_fit, pcr_fitted_coef, file = "data/regression-data/overall-pcr-model.RData")



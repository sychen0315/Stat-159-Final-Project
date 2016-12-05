overall_data_set_regresssion = read.csv("data/data-sets/train-test-data-set/overall-data-set-regression.csv")

category <- list("WM", "WN", "MM", "MN", "NM", "NN", "SM", "SN")

filtered_data <- overall_data_set_regresssion[overall_data_set_regresssion[,"WM"] == 1, ]
WM_model <- lm(ln_STU_APPLIED ~ ln_MD_EARN_WNE_P10 + ln_PCTFLOAN + ln_C100_4 + 
            ln_COSTT4_A + MINORATIO, data = filtered_data)
save(WM_model, file = paste("data/regression-data/WM-ols-model.RData", sep = ""))

filtered_data <- overall_data_set_regresssion[overall_data_set_regresssion[,"WN"] == 1, ]
WN_model <- lm(ln_STU_APPLIED ~ ln_MD_EARN_WNE_P10 + ln_PCTFLOAN + ln_C100_4 + 
                 ln_COSTT4_A + MINORATIO, data = filtered_data)
save(WN_model, file = paste("data/regression-data/WN-ols-model.RData", sep = ""))

filtered_data <- overall_data_set_regresssion[overall_data_set_regresssion[,"MM"] == 1, ]
MM_model <- lm(ln_STU_APPLIED ~ ln_MD_EARN_WNE_P10 + ln_PCTFLOAN + ln_C100_4 + 
                 ln_COSTT4_A + MINORATIO, data = filtered_data)
save(MM_model, file = paste("data/regression-data/MM-ols-model.RData", sep = ""))

filtered_data <- overall_data_set_regresssion[overall_data_set_regresssion[,"MN"] == 1, ]
MN_model <- lm(ln_STU_APPLIED ~ ln_MD_EARN_WNE_P10 + ln_PCTFLOAN + ln_C100_4 + 
                 ln_COSTT4_A + MINORATIO, data = filtered_data)
save(MN_model, file = paste("data/regression-data/MN-ols-model.RData", sep = ""))

filtered_data <- overall_data_set_regresssion[overall_data_set_regresssion[,"NM"] == 1, ]
NM_model <- lm(ln_STU_APPLIED ~ ln_MD_EARN_WNE_P10 + ln_PCTFLOAN + ln_C100_4 + 
                 ln_COSTT4_A + MINORATIO, data = filtered_data)
save(NM_model, file = paste("data/regression-data/NM-ols-model.RData", sep = ""))

filtered_data <- overall_data_set_regresssion[overall_data_set_regresssion[,"NN"] == 1, ]
NN_model <- lm(ln_STU_APPLIED ~ ln_MD_EARN_WNE_P10 + ln_PCTFLOAN + ln_C100_4 + 
                 ln_COSTT4_A + MINORATIO, data = filtered_data)
save(NN_model, file = paste("data/regression-data/NN-ols-model.RData", sep = ""))

filtered_data <- overall_data_set_regresssion[overall_data_set_regresssion[,"SM"] == 1, ]
SM_model <- lm(ln_STU_APPLIED ~ ln_MD_EARN_WNE_P10 + ln_PCTFLOAN + ln_C100_4 + 
                 ln_COSTT4_A + MINORATIO, data = filtered_data)
save(SM_model, file = paste("data/regression-data/SM-ols-model.RData", sep = ""))

filtered_data <- overall_data_set_regresssion[overall_data_set_regresssion[,"SN"] == 1, ]
SN_model <- lm(ln_STU_APPLIED ~ ln_MD_EARN_WNE_P10 + ln_PCTFLOAN + ln_C100_4 + 
                 ln_COSTT4_A + MINORATIO, data = filtered_data)
save(SN_model, file = paste("data/regression-data/SN-ols-model.RData", sep = ""))
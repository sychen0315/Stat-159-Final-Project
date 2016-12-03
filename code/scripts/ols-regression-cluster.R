overall_data_set_regresssion = read.csv("data/data-sets/train-test-data-set/overall-data-set-regression.csv")

category <- list("WM", "WN", "MM", "MN", "NM", "NN", "SM", "SN")
models <- c()
summaries <- c()

for (i in category) {
  filtered_data <- overall_data_set_regresssion[overall_data_set_regresssion[,i] == 1, ]
  name <- paste(i, "_model", sep = "")
  model <- lm(ln_STU_APPLIED ~ ln_MD_EARN_WNE_P10 + ln_PCTFLOAN + ln_C100_4 + 
           ln_COSTT4_A + MINORATIO, data = filtered_data)
  assign(name, model)  
  save(name, file = paste("data/regression-data/", i,"-ols-model.RData", sep = ""))
}

save(summaries, file = summary_output_file)


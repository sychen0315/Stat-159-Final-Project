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





cluster_data <- read.csv("data/data-sets/cleaned-data-set/categorized-data.csv")

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

model <- lm(STU_APPLIED ~ PCTFLOAN + C100_4 + COSTT4_A + MINORATIO, data = cluster_data)
anova(model)



full_data <- read.csv(file = "data/data-sets/cleaned-data-set/clean-data.csv")
n <- nrow(full_data)
train_num <- round(n/4*3)
test_num <- n - train_num

# Train Test Split
set.seed(12345)
train_sample = sample(1:n, train_num, replace = F)
overall_train_set = full_data[train_sample, ]
overall_test_set = full_data[-train_sample, ]
write.csv(overall_train_set, file = "data/data-sets/cleaned-data-set/overall-train-set.csv")
write.csv(overall_test_set, file = "data/data-sets/cleaned-data-set/overall-test-set.csv")

save(overall_train_set, overall_test_set, file = "data/data-sets/cleaned-data-set/overall-train-test.RData")

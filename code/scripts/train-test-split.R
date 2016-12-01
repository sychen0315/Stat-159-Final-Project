
cluster_data <- read.csv("data/data-sets/cleaned-data-set/categorized-data.csv")

# Replace 0 in the data set
indx <- which((cluster_data$PCTFLOAN == 0) == TRUE)
cluster_data$PCTFLOAN[indx] = 0.0001

indx <- which((cluster_data$COSTT4_A == 0) == TRUE)
cluster_data$COSTT4_A[indx] = 0.0001

indx <- which((cluster_data$C100_4 == 0) == TRUE)
cluster_data$C100_4[indx] = 0.0001

# Add log columns in order to get interpretable coefficients
cluster_data$ln_STU_APPLIED <- log(cluster_data$STU_APPLIED)
cluster_data$ln_MD_EARN_WNE_P10 <- log(cluster_data$MD_EARN_WNE_P10)
cluster_data$ln_PCTFLOAN <- log(cluster_data$PCTFLOAN)
cluster_data$ln_C100_4 <- log(cluster_data$C100_4)
cluster_data$ln_COSTT4_A <- log(cluster_data$COSTT4_A)

# Train Test Split
n <- nrow(cluster_data)
train_num <- round(n/4*3)
test_num <- n - train_num

set.seed(12345)
train_sample = sample(1:n, train_num, replace = F)
overall_train_set = cluster_data[train_sample, ]
overall_test_set = cluster_data[-train_sample, ]

write.csv(overall_train_set, file = "data/data-sets/train-test-data-set/overall-train-set.csv")
write.csv(overall_test_set, file = "data/data-sets/train-test-data-set/overall-test-set.csv")
write.csv(cluster_data, file = "data/data-sets/train-test-data-set/overall-data-set-regression.csv")

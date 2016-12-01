anova_output_file <- "data/data-outputs/mean-difference-anova.txt"

aov_result <- aov(STU_APPLIED ~ cluster, data = cluster_data)

sink(file = anova_output_file)
summary(aov_result)
sink()

save(aov_result, file = "data/data-outputs/anova.RData")
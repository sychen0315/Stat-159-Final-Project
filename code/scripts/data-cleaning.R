# Read data
state_df <- read.csv("data/data-sets/original-data-set/state.csv")
merged14_15 <- read.csv("data/data-sets/original-data-set/MERGED2014_15_PP.csv")

# Divide by regions
wests_schools <-merged14_15$STABBR %in% state_df$West
midwest_schools <- merged14_15$STABBR %in% state_df$Midwest
northeast_schools <- merged14_15$STABBR %in% state_df$Northeast
south_schools <- merged14_15$STABBR %in% state_df$South


# Add more columns
merged14_15$WEST <- as.numeric(wests_schools)
merged14_15$MIDWEST <- as.numeric(midwest_schools)
merged14_15$NORTHEAST <- as.numeric(northeast_schools)
merged14_15$SOUTH <- as.numeric(south_schools)

# Calculate the sum of PCIP
CIP_colnames <- grep('^CIP', colnames(merged14_15), value = TRUE)
for (i in 1:7703) {
  total <- 0
  for (j in CIP_colnames) {
    if (is.na(as.numeric(as.character(merged14_15[i,j])))){
      next()
    }
    total <- total + as.numeric(as.character(merged14_15[i,j]))
  }
  merged14_15[i, "CIP_SUM"] = total
}


# Write result to a new csv
write.csv(merged14_15, file = "data/data-sets/cleaned-data-set/MERGED2014_15_PP_regions.csv")


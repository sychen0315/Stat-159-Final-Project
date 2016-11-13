# Read data
state_df <- read.csv("data/data-sets/original-data-set/state.csv")
merged14_15 <- read.csv("data/data-sets/original-data-set/MERGED2014_15_PP.csv")

# Divide by regions
wests_schools <- merged14_15[merged14_15$STABBR %in% state_df$West, ]
midwest_schools <- merged14_15[merged14_15$STABBR %in% state_df$Midwest, ]
northeast_schools <- merged14_15[merged14_15$STABBR %in% state_df$Northeast, ]
south_schools <- merged14_15[merged14_15$STABBR %in% state_df$South, ]

# Write results to new files
write.csv(wests_schools, file = "data/data-sets/cleaned-data-set/west-schools.csv")
write.csv(midwest_schools, file = "data/data-sets/cleaned-data-set/midwest-schools.csv")
write.csv(northeast_schools, file = "data/data-sets/cleaned-data-set/northeast-schools.csv")
write.csv(south_schools, file = "data/data-sets/cleaned-data-set/south-schools.csv")



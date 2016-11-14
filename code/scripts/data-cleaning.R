# Read data

raw_data <- read.csv("data/data-sets/original-data-set/Most-Recent-Cohorts-All-Data-Elements.csv")

state_df <- read.csv("data/data-sets/original-data-set/state.csv")
major_cities <- read.csv("data/data-sets/original-data-set/major-cities.csv")
minority <- c("UGDS_BLACK", "UGDS_HISP", "UGDS_ASIAN", "UGDS_AIAN", "UGDS_NHPI", "UGDS_2MOR", "UGDS_NRA", "UGDS_UNKN")
competitiveness <- c("UGDS", "ADM_RATE", "COSTT4_A","MD_EARN_WNE_P10", 
               "C100_4","PCTFLOAN")


clean_data <- raw_data[, c('UNITID', 'INSTNM', 'STABBR', 'CITY', minority, 'UGDS_WHITE', competitiveness)]



# Divide by regions
wests_schools <-raw_data$STABBR %in% state_df$West
midwest_schools <- raw_data$STABBR %in% state_df$Midwest
northeast_schools <- raw_data$STABBR %in% state_df$Northeast
south_schools <- raw_data$STABBR %in% state_df$South


# Add more columns
clean_data$WEST <- as.numeric(wests_schools)
clean_data$MIDWEST <- as.numeric(midwest_schools)
clean_data$NORTHEAST <- as.numeric(northeast_schools)
clean_data$SOUTH <- as.numeric(south_schools)



# Divide by major cities
whether_major_city <- raw_data$CITY %in% major_cities$City
clean_data$MAJOR_CITY <- as.numeric(whether_major_city)


clean_data$MINORATIO = as.numeric(as.character(clean_data$UGDS_BLACK)) + 
  as.numeric(as.character(clean_data$UGDS_HISP)) + 
  as.numeric(as.character(clean_data$UGDS_ASIAN)) + 
  as.numeric(as.character(clean_data$UGDS_AIAN)) + 
  as.numeric(as.character(clean_data$UGDS_NHPI)) + 
  as.numeric(as.character(clean_data$UGDS_2MOR)) + 
  as.numeric(as.character(clean_data$UGDS_NRA)) + 
  as.numeric(as.character(clean_data$UGDS_UNKN))

result_summary = summary(clean_data$MINORATIO)
Q1 = as.numeric(result_summary["1st Qu."])
Q2 = as.numeric(result_summary["Median"])
Q3 = as.numeric(result_summary["3rd Qu."])

Group1 = c()
Group2 = c()
Group3 = c()
Group4 = c()
for(i in 1:nrow(clean_data)){
  row <- clean_data[i,]
  if(is.na(row$MINORATIO)){
    Group1 = c(Group1, 0)
    Group2 = c(Group2, 0)
    Group3 = c(Group3, 0)
    Group4 = c(Group4, 0)
    next
  }
  if(row$MINORATIO < Q1){
    Group1 = c(Group1, 1)
    Group2 = c(Group2, 0)
    Group3 = c(Group3, 0)
    Group4 = c(Group4, 0)
  }
  if(row$MINORATIO >= Q1 && row$MINORATIO < Q2){
    Group1 = c(Group1, 0)
    Group2 = c(Group2, 1)
    Group3 = c(Group3, 0)
    Group4 = c(Group4, 0)
  }
  if(row$MINORATIO >= Q2 && row$MINORATIO < Q3 ){
    Group1 = c(Group1, 0)
    Group2 = c(Group2, 0)
    Group3 = c(Group3, 1)
    Group4 = c(Group4, 0)
  }
  if(row$MINORATIO >= Q3){
    Group1 = c(Group1, 0)
    Group2 = c(Group2, 0)
    Group3 = c(Group3, 0)
    Group4 = c(Group4, 1)
  }
}
clean_data$MINOQ1 = Group1
clean_data$MINOQ2 = Group2
clean_data$MINOQ3 = Group3
clean_data$MINOQ4 = Group4


students_applied = as.numeric(as.character(raw_data[, "UGDS"]))/as.numeric(as.character(raw_data[, "ADM_RATE"]))
clean_data$STU_APPLIED = students_applied


test <- na.omit(clean_data)


# Calculate the sum of PCIP
CIP_colnames <- grep('^CIP', colnames(raw_data), value = TRUE)
for (i in 1:7703) {
  total <- 0
  for (j in CIP_colnames) {
    if (is.na(as.numeric(as.character(raw_data[i,j])))){
      next()
    }
    total <- total + as.numeric(as.character(raw_data[i,j]))
  }
  raw_data[i, "CIP_SUM"] = total
}



# Write result to a new csv
write.csv(clean_data, file = "data/data-sets/cleaned-data-set/clean-data.csv")



raw_data <- read.csv("data/data-sets/original-data-set/MERGED2014_15_PP.csv")
major_cities <- read.csv("data/data-sets/original-data-set/major-cities.csv")

whether_major_city <- raw_data$CITY %in% major_cities$City
raw_data$major_city <- whether_major_city

major_city <- data.frame(raw_data$UNITID, raw_data$INSTNM, raw_data$major_city)

# Read data
raw_data <- read.csv("data/data-sets/original-data-set/Most-Recent-Cohorts-All-Data-Elements.csv")

state_df <- read.csv("data/data-sets/original-data-set/state.csv")
major_cities <- read.csv("data/data-sets/original-data-set/major-cities.csv")
minority <- c("UGDS_BLACK", "UGDS_HISP", "UGDS_ASIAN", "UGDS_AIAN", "UGDS_NHPI", "UGDS_2MOR", "UGDS_NRA", "UGDS_UNKN")
competitiveness <- c("UGDS", "ADM_RATE", "COSTT4_A","MD_EARN_WNE_P10", 
               "C100_4","PCTFLOAN")

# Calculate the sum of PCIP
CIP_colnames <- grep('^CIP', colnames(raw_data), value = TRUE)
raw_data$CIP_SUM <- apply(raw_data[,CIP_colnames], 1, function(x) sum(as.numeric(x)))

# Create a new df as clean_data
clean_data <- raw_data[, c('UNITID', 'INSTNM', 'STABBR', 'CITY', minority, 'UGDS_WHITE', competitiveness)]

# Explore NULL in each column and save result
col_null <- colSums(clean_data == 'NULL')
sink(file = "data/data-outputs/col-NULL-num.txt")
writeLines("Number of NULL values in each column we care")
col_null
sink()

# Add CIP_SUM column to clean data
clean_data$CIP_SUM <- raw_data$CIP_SUM

# Delete all row which contains NULL or NA
clean_data <- clean_data[!rowSums(clean_data=='NULL' | is.na(clean_data) ),]

# Divide by regions
wests_schools <-clean_data$STABBR %in% state_df$West
midwest_schools <- clean_data$STABBR %in% state_df$Midwest
northeast_schools <- clean_data$STABBR %in% state_df$Northeast
south_schools <- clean_data$STABBR %in% state_df$South

# Add more columns
clean_data$WEST <- as.numeric(wests_schools)
clean_data$MIDWEST <- as.numeric(midwest_schools)
clean_data$NORTHEAST <- as.numeric(northeast_schools)
clean_data$SOUTH <- as.numeric(south_schools)

# Divide by major cities and add one colum
whether_major_city <- clean_data$CITY %in% major_cities$City
clean_data$MAJOR_CITY <- as.numeric(whether_major_city)

# add four columns indicating minority
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


# add a column shown number of students applied
students_applied <- as.numeric(as.character(clean_data[, "UGDS"]))/as.numeric(as.character(clean_data[, "ADM_RATE"]))
clean_data$STU_APPLIED <- students_applied

# Delete row which MD_EARN_WNE_P10 is privacySuppresed
clean_data <- clean_data[!clean_data$MD_EARN_WNE_P10 == 'PrivacySuppressed',]

# Write result to a new csv
write.csv(clean_data, file = "data/data-sets/cleaned-data-set/clean-data.csv")

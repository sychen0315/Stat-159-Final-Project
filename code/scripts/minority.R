raw_data <- read.csv("data/data-sets/original-data-set/MERGED2014_15_PP.csv")

#black (UGDS_BLACK), Hispanic (UGDS_HISP), Asian
#(UGDS_ASIAN), American Indian/Alaska Native (UGDS_AIAN), Native
#Hawaiian/Pacific Islander (UGDS_NHPI), two or more races
#(UGDS_2MOR), non-resident aliens (UGDS_NRA), and race unknown
#(UGDS_UNKN).

minority = c("UGDS_BLACK", "UGDS_HISP", "UGDS_ASIAN", "UGDS_AIAN", "UGDS_NHPI", "UGDS_2MOR", "UGDS_NRA", "UGDS_UNKN")
race = data.frame(raw_data$UNITID, raw_data$INSTNM, raw_data$UGDS_WHITE, raw_data[minority])
race$MINORATIO = as.numeric(as.character(raw_data$UGDS_BLACK)) + 
                  as.numeric(as.character(raw_data$UGDS_HISP)) + 
                  as.numeric(as.character(raw_data$UGDS_ASIAN)) + 
                  as.numeric(as.character(raw_data$UGDS_AIAN)) + 
                  as.numeric(as.character(raw_data$UGDS_NHPI)) + 
                  as.numeric(as.character(raw_data$UGDS_2MOR)) + 
                  as.numeric(as.character(raw_data$UGDS_NRA)) + 
                  as.numeric(as.character(raw_data$UGDS_UNKN))

result_summary = summary(race$MINORATIO)
Q1 = as.numeric(result_summary["1st Qu."])
Q2 = as.numeric(result_summary["Median"])
Q3 = as.numeric(result_summary["3rd Qu."])

Group1 = c()
Group2 = c()
Group3 = c()
Group4 = c()
for(i in 1:nrow(race)){
  row <- race[i,]
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
race$MINOQ1 = Group1
race$MINOQ2 = Group2
race$MINOQ3 = Group3
race$MINOQ4 = Group4

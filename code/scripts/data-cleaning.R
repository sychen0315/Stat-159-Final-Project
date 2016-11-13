raw_data <- read.csv("data/data-sets/original-data-set/MERGED2014_15_PP.csv")
major_cities <- read.csv("data/data-sets/original-data-set/major-cities.csv")

students_applied = as.numeric(as.character(raw_data[, "UGDS"]))/as.numeric(as.character(raw_data[, "ADM_RATE"]))
stu_applied_df = data.frame(raw_data[,"X...UNITID"],raw_data[,"INSTNM"], raw_data[, "UGDS"], raw_data[, "ADM_RATE"],students_applied)
names(stu_applied_df) = c("UNITID", "INSTNM", "UGDS", "ADM_RATE", "students_applied")

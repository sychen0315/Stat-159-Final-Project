raw_data <- read.csv("data/data-sets/original-data-set/Most-Recent-Cohorts-Treasury-Elements.csv")

students_applied = as.numeric(as.character(raw_data[, "UGDS"]))/as.numeric(as.character(raw_data[, "ADM_RATE"]))
stu_applied_df = data.frame(raw_data[,"X...UNITID"],raw_data[,"INSTNM"], raw_data[, "UGDS"], 
                            raw_data[, "ADM_RATE"],students_applied, raw_data[,"COSTT4_A"], raw_data[,"MD_EARN_WNE_P10"],
                            raw_data[,"C[100 or 150]_4"], raw_data[,"PCTFLOAN"])
names(stu_applied_df) = c("UNITID", "INSTNM", "UGDS", "ADM_RATE", "students_applied", "COSTT4_A","MD_EARN_WNE_P10", 
                          "C[100 or 150]_4","PCTFLOAN")

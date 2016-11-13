raw_data <- read.csv("data/data-sets/original-data-set/MERGED2014_15_PP.csv")
major_cities <- read.csv("data/data-sets/original-data-set/major-cities.csv")

whether_major_city <- raw_data$CITY %in% major_cities$City
raw_data$major_city <- whether_major_city
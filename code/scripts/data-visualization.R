# Visualize the restaurants on map
library(ggplot2)
library(ggmap)
source("export_plot.R")


clean_data <- read.csv("data/data-sets/cleaned-data-set/clean-data.csv")
map <- get_map(location='united states', zoom=4, maptype = "terrain",
               source='google',color='color')
ggmap(map) + 
  geom_point(aes(x = LONGITUDE, y = LATITUDE, show_guide = TRUE, size = STU_APPLIED), data = clean_data,alpha=.5, na.rm = T)  + 
  scale_color_gradient(low="blue", high="red")

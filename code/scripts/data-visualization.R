# Visualize the restaurants on map
library(ggplot2)
library(ggmap)

# Reade clean data file
clean_data <- read.csv("data/data-sets/cleaned-data-set/clean-data.csv")

# get base map
map <- get_map(location='united states', zoom=4, maptype = "terrain",
               source='osm',color='color')


# Plot universities locations sized and colored by number of student applied
overall_stu_applied <- ggmap(map) + 
  geom_point(aes(x = LONGITUDE, y = LATITUDE, show_guide = TRUE, size = STU_APPLIED, color = STU_APPLIED), 
             data = clean_data,alpha=.5, na.rm = T)  + 
  scale_color_gradient(low="blue", high="green") +
  scale_size_area() +
  ggtitle("Universities locations sized and colored by number of student applied")

ggsave(filename = "images/map-images/overall_STU_APPLIED.png", 
       plot = overall_stu_applied, width = 8, height = 8)



# Plot universities locations sized and colored by earnings after ten years
overall_MD_EARN_WNE_P10 <- ggmap(map) + 
  geom_point(aes(x = LONGITUDE, y = LATITUDE, show_guide = TRUE, size = MD_EARN_WNE_P10, 
                 color = MD_EARN_WNE_P10), 
             data = clean_data,alpha=.5, na.rm = T)  + 
  scale_color_gradient(low="blue", high="green") +
  scale_size_area() +
  ggtitle("Universities locations sized and colored by earnings after ten years")

ggsave(filename = "images/map-images/overall_MD_EARN_WNE_P10.png", 
       plot = overall_MD_EARN_WNE_P10, width = 8, height = 8)

# Plot universities locations sized and colored by percentage of all undergraduates receiving federal loans
overall_PCTFLOAN <- ggmap(map) + 
  geom_point(aes(x = LONGITUDE, y = LATITUDE, show_guide = TRUE, size = PCTFLOAN, 
                 color = PCTFLOAN), 
             data = clean_data,alpha=.5, na.rm = T)  + 
  scale_color_gradient(low="blue", high="green") +
  scale_size_area() +
  ggtitle("Universities locations sized and colored by PCTFLOAN")

ggsave(filename = "images/map-images/overall_PCTFLOAN.png", 
       plot = overall_PCTFLOAN, width = 8, height = 8)

# Plot universities locations sized and colored by C100_4
overall_C100_4 <- ggmap(map) + 
  geom_point(aes(x = LONGITUDE, y = LATITUDE, show_guide = TRUE, size = C100_4, 
                 color = C100_4), 
             data = clean_data,alpha=.5, na.rm = T)  + 
  scale_color_gradient(low="blue", high="green") +
  scale_size_area() +
  ggtitle("Universities locations sized and colored by C100_4")

ggsave(filename = "images/map-images/overall_C100_4.png", 
       plot = overall_C100_4, width = 8, height = 8)
 

# Plot universities locations sized and colored by COSTT4_A
overall_COSTT4_A <- ggmap(map) + 
  geom_point(aes(x = LONGITUDE, y = LATITUDE, show_guide = TRUE, size = COSTT4_A, 
                 color = COSTT4_A), 
             data = clean_data,alpha=.5, na.rm = T)  + 
  scale_color_gradient(low="blue", high="green") +
  scale_size_area() +
  ggtitle("Universities locations sized and colored by COSTT4_A")

ggsave(filename = "images/map-images/overall_COSTT4_A.png", 
       plot = overall_COSTT4_A, width = 8, height = 8)


# Plot universities locations sized and colored by MAJOR_CITY
overall_MAJOR_CITY <- ggmap(map) + 
  geom_point(aes(x = LONGITUDE, y = LATITUDE, show_guide = TRUE, size = MAJOR_CITY, 
                 color = MAJOR_CITY), 
             data = clean_data,alpha=.5, na.rm = T)  + 
  scale_color_gradient(low="blue", high="green") +
  scale_size_area() +
  ggtitle("Universities locations sized and colored by MAJOR_CITY")

ggsave(filename = "images/map-images/overall_MAJOR_CITY.png", 
       plot = overall_MAJOR_CITY, width = 8, height = 8)

# Plot universities locations sized and colored by MINORATIO
overall_MINORATIO <- ggmap(map) + 
  geom_point(aes(x = LONGITUDE, y = LATITUDE, show_guide = TRUE, size = MINORATIO, 
                 color = MINORATIO), 
             data = clean_data,alpha=.5, na.rm = T)  + 
  scale_color_gradient(low="blue", high="green") +
  scale_size_area() +
  ggtitle("Universities locations sized and colored by MINORATIO")

ggsave(filename = "images/map-images/overall_MINORATIO.png", 
       plot = overall_MINORATIO, width = 8, height = 8)

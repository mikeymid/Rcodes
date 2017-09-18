
#ILWA
#Merge Yield & Plot (Primary key: Plot_id)


install.packages("dplyr")
install.packages("sqldf")


require(dplyr)
require(sqldf)


#----------------append files

test0 <- read.csv(file = "C:/Users/MMOHA14/Desktop/Projects/Proj 1 - Soil Nutrient Classification/Part2/data/MNPX/test0.csv", header = T, sep = ",")
test1 <- read.csv(file = "C:/Users/MMOHA14/Desktop/Projects/Proj 1 - Soil Nutrient Classification/Part2/data/MNPX/test200.csv", header = T, sep = ",")
test2 <- read.csv(file = "C:/Users/MMOHA14/Desktop/Projects/Proj 1 - Soil Nutrient Classification/Part2/data/MNPX/test400.csv", header = T, sep = ",")
test3 <- read.csv(file = "C:/Users/MMOHA14/Desktop/Projects/Proj 1 - Soil Nutrient Classification/Part2/data/MNPX/test600.csv", header = T, sep = ",")
test4 <- read.csv(file = "C:/Users/MMOHA14/Desktop/Projects/Proj 1 - Soil Nutrient Classification/Part2/data/MNPX/test800.csv", header = T, sep = ",")

final <- rbind(test0, test1, test2, test3, test4)

write.csv(final  , file = "C:/Users/MMOHA14/Desktop/Projects/Proj 1 - Soil Nutrient Classification/Part2/data/MNPX/MNPX_coord.csv")



#------------------------read main files


loc_coord <- read.csv(file = "C:/Users/MMOHA14/Desktop/Projects/Proj 1 - Soil Nutrient Classification/Part2/data/MNPX/MNPX_coord_FD.csv", header = T, sep = ",")

#coord; plotid


loc_yield <- read.csv(file = "C:/Users/MMOHA14/Desktop/Projects/Proj 1 - Soil Nutrient Classification/Part2/data/MNPX/MNPX_yield.csv", header = T, sep = ",")

#yield; plotid


#POW

#--------------------------checking the number of unique field/locations each file has


length(unique(loc_coord$plot_id))
#813
length(unique(loc_yield$PLOT_ID))
#920


#------------------------Data Filtering

#Removing unwanted columns

#ReqCol_soil <- select(soildata420, LOCATION, FIELD_NAME, POINT_1_LAT_NBR, POINT_1_LONG_NBR, POINT_2_LAT_NBR, POINT_2_LONG_NBR,POINT_3_LAT_NBR, POINT_3_LONG_NBR,POINT_4_LAT_NBR, POINT_4_LONG_NBR, plot_id)

#ReqCol_soil$latitude = mean(c(ReqCol_soil$POINT_1_LAT_NBR, ReqCol_soil$POINT_2_LAT_NBR, ReqCol_soil$POINT_3_LAT_NBR, ReqCol_soil$POINT_4_LAT_NBR))
#ReqCol_soil$longitude = mean(c(ReqCol_soil$POINT_1_LONG_NBR, ReqCol_soil$POINT_2_LONG_NBR, ReqCol_soil$POINT_3_LONG_NBR, ReqCol_soil$POINT_4_LONG_NBR))

#ReqCol_yield <- select(hybyield, BR_LOC_REF_ID, PLOT_ID, NUM_VALUE)

#View(ReqCol_soil)
#View(ReqCol_yield)

#length(unique(ReqCol_soil$longitude))

#------------------------merging or "join"

plot_yield <- sqldf("select a.latitude, a.longitude, a.plot_id, b.NUM_VALUE as YIELD, b.BR_LOC_REF_ID as Location from loc_coord as a, loc_yield as b where a.plot_id = b.PLOT_ID")
length(unique(plot_yield$plot_id))
#128

View(plot_yield)

write.csv(plot_yield  , file = "C:/Users/MMOHA14/Desktop/Projects/Proj 1 - Soil Nutrient Classification/Part2/data/MNPX/MNPX_coord_yield.csv")





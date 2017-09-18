


install.packages("dplyr")
install.packages("sqldf")


require(dplyr)
require(sqldf)




soildata420 <- read.csv(file = "C:/Users/MMOHA14/Desktop/Projects/Proj 1 - Soil Nutrient Classification/Part2/data/soildata420.csv", header = T, sep = ",")

#plotid;8 point coordinates; field/location name


hybyield <- read.csv(file = "C:/Users/MMOHA14/Desktop/Projects/Proj 1 - Soil Nutrient Classification/Part2/data/Hybrid2016YLDP3P420170614_bu.csv", header = T, sep = ",")

#yield; plotid


#POW

#--------------------------checking the number of unique field/locations each file has


length(unique(soildata420$LOCATION))
#420

length(unique(soildata420$FIELD_NAME))
#1415

length(unique(hybyield$BR_LOC_REF_ID))
#661


#------------------------Data Filtering

#Removing unwanted columns

ReqCol_soil <- select(soildata420, LOCATION, FIELD_NAME, POINT_1_LAT_NBR, POINT_1_LONG_NBR, POINT_2_LAT_NBR, POINT_2_LONG_NBR,POINT_3_LAT_NBR, POINT_3_LONG_NBR,POINT_4_LAT_NBR, POINT_4_LONG_NBR, plot_id)

#ReqCol_soil$latitude = mean(c(ReqCol_soil$POINT_1_LAT_NBR, ReqCol_soil$POINT_2_LAT_NBR, ReqCol_soil$POINT_3_LAT_NBR, ReqCol_soil$POINT_4_LAT_NBR))
#ReqCol_soil$longitude = mean(c(ReqCol_soil$POINT_1_LONG_NBR, ReqCol_soil$POINT_2_LONG_NBR, ReqCol_soil$POINT_3_LONG_NBR, ReqCol_soil$POINT_4_LONG_NBR))

ReqCol_yield <- select(hybyield, BR_LOC_REF_ID, PLOT_ID, NUM_VALUE)

View(ReqCol_soil)
View(ReqCol_yield)

length(unique(ReqCol_soil$longitude))

#------------------------merging or "join"

plot_yield <- sqldf("select a.LOCATION, a.POINT_1_LAT_NBR, a.POINT_1_LONG_NBR, a.POINT_2_LAT_NBR, a.POINT_2_LONG_NBR, a.POINT_3_LAT_NBR, a.POINT_3_LONG_NBR, a.POINT_4_LAT_NBR, a.POINT_4_LONG_NBR, a.plot_id as PLOT_ID, b.NUM_VALUE as YIELD from ReqCol_soil as a, ReqCol_yield as b where a.plot_id = b.PLOT_ID")


View(plot_yield)

write.csv(plot_yield  , file = "C:/Users/MMOHA14/Desktop/Projects/Proj 1 - Soil Nutrient Classification/Part2/data/plot_coord_yield.csv")


#--------------------checking out the new file


plot_coord_yield <- read.csv(file = "C:/Users/MMOHA14/Desktop/Projects/Proj 1 - Soil Nutrient Classification/Part2/data/plot_coord_yield.csv", header = T, sep = ",")

length(unique(plot_coord_yield$LOCATION))


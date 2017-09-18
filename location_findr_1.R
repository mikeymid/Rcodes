

#--------------Purpose: Selection of "next" field----------------

#--------------------------05-04-2017----------------------------

#----------------------------------------------------------------


# Step 1: Finding Dominant Soil

setwd("C:/Users/MMOHA14/Desktop/Projects/Proj 1 - Soil Nutrient Classification/BreedingSoilSampleData")


soiltype <- read.csv(file = "soiltype_locations.csv", header=TRUE, sep=",")
View(soiltype)


t_i <- table(soiltype$muname)
df_i <- as.data.frame(t_i)


f_i <- subset(df_i, (df_i$Freq > 1))
dim(f_i)


f_i <- f_i[order(f_i$Freq, decreasing = T),]


#-----------------------------------------------------------------

# Step 2: Finding Locations/FieldIDs


install.packages("dplyr")
require(dplyr)


soil_name <- "Drummer silty clay loam, 0 to 2 percent slopes"
#find a way to loop things here so that all the soil types will be considered


ReqRows <- filter(soiltype, muname == soil_name)
ReqCol <- select(ReqRows, LOC_ID)
FieldNames <- unique(ReqCol)


#-----------------------------------------------------------------

# Step 3: Checking for corresponding fieldIDs in Non-veris file

soil_data <-"//finch/nacornbreed/Environment_Modeling/Public/Ross/BreedingSoilSampleData/"
if(!exists("nv3")){nv3<-read.csv(paste(soil_data,"2014-2016-locations-samples-nonveris-3.csv",sep=""),stringsAsFactor=FALSE)}

Loc_Id = FieldNames$LOC_ID[FieldNames$LOC_ID %in% nv3$fieldId]
#here create a situation in compliment to the loop that takes in values where TRUE >= 2



#-----------------------------------------------------------------

# Step 4: Checking for corresponding fieldIDs in Yield Data file

soil_data <-"//finch/nacornbreed/Environment_Modeling/Public/Ross/BreedingSoilSampleData/"
if(!exists("nv3")){nv3<-read.csv(paste(soil_data,"2014-2016-locations-samples-nonveris-3.csv",sep=""),stringsAsFactor=FALSE)}

Loc_Id = FieldNames$LOC_ID[FieldNames$LOC_ID %in% nv3$fieldId]


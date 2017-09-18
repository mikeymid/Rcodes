

#--------------Purpose: Get All Suitable Locations----------------

#--------------------------05-05-2017----------------------------


#---------Criteria----
#----1)has yield data available----2)dominant soil type----3)have non-veris soil sample data----

install.packages("dplyr")
require(dplyr)



# Step 1: Finding Dominant Soil



soil_type <-"//finch/NACORNBREED/Environment_Modeling/Public/For_Mickey/"
if(!exists("soiltype")){soiltype<-read.csv(paste(soil_type,"soiltype_locations.csv",sep=""),stringsAsFactor=FALSE)}


table_i <- table(soiltype$muname)
df_i <- as.data.frame(table_i)

freq_i <- subset(df_i, (df_i$Freq > 1))
dim(freq_i)

freq_i <- freq_i[order(freq_i$Freq, decreasing = T),]


#-----------------------------------------------------------------

# Step 2: Finding Locations/FieldIDs



soil_name <- "Drummer silty clay loam, 0 to 2 percent slopes"
#find a way to loop things here so that all the soil types will be considered


ReqRows <- filter(soiltype, muname == soil_name)
ReqCol <- select(ReqRows, LOC_ID)
FieldNames <- unique(ReqCol)


#-----------------------------------------------------------------

# Step 3: Checking for corresponding fieldIDs in Non-veris file

soil_data <-"//finch/nacornbreed/Environment_Modeling/Public/Ross/BreedingSoilSampleData/"
if(!exists("nv3")){nv3<-read.csv(paste(soil_data,"2014-2016-locations-samples-nonveris-3.csv",sep=""),stringsAsFactor=FALSE)}

Loc_Id <- FieldNames$LOC_ID[FieldNames$LOC_ID %in% nv3$fieldId]
#here create a situation in complement to the loop that takes in values where TRUE >= 2

#-----------------------------------------------------------------

# Step 4: Checking for corresponding fieldIDs in Yield Data file

yield_data <-"C:/Users/MMOHA14/Desktop/Projects/Proj 1 - Soil Nutrient Classification/BreedingSoilSampleData/"
if(!exists("yielddata")){yielddata<-read.csv(paste(yield_data,"latest_2016cornyld.csv",sep=""),stringsAsFactor=FALSE)}

unique(yielddata$FLD)
Loc_Id <- Loc_Id[Loc_Id %in% yielddata$LOCID]


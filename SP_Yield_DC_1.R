
require(dplyr)
require(data.table)


#---------

yield_data <- "C:/Users/MMOHA14/Desktop/Projects/Proj 1 - Soil Nutrient Classification/BreedingSoilSampleData/"
if(!exists("yield_i")){yield_i<-read.csv(paste(yield_data,"MNPX16new.csv",sep=""),stringsAsFactor=FALSE)}


yield_i$NUMVAL[yield_i$UNIT == "Quintals/Hectare"]  <- yield_i$NUMVAL[yield_i$UNIT == "Quintals/Hectare"] * 1.593
yield_i$UNIT[yield_i$UNIT == "Quintals/Hectare"] <- "Bushels(56#)/Acre"

View(yield_i)


write.csv(yield_i, file = "C:/Users/MMOHA14/Desktop/Projects/Proj 1 - Soil Nutrient Classification/BreedingSoilSampleData/MNPX16new_bu_ac.csv")

#----------

soil_data <- "C:/Users/MMOHA14/Desktop/Projects/Proj 1 - Soil Nutrient Classification/BreedingSoilSampleData/"
if(!exists("nv3")){nv3<-read.csv(paste(soil_data,"soilsample1.csv",sep=""),stringsAsFactor=FALSE)}

site_name = "MNLO"
ReqRows <- filter(nv3, fieldId == site_name)
ReqCol <- select(ReqRows, fieldId, longitude, latitude) #Select Unique Identifiers
soil_i <- ReqCol
dim(soil_i)
View(soil_i)


#----------


#colnames(yield_i)[colnames(yield_i)=="FLD"] <- "fieldId"
#If the column names are different


new_df <- merge(soil_i, yield_i, by = "") #Select Unique Identifier
View(new_df)


#data.table, merge, dplyr or library(sqldf) can also be used


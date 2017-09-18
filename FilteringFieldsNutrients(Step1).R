

#Proj1: Soil Nutrient Distribution within Field
#Part2: Fields - KYST, INVI
#5-31-2017

install.packages("dplyr")

require(dplyr)


soil_data <-"C:/Users/MMOHA14/Desktop/Projects/Proj 1 - Soil Nutrient Classification/Part2/data/"
if(!exists("nv3")){nv3<-read.csv(paste(soil_data,"2014-2016-locations-samples-nonveris-3.csv",sep=""),stringsAsFactor=FALSE)}

#-------


site_name <- "KYST"
#var <- "organicMatter"


ReqRows <- filter(nv3, fieldId == site_name)
View(ReqRows)

ReqCol <- select(ReqRows, sampleId, ph, cec, fe, cu, mg, b, k, mn, p, s, organicMatter, zn, slope, curve, clay, sand, silt, omRatio, ecRatio, soil_texture_class, longitude, latitude, br_field_ids)
FieldData <- ReqCol

dim(FieldData)
hist(FieldData$organicMatter)
summary(FieldData$organicMatter)
hist(FieldData$cec)
summary(FieldData$cec)
hist(FieldData$k)
summary(FieldData$k)
hist(FieldData$ph)
summary(FieldData$ph)
hist(FieldData$s)
summary(FieldData$s)
hist(FieldData$zn)
summary(FieldData$zn)
hist(FieldData$k)
summary(FieldData$k)
hist(FieldData$k)
summary(FieldData$k)
#head(FieldData)
#View(FieldData)
#summary(FieldData)




getwd()
setwd("C:/Users/MMOHA14/Desktop/Projects/Proj 1 - Soil Nutrient Classification/Part2/data/")


write.csv(FieldData, file = "KYST_23.csv")
write.csv(ReqRows, file = "KYST_mainfile.csv")


#-------

site_name2 <- "INVI"
#var <- "organicMatter"


ReqRows2 <- filter(nv3, fieldId == site_name2)
#View(ReqRows)

ReqCol2 <- select(ReqRows2, sampleId, ph, cec, fe, cu, mg, b, k, mn, p, s, organicMatter, zn, slope, curve, clay, sand, silt, omRatio, ecRatio, soil_texture_class, longitude, latitude, br_field_ids)
FieldData2 <- ReqCol2

dim(FieldData2)
#head(FieldData)
#View(FieldData)
#summary(FieldData2)




#getwd()
#setwd("C:/Users/MMOHA14/Desktop/Projects/Proj 1 - Soil Nutrient Classification/Part2/data/")


write.csv(FieldData, file = "INVI_23.csv")
write.csv(ReqRows, file = "INVI_mainfile.csv")


#-------





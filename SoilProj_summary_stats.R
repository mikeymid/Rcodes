
#--------summary stats
#Proj1: Soil Nutrient Distribution within Field
#4-17-17

#---------


soil_data <-"//finch/nacornbreed/Environment_Modeling/Public/Ross/BreedingSoilSampleData/"
if(!exists("nv3")){nv3<-read.csv(paste(soil_data,"2014-2016-locations-samples-nonveris-3.csv",sep=""),stringsAsFactor=FALSE)}

#-------

site_name <- "MNPX"


ReqRows <- filter(nv3, fieldId == site_name)


getwd()
setwd("C:/Users/MMOHA14/Desktop/Projects/Proj 1 - Soil Nutrient Classification/BreedingSoilSampleData")
write.csv(ReqRows, file = "MNPX.csv")

#--------------

FieldData <-read.csv(file = "C:/Users/MMOHA14/Desktop/Projects/Proj 1 - Soil Nutrient Classification/BreedingSoilSampleData/MNPX.csv")


View(FieldData)
dim(FieldData)
head(FieldData)

#-------

par(mfrow=c(1,3))

var <- "organicMatter"

hist(FieldData[,which(colnames(FieldData)==var)], main = paste("Histogram of", var), xlab = var)
summary(FieldData[,which(colnames(FieldData)==var)])


var <- "k"

hist(FieldData[,which(colnames(FieldData)==var)], main = paste("Histogram of", var), xlab = var)
summary(FieldData[,which(colnames(FieldData)==var)])


var <- "p"

hist(FieldData[,which(colnames(FieldData)==var)], main = paste("Histogram of", var), xlab = var)
summary(FieldData[,which(colnames(FieldData)==var)])

par(mfrow=c(1,3))

var <- "s"

hist(FieldData[,which(colnames(FieldData)==var)], main = paste("Histogram of", var), xlab = var)
summary(FieldData[,which(colnames(FieldData)==var)])


var <- "cec"

hist(FieldData[,which(colnames(FieldData)==var)], main = paste("Histogram of", var), xlab = var)
summary(FieldData[,which(colnames(FieldData)==var)])


var <- "zn"

hist(FieldData[,which(colnames(FieldData)==var)], main = paste("Histogram of", var), xlab = var)
summary(FieldData[,which(colnames(FieldData)==var)])






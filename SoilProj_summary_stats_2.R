
#Mikey
#SummaryStats of Variables
#08-18-17

#-------------------

FieldData <- read.csv(file = "C:/Users/MMOHA14/Desktop/Projects/Proj 1 - Soil Nutrient Classification/Part3/data/locations/IADV.Corn.2017_MON-GLOBAL BREEDING-619_e3759721-954b-49d1-875b-d6319f19d3b8.csv", header = T, sep = ",")

#---------------------

par(mfrow=c(1,3))


var <- "organicMatter"

hist(FieldData[,which(colnames(FieldData)==var)], main = paste("Histogram of", var), xlab = var)
summary(FieldData[,which(colnames(FieldData)==var)])


var <- "cec"

hist(FieldData[,which(colnames(FieldData)==var)], main = paste("Histogram of", var), xlab = var)
summary(FieldData[,which(colnames(FieldData)==var)])


var <- "ph"

hist(FieldData[,which(colnames(FieldData)==var)], main = paste("Histogram of", var), xlab = var)
summary(FieldData[,which(colnames(FieldData)==var)])


par(mfrow=c(1,3))

var <- "p"

hist(FieldData[,which(colnames(FieldData)==var)], main = paste("Histogram of", var), xlab = var)
summary(FieldData[,which(colnames(FieldData)==var)])


var <- "k"

hist(FieldData[,which(colnames(FieldData)==var)], main = paste("Histogram of", var), xlab = var)
summary(FieldData[,which(colnames(FieldData)==var)])


var <- "s"

hist(FieldData[,which(colnames(FieldData)==var)], main = paste("Histogram of", var), xlab = var)
summary(FieldData[,which(colnames(FieldData)==var)])




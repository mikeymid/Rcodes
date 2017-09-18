
require(dplyr)
require(data.table)


#---------

yield_data <- "C:/Users/MMOHA14/Desktop/Projects/Proj 1 - Soil Nutrient Classification/Part2/data/"
if(!exists("yield_i")){yield_i<-read.csv(paste(yield_data,"Hybrid2016YLDP3P420170614.csv",sep=""),stringsAsFactor=FALSE)}


yield_i$NUM_VALUE[yield_i$UOM == "Quintals/Hectare"]  <- yield_i$NUM_VALUE[yield_i$UOM == "Quintals/Hectare"] * 1.593
yield_i$UOM[yield_i$UOM == "Quintals/Hectare"] <- "Bushels(56#)/Acre"

View(yield_i)


write.csv(yield_i, file = "C:/Users/MMOHA14/Desktop/Projects/Proj 1 - Soil Nutrient Classification/Part2/data/Hybrid2016YLDP3P420170614_bu.csv")

#----------


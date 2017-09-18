
install.packages("dplyr")


require(dplyr)




soil_summary <- read.csv(file = "C:/Users/MMOHA14/Desktop/Projects/Proj 1 - Soil Nutrient Classification/Part3/data/SoilSamples(Summary).csv", header = T, sep = ",")

View(soil_summary)


#Fields we care about:

#pH
#CEC
#OrganicMatter
#N-P-K
#S
#Zn
#Lat-Long
#fieldId
soil_summary <- as.data.frame(soil_summary)
ReqCol_soil <- select(soil_summary, clientId)
class(soil_summary)

a <- soil_summary[,c("clientId", "zn")]
a <- as.data.frame(a)
View(a)

a=a[which(is.na(a$clientId)==F || is.na(a$zn)==T),]

?select


#select.cases()?

#--------------------


soil1 <- soil_summary
soil2 <- soil1[soil1$importRowsCount > 50 & soil1$importRowsCount < 350, ]
length(unique(soil2$importRowsCount))
length(unique(soil2$importFileName))
soil2 <- as.data.frame(soil2)
View(unique(soil2))


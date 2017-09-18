
-------------------#Proj3 Map-making
#Creating maps based on tillage types for 2014-16
  

------------------#Read in the Data


MyData <- read.csv(file="C:/Users/MMOHA14/Desktop/Projects/Proj 3 - Maps for Counties/Data/CornTillage.csv", header=TRUE, sep=",")

View(MyData)
dim(MyData)
colnames(MyData)

colnames(MyData)[5] <- "Area"
#change the column name for ease of use

-----------------#Filter based on year

install.packages("dplyr")
require(dplyr)

x = "2016"

TilData <- filter(MyData, Year == x)
dim(TilData)


View(TilData)

--------------#Selection based on Area
  
#For multiple rows with same FIPS value, we need to keep only the row with maximum Area value.
  
#some of the FIPS has same Sample value - that's why we are going ahead with Area here
  
#get the unique rows
uniqFIPS <- unique(TilData$FIPS)


#define an empty df
Til_summary <- c()

for (i in 1:length(uniqFIPS)) {
TilData_i <- TilData[TilData$FIPS == uniqFIPS[i],]
#condense info into unique ones
TilData_i <- TilData_i[order(TilData_i$Area, decreasing = TRUE), ]
#Order in descending order 
Til_summary <- rbind(Til_summary, TilData_i[1,])
#select the first row and all the columns
}
head(Til_summary); dim(Til_summary)

View(Til_summary)
#?order

------------#Save your results as a .csv
  
getwd()
setwd("C:/Users/MMOHA14/Desktop/Projects/Proj 3 - Maps for Counties/Data")
write.csv(Til_summary, file = "til_2016.csv")

#write.csv(Til_summary, file = "C:/Users/MMOHA14/Desktop/Projects/Proj 3 - Maps for Counties/Data/MyData.csv")


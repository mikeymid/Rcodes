
#9-5-17
#Mikey

install.packages('dplyr')
require(dplyr)

#Task: Create Detailed Summary for All 2018 Locations with Soil Data



#File1 -> Location ID, lat, long, veris, non-veris

#File2 -> importfilename, SOM.mean, SOM.median, etc

#File3 -> Importfilename, Location ID


#------------------

File1 <- read.csv(file = "C:/Users/MMOHA14/Desktop/Projects/Proj 1 - Soil Nutrient Classification/Part3/data/2018_Loc_Summary.csv", header = T, sep = ",")
File1_filtered <- select(File1, LocationID, Latitude, Longitude, SoilType)

View(File1_filtered)

#------------------

File2 <- read.csv(file = "C:/Users/MMOHA14/Desktop/Projects/Proj 1 - Soil Nutrient Classification/Part3/data/SoilSamples(Summary).csv", header = T, sep = ",")
File2_filtered <- select(File2, importRowsCount, importFileName, s.mean,	s.var,	s.min,	s.max,	s.n)

View(File2_filtered)

#------------------

File3 <- read.csv(file = "C:/Users/MMOHA14/Desktop/Projects/Proj 1 - Soil Nutrient Classification/Part3/data/SoilSamples(Summary).csv", header = T, sep = ",")
#File3_filtered <- select(File3, )

#View(File3_filtered)





#Merge multiple files havinf coorindate data
#Filter only the FieldDrive info

install.packages("dplyr")
install.packages("sqldf")


require(dplyr)
require(sqldf)


#----------------append files

test0 <- read.csv(file = "C:/Users/MMOHA14/Desktop/Projects/Proj 1 - Soil Nutrient Classification/Part2/data/MNPX/test0.csv", header = T, sep = ",")
test1 <- read.csv(file = "C:/Users/MMOHA14/Desktop/Projects/Proj 1 - Soil Nutrient Classification/Part2/data/MNPX/test200.csv", header = T, sep = ",")
test2 <- read.csv(file = "C:/Users/MMOHA14/Desktop/Projects/Proj 1 - Soil Nutrient Classification/Part2/data/MNPX/test400.csv", header = T, sep = ",")
test3 <- read.csv(file = "C:/Users/MMOHA14/Desktop/Projects/Proj 1 - Soil Nutrient Classification/Part2/data/MNPX/test600.csv", header = T, sep = ",")
test4 <- read.csv(file = "C:/Users/MMOHA14/Desktop/Projects/Proj 1 - Soil Nutrient Classification/Part2/data/MNPX/test800.csv", header = T, sep = ",")

final <- rbind(test0, test1, test2, test3, test4)

final1 <- final[final$source == "FIELD_DRIVE", ]

write.csv(final1  , file = "C:/Users/MMOHA14/Desktop/Projects/Proj 1 - Soil Nutrient Classification/Part2/data/MNPX/MNPX_coord.csv")


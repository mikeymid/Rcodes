
#Mikey
#7-27-17
#Read in xlsx file

install.packages("readxl")
require(readxl)

yield_i <- read_excel("C:/Users/MMOHA14/Desktop/Projects/Proj 1 - Soil Nutrient Classification/Part2/data/Hybrid2016YLDP3P420170614 - Copy.xlsx", sheet = 1)


write.csv(yield_i, file = "C:/Users/MMOHA14/Desktop/Projects/Proj 1 - Soil Nutrient Classification/Part2/data/yield_hybrids_2016_bu.csv")



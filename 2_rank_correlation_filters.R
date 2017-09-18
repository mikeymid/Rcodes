

install.packages("dplyr")
install.packages("sqldf")


require(dplyr)
require(sqldf)


germplasm_plotids_i <- read.csv(file = "C:/Users/MMOHA14/Desktop/Projects/Proj 1 - Soil Nutrient Classification/BreedingSoilSampleData/MNPX/com_hyb_2/Hybrid2016YLDP3P420170525.csv", header = T, sep = ",")
germplasm_plotids <- select(germplasm_plotids_i, PLOT_ID, GERMPLASM_ID)


yield_plotids_i <- read.csv(file = "C:/Users/MMOHA14/Desktop/Projects/Proj 1 - Soil Nutrient Classification/BreedingSoilSampleData/MNPX/com_hyb_2/MNPX16_p34_bu_ac.csv", header = T, sep = ",")
yield_plotids <- select(yield_plotids_i, PLOT_ID, STAGE, NUMVAL)


hav_plotids <- read.csv(file = "C:/Users/MMOHA14/Desktop/Projects/Proj 1 - Soil Nutrient Classification/BreedingSoilSampleData/MNPX/com_hyb_2/havana_p3_4.csv", header = T, sep = ",")


newry_plotids <- read.csv(file = "C:/Users/MMOHA14/Desktop/Projects/Proj 1 - Soil Nutrient Classification/BreedingSoilSampleData/MNPX/com_hyb_2/newry_p3_4.csv", header = T, sep = ",")




h <- sqldf("select a.plotid, a.Type as Soil_type, b.STAGE, b.NUMVAL as Yield from hav_plotids as a, yield_plotids as b where a.plotid = b.PLOT_ID")

n <- sqldf("select a.plotid, a.Type as Soil_type, b.STAGE, b.NUMVAL as Yield from newry_plotids as a, yield_plotids as b where a.plotid = b.PLOT_ID")


h2 <- sqldf("select a.plotid, a.Soil_type, a.Yield, a.STAGE, b.GERMPLASM_ID as Hybrid from h as a, germplasm_plotids as b where a.plotid = b.PLOT_ID")

n2 <- sqldf("select a.plotid, a.Soil_type, a.Yield, a.STAGE, b.GERMPLASM_ID as Hybrid from n as a, germplasm_plotids as b where a.plotid = b.PLOT_ID")






write.csv(h2 , file = "C:/Users/MMOHA14/Desktop/Projects/Proj 1 - Soil Nutrient Classification/BreedingSoilSampleData/MNPX/com_hyb_2/hav_final2.csv")

write.csv(n2 , file = "C:/Users/MMOHA14/Desktop/Projects/Proj 1 - Soil Nutrient Classification/BreedingSoilSampleData/MNPX/com_hyb_2/newry_final2.csv")
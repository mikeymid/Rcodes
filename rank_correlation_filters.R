

install.packages("dplyr")
install.packages("sqldf")


require(dplyr)
require(sqldf)


hav_plotids <- read.csv(file = "C:/Users/MMOHA14/Desktop/Projects/Proj 1 - Soil Nutrient Classification/BreedingSoilSampleData/MNPX/mnpx_hav_s3_4_plotids.csv", header = T, sep = ",")

#plotid, Type

newry_plotids <- read.csv(file = "C:/Users/MMOHA14/Desktop/Projects/Proj 1 - Soil Nutrient Classification/BreedingSoilSampleData/MNPX/mnpx_newry_s3_4_plotids.csv", header = T, sep = ",")


yield_plotids_i <- read.csv(file = "C:/Users/MMOHA14/Desktop/Projects/Proj 1 - Soil Nutrient Classification/BreedingSoilSampleData/MNPX/MNPX16new_bu_ac.csv", header = T, sep = ",")
yield_plotids <- select(yield_plotids_i,PLOT_ID ,NUMVAL)


germplasm_plotids_i <- read.csv(file = "C:/Users/MMOHA14/Desktop/Projects/Proj 1 - Soil Nutrient Classification/BreedingSoilSampleData/MNPX/mnpx_germplasum.csv", header = T, sep = ",")
germplasm_plotids <- select(germplasm_plotids_i,PLOT_ID ,GERMPLASM_ID)





h <- sqldf("select a.plotid, a.Type as Soil_type, b.NUMVAL as Yield from hav_plotids as a, yield_plotids as b where a.plotid = b.PLOT_ID")

n <- sqldf("select a.plotid, a.Type as Soil_type, b.NUMVAL as Yield from newry_plotids as a, yield_plotids as b where a.plotid = b.PLOT_ID")


h2 <- sqldf("select a.plotid, a.Soil_type, a.Yield, b.GERMPLASM_ID as Hybrid from h as a, germplasm_plotids as b where a.plotid = b.PLOT_ID")

n2 <- sqldf("select a.plotid, a.Soil_type, a.Yield, b.GERMPLASM_ID as Hybrid from n as a, germplasm_plotids as b where a.plotid = b.PLOT_ID")

#maybe you can also add the "Stage" field

write.csv(h2 , file = "C:/Users/MMOHA14/Desktop/Projects/Proj 1 - Soil Nutrient Classification/BreedingSoilSampleData/MNPX/hav_final.csv")

write.csv(n2 , file = "C:/Users/MMOHA14/Desktop/Projects/Proj 1 - Soil Nutrient Classification/BreedingSoilSampleData/MNPX/newry_final.csv")

# 
# *\h3 <- h2 %>%
#   group_by(Hybrid) %>%
#   summarise(Avg = mean(Yield))
# 
# h3$SoilType <- rep("Havana",nrow(h3)) # make new column 
# 
# n3 <- n2 %>%
#   group_by(Hybrid) %>%
#   summarise(mean(Yield, na.rm=TRUE))*/
#CTRL+Shift+C for commenting multiple rows
#


View(h3)
  
write.csv(h3 , file = "C:/Users/MMOHA14/Desktop/Projects/Proj 1 - Soil Nutrient Classification/BreedingSoilSampleData/MNPX/hav_final_grouped.csv")


#------------------------------------------------Stage Info


h <- sqldf("select a.plotid, a.Type as Soil_type, b.NUMVAL as Yield, b.STAGE from hav_plotids as a, yield_plotids as b where a.plotid = b.PLOT_ID")

n <- sqldf("select a.plotid, a.Type as Soil_type, b.NUMVAL as Yield, b.STAGE from newry_plotids as a, yield_plotids as b where a.plotid = b.PLOT_ID")


h2 <- sqldf("select a.plotid, a.Soil_type, a.Yield, a.STAGE, b.GERMPLASM_ID as Hybrid from h as a, germplasm_plotids as b where a.plotid = b.PLOT_ID")

n2 <- sqldf("select a.plotid, a.Soil_type, a.Yield, a.STAGE, b.GERMPLASM_ID as Hybrid from n as a, germplasm_plotids as b where a.plotid = b.PLOT_ID")


write.csv(h2 , file = "C:/Users/MMOHA14/Desktop/Projects/Proj 1 - Soil Nutrient Classification/BreedingSoilSampleData/MNPX/hav_final_stages.csv")

write.csv(n2 , file = "C:/Users/MMOHA14/Desktop/Projects/Proj 1 - Soil Nutrient Classification/BreedingSoilSampleData/MNPX/newry_final_stages.csv")




#-------------------------------Getting the 144 hybrids coordinates in SRU_Newry and SRU_Havana

hav_gp <- read.csv(file = "C:/Users/MMOHA14/Desktop/Projects/Proj 1 - Soil Nutrient Classification/BreedingSoilSampleData/MNPX/hav_final.csv", header = T, sep = ",")

newry_gp <- read.csv(file = "C:/Users/MMOHA14/Desktop/Projects/Proj 1 - Soil Nutrient Classification/BreedingSoilSampleData/MNPX/newry_final.csv", header = T, sep = ",")

merged_gp <- read.csv(file = "C:/Users/MMOHA14/Desktop/Projects/Proj 1 - Soil Nutrient Classification/BreedingSoilSampleData/MNPX/hybrid_yield_merged.csv", header = T, sep = ",")



h_hybrids <- sqldf("select a.plotid, a.Yield from hav_gp as a, merged_gp as b where a.Hybrid = b.Hybrid")
n_hybrids <- sqldf("select a.plotid, a.Yield from newry_gp as a, merged_gp as b where a.Hybrid = b.Hybrid")


write.csv(h_hybrids , file = "C:/Users/MMOHA14/Desktop/Projects/Proj 1 - Soil Nutrient Classification/BreedingSoilSampleData/MNPX/h_plots.csv")
write.csv(n_hybrids , file = "C:/Users/MMOHA14/Desktop/Projects/Proj 1 - Soil Nutrient Classification/BreedingSoilSampleData/MNPX/n_plots.csv")





#----------------latest codes------------------39 common hybrids

install.packages("dplyr")
install.packages("sqldf")


require(dplyr)
require(sqldf)






hav_plotids <- read.csv(file = "C:/Users/MMOHA14/Desktop/Projects/Proj 1 - Soil Nutrient Classification/BreedingSoilSampleData/MNPX/hav_final.csv", header = T, sep = ",")


newry_plotids <- read.csv(file = "C:/Users/MMOHA14/Desktop/Projects/Proj 1 - Soil Nutrient Classification/BreedingSoilSampleData/MNPX/newry_final.csv", header = T, sep = ",")


yield_plotids_i <- read.csv(file = "C:/Users/MMOHA14/Desktop/Projects/Proj 1 - Soil Nutrient Classification/BreedingSoilSampleData/MNPX/mnpx_germplasum_new.csv", header = T, sep = ",")
yield_plotids <- select(yield_plotids_i,PLOT_ID,EXPER_STAGE_REF_ID, TEST_SET_COMMENTS)



h <- sqldf("select a.plotid, a.Soil_type, a.Yield, a.Hybrid, b.EXPER_STAGE_REF_ID as Stage, b.TEST_SET_COMMENTS as Comments from hav_plotids as a, yield_plotids as b where a.plotid = b.PLOT_ID")

n <- sqldf("select a.plotid, a.Soil_type, a.Yield, a.Hybrid, b.EXPER_STAGE_REF_ID as Stage, b.TEST_SET_COMMENTS as Comments from newry_plotids as a, yield_plotids as b where a.plotid = b.PLOT_ID")






write.csv(h , file = "C:/Users/MMOHA14/Desktop/Projects/Proj 1 - Soil Nutrient Classification/BreedingSoilSampleData/MNPX/hav_final1.csv")

write.csv(n , file = "C:/Users/MMOHA14/Desktop/Projects/Proj 1 - Soil Nutrient Classification/BreedingSoilSampleData/MNPX/newry_final1.csv")

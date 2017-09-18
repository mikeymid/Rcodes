
#9-14-17
#compare median and mean of soil sample nutrients w.r.t Adam's calculations


install.packages("dplyr")
require(dplyr)

install.packages("sqldf")
require(sqldf)


adam_values <- read.csv(file = "C:/Users/MMOHA14/Desktop/Projects/Proj 1 - Soil Nutrient Classification/Part3/data/Adam_FY18_soil_samples.csv", header = T, sep = ",")
soilnutrient_values <- read.csv(file = "C:/Users/MMOHA14/Desktop/Projects/Proj 1 - Soil Nutrient Classification/Part3/data/Summary_files.csv", header = T, sep = ",")


test_adam <- select(adam_values, LocID, cec_mean, cec_median, ph_mean, ph_median, b_mean, b_median,
                    zn_mean, zn_median, mg_mean, mg_median, p_mean, p_median, cu_mean, cu_median, 
                    ca_mean, ca_median, ca_k_mean, ca_k_median, s_mean, s_median, fe_mean, fe_median, organicMatter_mean, organicMatter_median)
test_real <- select(soilnutrient_values, fieldId, mean_CEC, median_CEC, mean_pH, median_pH, mean_B, median_B, mean_Zn, median_Zn, mean_Mg, median_Mg, mean_P, median_P, 
                    mean_S, median_S, mean_Cu, median_Cu, mean_Ca, median_Ca, mean_K, median_K, mean_Fe, median_Fe, mean_SOM, median_SOM)
  

#test_compare <- sqldf("select a.LocID, a.s_mean as S_Mean_Adam, b.mean_s as S_Mean_Calc, a.s_median as S_Median_Adam, b.median_s as S_Median_Calc from test_adam as a, test_real as b 
#where a.LocID = b.fieldId")



test_compare <- sqldf("select a.LocID, a.s_mean as S_Mean_Adam, b.mean_S as S_Mean_Calc, a.s_median as S_Median_Adam, b.median_S as S_Median_Calc, 
                      a.organicMatter_mean as SOM_Mean_Adam, b.mean_SOM as SOM_Mean_Calc, a.organicMatter_median as SOM_Median_Adam, b.median_SOM as SOM_Median_Calc, 
                      a.fe_mean as Fe_Mean_Adam, b.mean_Fe as Fe_Mean_Calc, a.fe_median as Fe_Median_Adam, b.median_Fe as Fe_Median_Calc, 
                      a.cec_mean as CEC_Mean_Adam, b.mean_CEC as CEC_Mean_Calc, a.cec_median as CEC_Median_Adam, b.median_CEC as CEC_Median_Calc, 
                      a.ph_mean as pH_Mean_Adam, b.mean_pH as pH_Mean_Calc, a.ph_median as pH_Median_Adam, b.median_pH as pH_Median_Calc, 
                      a.b_mean as B_Mean_Adam, b.mean_B as B_Mean_Calc, a.b_median as B_Median_Adam, b.median_B as B_Median_Calc, 
                      a.zn_mean as Zn_Mean_Adam, b.mean_Zn as Zn_Mean_Calc, a.zn_median as Zn_Median_Adam, b.median_Zn as Zn_Median_Calc, 
                      a.mg_mean as Mg_Mean_Adam, b.mean_Mg as Mg_Mean_Calc, a.mg_median as Mg_Median_Adam, b.median_Mg as Mg_Median_Calc, 
                      a.p_mean as P_Mean_Adam, b.mean_P as P_Mean_Calc, a.p_median as P_Median_Adam, b.median_P as P_Median_Calc, 
                      a.cu_mean as Cu_Mean_Adam, b.mean_Cu as Cu_Mean_Calc, a.cu_median as Cu_Median_Adam, b.median_Cu as Cu_Median_Calc, 
                      a.ca_mean as Ca_Mean_Adam, b.mean_Ca as Ca_Mean_Calc, a.ca_median as Ca_Median_Adam, b.median_Ca as Ca_Median_Calc, 
                      a.ca_k_mean as K_Mean_Adam, b.mean_K as K_Mean_Calc, a.ca_k_median as K_Median_Adam, b.median_K as K_Median_Calc 
                      from test_adam as a, test_real as b where a.LocID = b.fieldId")
View(test_compare)

setwd("C:/Users/MMOHA14/Desktop/Projects/Proj 1 - Soil Nutrient Classification/Part3/data/")

write.csv(test_compare, file = "Adam_Calc_comparison.csv")




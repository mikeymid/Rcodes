
#9-12-2017
#mean, median for soil samples


#merge all the files in the folder

#query the field name and required values

#calculate mean and median

install.packages('plyr')
library(plyr)    


install.packages("dplyr")
require(dplyr)


filenames <- list.files(path = "C:/Users/MMOHA14/Desktop/Projects/Proj 1 - Soil Nutrient Classification/Part3/data/TotalSoilSample", pattern = "*", full.names=TRUE)
import_list <- ldply(filenames, read.csv)

View(import_list)

setwd("C:/Users/MMOHA14/Desktop/Projects/Proj 1 - Soil Nutrient Classification/Part3/data/")


#write.csv(import_list, file = "all_files.csv")


ReqCol_import_list <- select(import_list, fieldId, organicMatter, cec, b, k, ph, mg, zn, p, s, cu, ca, fe)
SoilNutrientData <- ReqCol_import_list 
#View(SoilNutrientData)
#length(unique(SoilNutrientData$fieldId))




Summary_SND <- SoilNutrientData %>% group_by(fieldId) %>% summarize(median_SOM = median(organicMatter),mean_SOM = mean(organicMatter),
                                                     median_S = median(s),mean_S = mean(s),
                                                     median_pH = median(ph),mean_pH = mean(ph),
                                                     median_CEC = median(cec),mean_CEC = mean(cec),
                                                     median_Zn = median(zn),mean_Zn = mean(zn),
                                                     median_B = median(b),mean_B = mean(b),
                                                     median_P = median(p),mean_P = mean(p),
                                                     median_K = median(k),mean_K = mean(k),
                                                     median_Mg = median(mg),mean_Mg = mean(mg),
                                                     median_Cu = median(cu),mean_Cu = mean(cu),
                                                     median_Fe = median(fe),mean_Fe = mean(fe),
                                                     median_Ca = median(ca), mean_Ca = mean(ca))

#ReqRows <- filter(SoilNutrientData, fieldId == 'ILTH')
#ReqRows %>% summarize(mean_b=mean(b))

#View(Summary_SND)
#length(unique(Summary_SND$fieldId))

write.csv(Summary_SND, file = "Summary_files.csv")




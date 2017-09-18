


#Mikey
#7-27-17
#Join Yield and Coord based on Plot_ids

#------------------------Load Packages

install.packages("dplyr")
install.packages("sqldf")


require(dplyr)
require(sqldf)


#------------------------read main files


loc_coord <- read.csv(file = "C:/Users/MMOHA14/Desktop/Projects/Proj 1 - Soil Nutrient Classification/Part2/data/IAMR200.csv", header = T, sep = ",")
#coord; plotid
#View(loc_coord)


all_yield <- read.csv(file = "C:/Users/MMOHA14/Desktop/Projects/Proj 1 - Soil Nutrient Classification/Part2/data/yield_hybrids_2016_bu.csv", header = T, sep = ",")
#yield; plotid; for all locations
#View(all_yield)


loc_name <- "IAMR"
loc_yield <- filter(all_yield, BR_LOC_REF_ID == loc_name)
#dim(loc_yield)
#View(loc_yield)
#yield info for our particular location



#--------------------------checking the number of unique plot_ids each file has (optional)


length(unique(loc_coord$plot_id))
length(unique(loc_yield$PLOT_ID))


#---------------------------Filtering the columns and Joining the files based on plot_ids


plot_yield <- sqldf("select  a.longitude, a.latitude, a.plot_id, b.NUM_VALUE as YIELD, b.BR_LOC_REF_ID as Location from loc_coord as a, loc_yield as b where a.plot_id = b.PLOT_ID")
length(unique(plot_yield$plot_id))

write.csv(plot_yield, file = "C:/Users/MMOHA14/Desktop/Projects/Proj 1 - Soil Nutrient Classification/Part2/data/plot_yield_IAMR.csv")
#saving the final file



# Yield Plotting - Symbology
# yield class:
# <100 dark red
# 100 -150 red
# 150 - 175 orange
# 175 - 200 yellow
# 200 - 230 green
#  230 blue "



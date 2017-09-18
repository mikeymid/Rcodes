

rm(list =ls())

file_i = read.csv(file = "C:/Users/MMOHA14/Desktop/Projects/Proj 4 - Data Viz/monsanto_median_planting_days.csv", header = T, sep = ",")
file_j = read.csv(file = "C:/Users/MMOHA14/Desktop/Projects/Proj 4 - Data Viz/farmer_soybeans_planting_avg.csv", header = T, sep = ",")


file_k = read.csv(file = "C:/Users/MMOHA14/Desktop/Projects/Proj 4 - Data Viz/farmer_sample.csv", header = T, sep = ",")

View(file_k)

state.group = rownames(file_k)
barplot(file_k, legend = state.group, beside = TRUE )





rdate = as.Date(file_i$day_of_yr, "%d")

fix(rdate)

plot(data = file_i, STAGE~day_of_yr, main = "plot time series", xlab = "Stages", ylab = "Days", type = "l", col = "blue")




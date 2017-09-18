


# we will need: 
install.packages("geoR")
library(geoR)


# import data for analysis


soil_data <- read.csv("C:/Users/MMOHA14/Desktop/Projects/Proj 1 - Soil Nutrient Classification/BreedingSoilSampleData/MNPX_SOM.csv")
head(soil_data, n=10)

dists <- dist(soil_data[,14:15])
summary(dists) 
??dist

breaksy = seq(0, 1.5, l = 11)

v1 <- variog(soil_data, coords = dists, data = soil_data$organicMatter, 
             uvec = "default", breaks = breaksy) 
Argument


plot(v1, type = "b", main = "Variogram: Av8top") 

??varilog

variog(geodata, coords = geodata$coords, data = geodata$data, 
       uvec = "default", breaks = "default",
       trend = "cte", lambda = 1,
       option = c("bin", "cloud", "smooth"),
       estimator.type = c("classical", "modulus"), 
       nugget.tolerance, max.dist, pairs.min = 2,
       bin.cloud = FALSE, direction = "omnidirectional", tolerance = pi/8,
       unit.angle = c("radians","degrees"), angles = FALSE, messages, ...) 

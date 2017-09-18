

install.packages("raster")
library(raster)

install.packages("colorRamps")
library(colorRamps) # for some crispy colors

install.packages("vegan")
library(vegan) # will be used for PCNM

install.packages("ncf")
library(ncf)

#----------------

# empty matrix and spatial coordinates of its cells
side=30
my.mat <- matrix(NA, nrow=side, ncol=side)
x.coord <- rep(1:side, each=side)
y.coord <- rep(1:side, times=side)
xy <- data.frame(x.coord, y.coord)

# all paiwise euclidean distances between the cells
xy.dist <- dist(xy)

# PCNM axes of the dist. matrix (from 'vegan' package)
pcnm.axes <- pcnm(xy.dist)$vectors

# using 8th PCNM axis as my atificial z variable
z.value <- pcnm.axes[,8]*200 + rnorm(side*side, 0, 1)

# plotting the artificial spatial data
my.mat[] <- z.value
r <- raster(my.mat)
plot(r, axes=F, col=matlab.like(20))

#--------------------

soil_data <- read.csv("C:/Users/MMOHA14/Desktop/Projects/Proj 1 - Soil Nutrient Classification/BreedingSoilSampleData/MNPX_SOM.csv")
head(soil_data, n=10)


ncf.cor <- correlog(soil_data$longitude, soil_data$latitude, soil_data$organicMatter,
                    increment=1, resamp=500)

plot(ncf.cor)

??correlog
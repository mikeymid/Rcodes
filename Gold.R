require(sp)
require(rgeos)
library(alphahull)
library(automap)
library(base)
library(dplyr)
library(gdata)
library(geoR)
library(geosphere)
library(ggmap)
library(ggplot2)
library(graphics)
library(grDevices)
library(gridExtra)
library(gtools)
library(rLiDAR)
library(mapproj)
library(maps)
library(maptools)
library(openxlsx)
library(plotKML)
library(prevR)
library(psych)
library(raster)
library(RCurl)
library(reshape2)
library(rgdal)
library(rgeos)
library(rjson)
library(SDMTools)
library(shape)
library(shapefiles)
library(soiltexture)
library(sp)
library(stringr)
library(utils)
library(xlsx)
library(XML)


rossfp<-"//finch/nacornbreed/Environment_Modeling/Public/Ross/BreedingSoilSampleData/"
nv3<-read.csv(paste(rossfp,"2014-2016-locations-samples-nonveris-3.csv",sep=""),stringsAsFactor=FALSE)
head(nv3);dim(nv3);


#map from ggmap, geosphere packages
map("world",bg="lightgreen",col="red",xlim=c(-130,-60),ylim=c(20,50))
map("usa")
map("world",add=TRUE)
map("world",col="#ffffff",fill=FALSE,bg="black",lwd=0.05,xlim=c(-110, -67), ylim = c(25,50));
map("usa",col="cyan",fill=FALSE,bg="turqoise",lwd=4,add=TRUE,lty=1);i=1
map("usa",col="red",fill=FALSE,bg="turqoise",lwd=2,add=TRUE,lty=3);i=1
coordinates(nv3)<-c("longitude","latitude")
plot(nv3,add=TRUE,col="white")






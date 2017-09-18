#####################################
########## HACK*R*THON ##############
#####################################
### Geospatial MAC*RM TUTORIAL  #####
#####################################
### Adam Gold                     ###
### Bayesian Statistician         ###
### Global Environment & Modeling ###
### December 8, 2015              ###
### Adam.M.Gold@monsanto.com      ###
#####################################
### CODE OBJECTIVES               ###
### (1) Read Macroenvironment     ###
###     and RM Shape Files        ###
### (2) Plot Macroenvironments    ###
###     and RM Zones              ###
### (3) Interactive Maps          ###
### (4) Find MAC and RM given     ###
###     US coordinates            ###
#####################################


#Load the following packages.  
install.packages("googleVis") #Example install package code
library(sp)
library(rgdal)
library(maps)
library(ggplot2)
library(plotGoogleMaps)
library(prevR)
library(googleVis)
library(XML)
library(gridExtra)

#Select helpful packages include {graphics,maptools,grDevices,mapproj}

##################################
## PLOTS MACROENVRIONMENTS IN R ##
##################################

#macrmfp is the filepath where the shape files are located. 
#remember to use "/", instead of "\"
macrmfp="//FINCH/nacornbreed/Environment_Modeling/Public/Adam/HackRthon/"

# Piece of Mike G's code to list files in directory
list.files(macrmfp)
data.frame(list.files(macrmfp))

#Helpful code to detect if the file actually exists
file.exists(paste(macrmfp,"Macroenvironments/Macroenvironments.shp",sep=""))

#readOGR reads shape files.
#Macroenvironment Shape file has a layer called "Macroenvironments
MACs<-readOGR(
  dsn=paste(macrmfp,"Macroenvironments/Macroenvironments.shp",sep=""), #fp containing shape file
  layer="Macroenvironments") #layer name

#Print the dataset for the shape file.
MACs@data

#Print the first five rows of the data from the shape file.
head(MACs@data,n=5)
MACs@data[1:5,]

#Removes white margins when plotting; use full graphing window
par(mar=c(0,0,0,0))

#Map the world, with a focus on the eastern, midwest USA
map("world",col=1,xlim=c(-105, -67), ylim = c(25,55))

#Plot Macroenvironments, using colors in the shape file dataset
plot(MACs,add=TRUE,col=rgb(MACs@data$Red,MACs@data$Green,MACs@data$Blue))

#Find the centroid of each MAC, plot Labels
centroids<-getSpPPolygonsLabptSlots(MACs)
Labels<-text(x=centroids[,1],y=centroids[,2],labels=MACs@data$MAC_rev,cex=.7)

#Macroenvironment Interactive Maps with labels
ma<-plotGoogleMaps(MACs, #Spatial polygon data frame
                  zcol="MAC_rev",  #LABELS
                  iconMarker=iconlabels(as.character(MACs@data$MAC_rev)), #Colors for the legend
                  colPalette=rgb(MACs@data$Red,MACs@data$Green,MACs@data$Blue),  #Colors for Macroenvironments
                  filename='MACs.html', #Name of File ouptut
                  mapTypeId= 'TERRAIN', #{HYBRID, ROADMAP, SATELLITE, TERRAIN}
                  fitBounds=T #Maps to full window
                  ) 


#Example: Grab dimensions of MAC 9.1, 11th polygon
MACs@polygons[[11]]
slot(slot(MACs,"polygons")[[11]],"Polygons")[[1]]@coords
### 11th listed Macroenvironment's first polygon.  
### MAC 3 Polygon (5th Polygon) has 10 subpolygons (including holes)
length(slot(slot(MACs,"polygons")[[5]],"Polygons"))


##################################
#### PLOTS CORN RM ZONES IN R ####
##################################

#RM COLOR DEFINITIONS
RMcol<-read.csv(paste(macrmfp,"RM/RM Layer Desc.csv",sep=""));RMcol[,2:4]<-RMcol[,2:4]/255
RMcol;

#Reads RM KML File (May take some time; 2720 counties)
RMs<-readOGR(dsn=paste(macrmfp,"RM/RM.kml",sep=""),layer="US_CNTY_RM_PlantingDate")

#Extracts RM by county
RMZones<-data.frame(as.character(RMs@data$Name))
RMZones<-cbind(RMZones,unlist(gregexpr("RM_CORN_GD",RMs@data$Description)))
RMZones<-cbind(RMZones,substr(RMs@data$Description,RMZones[,2]+20,RMZones[,2]+22))
RMZones[,3]<-as.character(RMZones[,3])
for(i in 1:nrow(RMZones)){
  if(substr(as.character(RMZones[i,3]),3,3)=="<"){RMZones[i,3]<-substr(RMZones[i,3],1,2)}
}
RMZones[,3]<-as.numeric(RMZones[,3])
colnames(RMZones)<-c("County","RMStringPos","RM")
head(RMZones)

RMZones2<-merge(x=RMZones,y=RMcol,by.x="RM",by.y="RM")
head(RMZones2)


#Maps eastern/midwest US
map("world",col=1,xlim=c(-105, -67), ylim = c(25,55))

for(i in 1:(nrow(RMZones))){
  rmno<-match(RMZones[i,3],RMcol[,1])
  polygon(unlist(slot(slot(RMs,"polygons")[[i]],"Polygons"))[[1]]@coords,border=NA,col=rgb(RMcol[rmno,2],RMcol[rmno,3],RMcol[rmno,4]))
}

#Adds borders for Macroenvironments
plot(MACs,add=TRUE,border=1,col=rgb(1,1,1,alpha=0))

###################################
#### INTERACTIVE MAC*RM LAYER #####
###################################

#LOAD MAC*RM layer
MACRMs<-readOGR(dsn=paste(macrmfp,"MACxRM/MAC_by_RM_v2.shp",sep=""),layer="MAC_by_RM_v2")

#MAC RM dataframe embedded in shape file
head(MACRMs@data)
RMid<-data.frame(MACRMs@data$RM_CORN_GD)

#What are the RMs?
unique(RMid)

#How many Macroenvironments are in each RM?
data.frame(table(RMid))


#Plot RMs in Google Maps with Macroenvironment borders
MapRM<-plotGoogleMaps(MACRMs,
                      zcol="RM_CORN_GD",
                      legend=FALSE,
                      strokeOpacity = 1
)

MapRM2<-plotGoogleMaps(MACRMs[MACRMs@data$RM_CORN_GD>0,],
                      zcol="RM_CORN_GD",
                      legend=FALSE,
                      strokeOpacity = 0
)


#############
# Find MAC * RM given coordinates
#############

#Locations entered in Velocity as of Dec 7th 2015
sitesum<-read.csv(paste(macrmfp,"CornBreedingVelLocs2015.12.07.csv",sep=""),stringsAsFactor=FALSE)
head(sitesum)
str(sitesum)
points(sitesum[,c("LongCenter","LatCenter")],pch=20,cex=0.8)

#Create 2 column data table (MAC, RM)
macrmmatched<-data.frame(matrix(0,nrow=nrow(sitesum),ncol=2))

i=1
sitesum[i,]
#Code for finding macroenvironment
for(i in 1:nrow(macrmmatched)){  #for each location, ...
  macmatched<-data.frame(matrix(0,nrow=length(MACs),ncol=1)) #Create an empty indicator for the MAC polygons
  for(j in 1:length(MACs)){  #for each Macroenvironment, ...
    macmatched[j,1]<-point.in.SpatialPolygons(  #Test if the point is in the Macroenvironment
      point.x=sitesum[i,"LongCenter"],
      point.y=sitesum[i,"LatCenter"],
      SpP=MACs[j,]
    )  
  }
  if(sum(macmatched)==1){ #if the point was in a macroenvironment
    macrmmatched[i,1]<-as.character(MACs@data$MAC_rev[which(macmatched[,1]==1)])   #Find the associated MAC using indicator
  }
}


#?point.inSpatialPolygon

#Find RM
for(i in 1:nrow(macrmmatched)){  #For each location
  matchrm<-data.frame(matrix(0,nrow=length(RMs),ncol=1)) #Create an empty indicator for each candidate RM polygon
  for(j in 1:length(RMs)){
    matchrm[j,1]<-point.in.polygon(
      point.x=sitesum[i,"LongCenter"],
      point.y=sitesum[i,"LatCenter"],
      pol.x=unlist(slot(slot(RMs,"polygons")[[j]],"Polygons"))[[1]]@coords[,1],
      pol.y=unlist(slot(slot(RMs,"polygons")[[j]],"Polygons"))[[1]]@coords[,2]
      )
  }
  if(sum(matchrm)==1){macrmmatched[i,2]<-as.character(RMZones[which(matchrm[,1]==1),3])}
}

#Rename column names for MAC RM
colnames(macrmmatched)<-c("MAC","RM")

#Add columns to the end of location dataset
sitesum<-cbind(sitesum,macrmmatched)

head(sitesum)

#Write dataset
write.csv(sitesum,paste(macrmfp,"Velocity Corn Locs with MACs and RMs.csv",sep=""))




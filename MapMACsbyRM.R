library(ggplot2)
library(maptools)
library(rgdal)
library(graphics)
library(maps)
library(grDevices)
library(mapproj)
library(sp)
library(automap)
library(geoR)
library(shapefiles)
library(ggplot2)
library(maptools)
library(rgdal)
library(graphics)
library(maps)
library(grDevices)
library(mapproj)
library(sp)
library(SDMTools)
library(gridExtra)
library(base)
library(grDevices)


##### PLOTS MACROENVRIONMENTS IN R
macrmfp="C:/Users/AMGOLD/Documents/Location Coordinates/MAC by ZoneRM/For Adam/"
file.exists(paste(macrmfp,"US_RM_MAC2_WGS84.kmz",sep=""))
MACRMs<-readOGR(dsn=paste(macrmfp,"doc.kml",sep=""),layer="US_RM_MAC2_WGS84")
macrmkml <- getKMLcoordinates(kmlfile=paste(macrmfp,"doc.kml",sep=""), ignoreAltitude=T)

map("world",col=1,xlim=c(-105, -67), ylim = c(25,55))
for(i in 1:length(macrmkml)){polygon(x=macrmkml[[i]][,1],y=macrmkml[[i]][,2])}

i=268;map("state",col=1,xlim=c(min(macrmkml[[i]][,1])-5,max(macrmkml[[i]][,1])+5), ylim = c(min(macrmkml[[i]][,2])-5,max(macrmkml[[i]][,2])+5));map("state",col=1,add=TRUE);polygon(x=macrmkml[[i]][,1],y=macrmkml[[i]][,2],col="red");macrmkml[[i]];

#### SET YOUR FILEPATH BELOW:
macfp="C:/Users/AMGOLD/Documents/Location Coordinates/Read MACs into R/"

MACs<-readOGR(dsn=paste(macfp,"MAC.kml",sep=""),layer="NA_MAC_20150401")
tkml <- getKMLcoordinates(kmlfile=paste(macfp,"MAC.kml",sep=""), ignoreAltitude=T)
maclayer<-read.csv(paste(macfp,"MAC Layer Desc.csv",sep=""))
macrgb<-maclayer[,4:6]/255

macmatched<-data.frame(matrix(0,nrow=length(macrmkml),ncol=2))

for(i in 1:length(macrmkml)){
matchmac<-data.frame(matrix(0,nrow=length(tkml),ncol=1))
for(j in 1:length(tkml)){
matchmac[j,1]<-point.in.polygon(point.x=mean(macrmkml[[i]][,1]),point.y=mean(macrmkml[[i]][,2]),pol.x=tkml[[j]][,1],pol.y=tkml[[j]][,2])
}
if(sum(matchmac)==1){macmatched[i,1]<-as.character(maclayer[which(matchmac[,1]==1),2])}
}
write.csv(macmatched,paste(macrmfp,"MACassigned.csv",sep=""))

macseq<-which(macmatched[,1]==0)

for(k in 1:length(macseq)){print(paste(macseq[k],mean(macrmkml[[macseq[k]]][,1]),mean(macrmkml[[macseq[k]]][,2])))}


rmfp="C:/Users/AMGOLD/Documents/Location Coordinates/RM into R/"
RMcol<-read.csv(paste(rmfp,"RM Layer Desc.csv",sep=""));RMcol[,2:4]<-RMcol[,2:4]/255
RMs<-readOGR(dsn=paste(rmfp,"RM.kml",sep=""),layer="US_CNTY_RM_PlantingDate")

RMZones<-data.frame(as.character(RMs@data$Name))
RMZones<-cbind(RMZones,unlist(gregexpr("RM_CORN_GD",RMs@data$Description)))
RMZones<-cbind(RMZones,substr(RMs@data$Description,RMZones[,2]+20,RMZones[,2]+22))
RMZones[,3]<-as.character(RMZones[,3])
for(i in 1:nrow(RMZones)){
  if(substr(as.character(RMZones[i,3]),3,3)=="<"){RMZones[i,3]<-substr(RMZones[i,3],1,2)}
}
RMZones[,3]<-as.numeric(RMZones[,3])
colnames(RMZones)<-c("County","RMStringPos","RM")

map("world",col=1,xlim=c(-105, -67), ylim = c(25,55))
for(i in 1:nrow(RMZones)){
  rmno<-match(RMZones[i,3],RMcol[,1])
  polygon(unlist(slot(slot(RMs,"polygons")[[i]],"Polygons"))[[1]]@coords,border=NA,col=rgb(RMcol[rmno,2],RMcol[rmno,3],RMcol[rmno,4]))
}
min(macrmkml[[i]][,1])-1,max(macrmkml[[i]][,1])+1)


i=1
for(i in 1:length(macrmkml)){
matchrm<-data.frame(matrix(0,nrow=length(RMs),ncol=1))
for(j in 1:length(RMs)){
matchrm[j,1]<-point.in.polygon(point.x=mean(macrmkml[[i]][,1]),point.y=mean(macrmkml[[i]][,2]),pol.x=unlist(slot(slot(RMs,"polygons")[[j]],"Polygons"))[[1]]@coords[,1],pol.y=unlist(slot(slot(RMs,"polygons")[[j]],"Polygons"))[[1]]@coords[,2])
}
if(sum(matchrm)==1){macmatched[i,2]<-as.character(RMZones[which(matchrm[,1]==1),3])}
}
write.csv(macmatched,paste(macrmfp,"MACassigned.csv",sep=""))

sum(macmatched[,2]==0)




sum(matchrm)




macrmshp<-readShapeSpatial(paste(macrmfp,"MAC_by_RM.shp",sep=""))
str(macrmshp)
length(macrmshp)
macrmshp[[1]]
ds
i=1
unlist(slot(slot(macrmshp,"polygons")[[i]],"Polygons"))[[1]]@coords

map("world",col=1,xlim=c(-105, -67), ylim = c(25,55))
plot(1,xlim=c(-105, -67), ylim = c(25,55))
for(i in 1:nrow(macrmshp)){
  polygon(unlist(slot(slot(macrmshp,"polygons")[[i]],"Polygons"))[[1]]@coords/113000,border=1)
}

#### SET YOUR FILEPATH BELOW:
macfp="C:/Users/AMGOLD/Documents/Location Coordinates/Read MACs into R/"

MACs<-readOGR(dsn=paste(macfp,"MAC.kml",sep=""),layer="NA_MAC_20150401")
tkml <- getKMLcoordinates(kmlfile=paste(macfp,"MAC.kml",sep=""), ignoreAltitude=T)
maclayer<-read.csv(paste(macfp,"MAC Layer Desc.csv",sep=""))
macrgb<-maclayer[,4:6]/255
map("world",col=1,xlim=c(-105, -67), ylim = c(25,55))
for(i in 1:length(tkml)){polygon(x=tkml[[i]][,1],y=tkml[[i]][,2],col=rgb(macrgb[i,1],macrgb[i,2],macrgb[i,3]))}
map("state",col=1,add=TRUE)








map("usa",xlim=c(-110, -85), ylim = c(35,50),project="albers",par=c(39,45))
P4S.latlon<-CRS("+proj=longlat +datum=WGS84")

polygon(x=tkml[[i]][,1],y=tkml[[i]][,2],col=rgb(macrgb[i,1],macrgb[i,2],macrgb[i,3]))

proj4string(maytemp) =  "+proj=longlat +datum=WGS84" 


pcm4<-read.csv("C:/Users/AMGOLD/Documents/Location Optimization/Data Management v5 USA/PCM4_CAT_2015 (July 20 2015)/01_2015 PCM4 TechDev Site Summary with Macs(RemovedSetRM).txt")
pcm4.1<-pcm4[pcm4$TYPE=="Research",]
dim(pcm4.1)
head(pcm4)
str(pcm4)

map("world",col=1,xlim=c(-105, -67), ylim = c(25,55))
for(i in 1:length(tkml)){polygon(x=tkml[[i]][,1],y=tkml[[i]][,2],col=rgb(macrgb[i,1],macrgb[i,2],macrgb[i,3]))}
map("state",col=1,add=TRUE)
points(x=pcm4.1$POINT_1_LONG_NBR,y=pcm4.1$POINT_1_LAT_NBR,pch=19)


pcm4.15<-read.csv("C:/Users/AMGOLD/Documents/Location Optimization/Data Management v5 USA/PCM4_CAT_2015 (July 20 2015)/2015 v 2014/loc.fld.yr.txt")
head(pcm4.15)

map("world",col=1,xlim=c(-105, -67), ylim = c(25,55))
for(i in 1:length(tkml)){polygon(x=tkml[[i]][,1],y=tkml[[i]][,2],col=rgb(macrgb[i,1],macrgb[i,2],macrgb[i,3]))}
map("state",col=1,add=TRUE)
pcm4.15.1<-pcm4.15[pcm4.15$N.2014.==0,]
pcm4.15.2<-pcm4.15[pcm4.15$N.2015.==0,]
pcm4.15.3<-pcm4.15[!(pcm4.15$N.2014.==0)&!(pcm4.15$N.2015.==0),]
points(x=pcm4.15.1$POINT_1_LONG_NBR,y=pcm4.15.1$POINT_1_LAT_NBR,pch=19,col="black")
points(x=pcm4.15.2$POINT_1_LONG_NBR,y=pcm4.15.2$POINT_1_LAT_NBR,pch=19,col="black")
points(x=pcm4.15.3$POINT_1_LONG_NBR,y=pcm4.15.3$POINT_1_LAT_NBR,pch=19,col="black")
#points(x=pcm4.15.2$POINT_1_LONG_NBR,y=pcm4.15.2$POINT_1_LAT_NBR,pch=19,col="red")
#points(x=pcm4.15.3$POINT_1_LONG_NBR,y=pcm4.15.3$POINT_1_LAT_NBR,pch=19,col="black")

head(pcm4.15.3)
nrow(pcm4.15.3)
legend("topright",c("2015 and 2014","2015 only","2014 only"),
       pch=c(19,19,19),
       col=c("black","blue","red"))
legend("top","Both 2014 and 2015 PCM4 Loc*Field")
sum


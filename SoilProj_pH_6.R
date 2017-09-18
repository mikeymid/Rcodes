
#--------Precise Code
#Proj1: Soil Nutrient Distribution within Field
#4-6-17


soil_data <-"//finch/nacornbreed/Environment_Modeling/Public/Ross/BreedingSoilSampleData/"
nv3<-read.csv(paste(soil_data,"2014-2016-locations-samples-nonveris-3.csv",sep=""),stringsAsFactor=FALSE)

#-------

site_name = "MNPX"
#need to find a way to provide selection for variables as well

install.packages("dplyr")
require(dplyr)

ReqRows <- filter(nv3, fieldId == site_name)
ReqCol <- select(ReqRows, sampleId, ph, longitude, latitude)
FieldData <- ReqCol

dim(FieldData)
head(FieldData)
View(FieldData)
summary(FieldData)
hist(FieldData$ph)

#-------

install.packages("shape")
require(shape)
#need to scale and automate everything based on the variable of interest and corresponding valrange

emptyplot(main = "pH Color Gradients")

colorlegend(posx = c(0.25, 0.28), 
            col = intpalette(c("darkred", "orangered2","orangered1","orangered","orange2","orange1","orange"), 100),
            zlim = c(5, 6), 
            zval = c(5.0, 5.2, 5.4, 5.6, 5.8, 6.0),
            digit=1)
colorlegend(posx = c(0.45, 0.48), 
            col = intpalette(c("mediumblue","skyblue","turquoise1"), 100), 
            zlim = c(6, 7), 
            zval = c(6.0, 6.2, 6.4, 6.6, 6.8, 7.0),
            digit=1)
colorlegend(posx = c(0.65, 0.68), 
            col = intpalette(c("green3","forestgreen","darkgreen"), 100), 
            zlim = c(7, 8), 
            zval = c(7.0, 7.2, 7.4, 7.6, 7.8, 8.0),
            digit=1)

#----------

install.packages("grDevices")
require("grDevices")

c0Pal<-colorRampPalette(intpalette(c("darkred", "orangered2","orangered1","orangered","orange2","orange1","orange"), 100))
c1Pal<-colorRampPalette(intpalette(c("mediumblue","skyblue","turquoise1"), 100))
c2Pal<-colorRampPalette(intpalette(c("green3","forestgreen","darkgreen"), 100))

FDc0<-FieldData[FieldData$ph<6 & FieldData$ph>=5,]
FDc1<-FieldData[FieldData$ph<7 & FieldData$ph>=6,]
FDc2<-FieldData[FieldData$ph<8 & FieldData$ph>=7,]


totrow <- nrow(FDc0)+nrow(FDc1)+nrow(FDc2)+nrow(FDc3)+nrow(FDc4)

colsoil0<-c0Pal(totrow)[as.numeric(cut(FDc0$ph,breaks=totrow))]
colsoila<-c1Pal(totrow)[as.numeric(cut(FDc1$ph,breaks=totrow))]
colsoilb<-c2Pal(totrow)[as.numeric(cut(FDc2$ph,breaks=totrow))]

FDc0<-cbind(FDc0,colsoil0)
FDc1<-cbind(FDc1,colsoila)
FDc2<-cbind(FDc2,colsoilb)

colnames(FDc0)[ncol(FDc0)]<-"colsoil"
colnames(FDc1)[ncol(FDc1)]<-"colsoil"
colnames(FDc2)[ncol(FDc2)]<-"colsoil"

FD <-rbind(FDc0, FDc1, FDc2)
FD <-cbind(FD,t(col2rgb(FD$colsoil)/255))

#---------

head(FD)
dim(FD)

FDsf<-FD

install.packages("sp")
require(sp)

coordinates(FDsf)<-c("longitude","latitude")

xmin<-FDsf@bbox[1,1]-.1*(FDsf@bbox[1,2]-FDsf@bbox[1,1])
xmax<-FDsf@bbox[1,2]+.1*(FDsf@bbox[1,2]-FDsf@bbox[1,1])
ymin<-FDsf@bbox[2,1]-.1*(FDsf@bbox[2,2]-FDsf@bbox[2,1])
ymax<-FDsf@bbox[2,2]+.1*(FDsf@bbox[2,2]-FDsf@bbox[2,1])

install.packages("maps")
require(maps)

map("world",col="#ffffff",fill=TRUE,bg="white",lwd=0.05,xlim=c(xmin,xmax), ylim = c(ymin,ymax));
map("usa",col="#f2f2f2",fill=TRUE,bg="white",lwd=0.05,add=TRUE);
map("state",add=TRUE)

points(FDsf,pch=15,cex=3.52,col=rgb(FDsf@data$red,FDsf@data$green,FDsf@data$blue))

#---------

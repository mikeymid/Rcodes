
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

colorlegend(posx = c(0.05, 0.08), 
            col = intpalette(c("darksalmon","firebrick1","firebrick3","darkred"), 100),
            zlim = c(5, 5.5), 
            zval = c(5.0, 5.1, 5.2, 5.3, 5.4, 5.5),
            digit=1)
colorlegend(posx = c(0.25, 0.28), 
            col = intpalette(c("darkred", "orangered2","orangered1","orangered","orange2","orange1","orange"), 100), 
            zlim = c(5.5, 6), 
            zval = c(5.5, 5.6, 5.7, 5.8 ,5.9, 6.0),
            digit=1)
colorlegend(posx = c(0.45, 0.48), 
            col = intpalette(c("orange","yellow3","yellow2","yellow"), 100), 
            zlim = c(6, 6.5), 
            zval = c(6.0, 6.1, 6.2, 6.3, 6.4, 6.5),
            digit=1)
colorlegend(posx = c(0.65, 0.68), 
            col = intpalette(c("yellow", "green3","forestgreen","darkgreen"), 100), 
            zlim = c(6.5, 7), 
            zval = c(6.5, 6.6, 6.7, 6.8, 6.9, 7),
            digit=1)
colorlegend(posx = c(0.85, 0.88), 
            col = intpalette(c("darkgreen", "turquoise1","skyblue","mediumblue"), 100), 
            zlim = c(7, 7.5), 
            zval = c(7.0, 7.1, 7.2, 7.3, 7.4, 7.5),
            digit=1)

#----------

install.packages("grDevices")
require("grDevices")

c0Pal<-colorRampPalette(intpalette(c("darksalmon","firebrick1","firebrick3","darkred"), 100))
c1Pal<-colorRampPalette(intpalette(c("darkred", "orangered2","orangered1","orangered","orange2","orange1","orange"), 100))
c2Pal<-colorRampPalette(intpalette(c("orange","yellow3","yellow2","yellow"), 100))
c3Pal<-colorRampPalette(intpalette(c("yellow", "green3","forestgreen","darkgreen"), 100))
c4Pal<-colorRampPalette(intpalette(c("darkgreen", "turquoise1","skyblue","mediumblue"), 100))

FDc0<-FieldData[FieldData$ph<5.5 & FieldData$ph>=5,]
FDc1<-FieldData[FieldData$ph<6 & FieldData$ph>=5.5,]
FDc2<-FieldData[FieldData$ph<6.5 & FieldData$ph>=6,]
FDc3<-FieldData[FieldData$ph<7 & FieldData$ph>=6.5,]
FDc4<-FieldData[FieldData$ph<7.5 & FieldData$ph>=7,]

totrow <- nrow(FDc0)+nrow(FDc1)+nrow(FDc2)+nrow(FDc3)+nrow(FDc4)

colsoil0<-c0Pal(totrow)[as.numeric(cut(FDc0$ph,breaks=totrow))]
colsoila<-c1Pal(totrow)[as.numeric(cut(FDc1$ph,breaks=totrow))]
colsoilb<-c2Pal(totrow)[as.numeric(cut(FDc2$ph,breaks=totrow))]
colsoilc<-c3Pal(totrow)[as.numeric(cut(FDc3$ph,breaks=totrow))]
colsoild<-c4Pal(totrow)[as.numeric(cut(FDc4$ph,breaks=totrow))]

FDc0<-cbind(FDc0,colsoil0)
FDc1<-cbind(FDc1,colsoila)
FDc2<-cbind(FDc2,colsoilb)
FDc3<-cbind(FDc3,colsoilc)
FDc4<-cbind(FDc4,colsoild)

colnames(FDc0)[ncol(FDc0)]<-"colsoil"
colnames(FDc1)[ncol(FDc1)]<-"colsoil"
colnames(FDc2)[ncol(FDc2)]<-"colsoil"
colnames(FDc3)[ncol(FDc3)]<-"colsoil"
colnames(FDc4)[ncol(FDc4)]<-"colsoil"

FD <-rbind(FDc0, FDc1, FDc2, FDc3, FDc4)
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

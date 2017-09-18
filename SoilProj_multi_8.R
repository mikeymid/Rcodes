
#--------Precise Code
#Proj1: Soil Nutrient Distribution within Field
#4-6-17


soil_data <-"//finch/nacornbreed/Environment_Modeling/Public/Ross/BreedingSoilSampleData/"
nv3<-read.csv(paste(soil_data,"2014-2016-locations-samples-nonveris-3.csv",sep=""),stringsAsFactor=FALSE)

#-------

site_name = "MNPX"


install.packages("dplyr")
require(dplyr)

ReqRows <- filter(nv3, fieldId == site_name)
ReqCol <- select(ReqRows, sampleId, ph, cec, fe, cu, mg, b, k, mn, p, s, organicMatter, slope, curve, clay, sand, silt, omRatio, ecRatio, soil_texture_class, longitude, latitude)
FieldData <- ReqCol

dim(FieldData)
head(FieldData)
View(FieldData)
summary(FieldData)


#-------


l1 <- min(FieldData[,which(colnames(FieldData)==var)])
l2 <- as.numeric(quantile(FieldData[,which(colnames(FieldData)==var)], .25)) 
l3 <- median(FieldData[,which(colnames(FieldData)==var)])
l4 <- as.numeric(quantile(FieldData[,which(colnames(FieldData)==var)], .75)) 
l5 <- max(FieldData[,which(colnames(FieldData)==var)])



var <- "cec"

max(FieldData[,which(colnames(FieldData)==var)])

hist(FieldData[,which(colnames(FieldData)==var)])
summary(FieldData[,which(colnames(FieldData)==var)])

#test1 <- FieldData;coordinates(test1)<-c("longitude","latitude");
#to make sure no missing data for lat-longs

#-------

install.packages("shape")
require(shape)


emptyplot(main = "pH Color Gradients")

colorlegend(posx = c(0.20, 0.23), 
            col = intpalette(c("darkred","firebrick3", "darksalmon","orange2","orange1","orange", "yellow", "yellow2"), 100),
            zlim = c(l1, l2), 
            zval = c(l1, l2-0.2*(l2-l1),l2-0.4*(l2-l1), l2-0.6*(l2-l1), l2-0.8*(l2-l1), l2),
            digit=1)
colorlegend(posx = c(0.32, 0.35), 
            col = intpalette(c("mediumblue","skyblue","turquoise1"), 100), 
            zlim = c(l2, l3), 
            zval = c(l2, l2+0.2*(l3-l2), l2+0.4*(l3-l2), l2+0.6*(l3-l2), l2+0.8*(l3-l2), l3),
            digit=1)
colorlegend(posx = c(0.47, 0.50), 
            col = intpalette(c("midnightblue","mediumpurple4","mediumorchid4","magenta4","magenta3","magenta","maroon2","maroon1"), 100), 
            zlim = c(l3, l4), 
            zval = c(l3, l3+0.2*(l4-l3), l3+0.4*(l4-l3), l3+0.6*(l4-l3), l3+0.8*(l4-l3), l4),
            digit=1)
colorlegend(posx = c(0.80, 0.83), 
            col = intpalette(c("green3","forestgreen","darkgreen"), 100),
            zlim = c(l4, l5), 
            zval = c(l4, l4+0.2*(l5-l4), l4+0.4*(l5-l4), l4+0.6*(l5-l4), l4+0.8*(l5-l4), l5),
            digit=1)


#----------

install.packages("grDevices")
require("grDevices")

c0Pal<-colorRampPalette(intpalette(c("darkred","firebrick3","firebrick1","darksalmon"), 100))
c1Pal<-colorRampPalette(intpalette(c("yellow", "yellow2","orange2","orange1","orange"), 100))
c2Pal<-colorRampPalette(intpalette(c("mediumblue","skyblue","turquoise1"), 100))
c3Pal<-colorRampPalette(intpalette(c("midnightblue","mediumpurple4","mediumorchid4","magenta4","magenta3","magenta","maroon2","maroon1"), 100))
c4Pal<-colorRampPalette(intpalette(c("green3","forestgreen","darkgreen"), 100))


FDc0<-FieldData[FieldData[,which(colnames(FieldData)==var)]<l2 & FieldData[,which(colnames(FieldData)==var)]>=l1,]
FDc1<-FieldData[FieldData[,which(colnames(FieldData)==var)]<l3 & FieldData[,which(colnames(FieldData)==var)]>=l2,]
FDc2<-FieldData[FieldData[,which(colnames(FieldData)==var)]<l4 & FieldData[,which(colnames(FieldData)==var)]>=l3,]
FDc3<-FieldData[FieldData[,which(colnames(FieldData)==var)]<l5 & FieldData[,which(colnames(FieldData)==var)]>=l4,]
FDc4<-FieldData[FieldData[,which(colnames(FieldData)==var)]<=l6 & FieldData[,which(colnames(FieldData)==var)]>=l5,]

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

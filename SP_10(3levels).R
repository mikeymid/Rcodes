
#--------3 levels: Low, Moderate and High
#Proj1: Soil Nutrient Distribution within Field
#4-9-17


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


l1 <- 0
l2 <- 5
l3 <- 6
l4 <- 8


var <- "ph"


hist(FieldData[,which(colnames(FieldData)==var)], main = "Histogram of the Selected Variable")
summary(FieldData[,which(colnames(FieldData)==var)])

#-------

install.packages("shape")
require(shape)


emptyplot(main = "Color Gradients")

colorlegend(posx = c(0.27, 0.32), 
            col = intpalette(c("firebrick4", "firebrick3", "firebrick1", "indianred", "indianred2", "tomato2", "tomato1", "darkorange2", "darkorange1"), 100),
            zlim = c(l1, l2), 
            zval = c(l1, l2-0.2*(l2-l1),l2-0.4*(l2-l1), l2-0.6*(l2-l1), l2-0.8*(l2-l1), l2),
            #digit=1,
            main = "Low")
colorlegend(posx = c(0.47, 0.52), 
            col = intpalette(c("darkorange1", "darkorange", "orange2", "orange1", "orange", "goldenrod2", "gold2", "gold1", "gold", "yellow2", "yellow1", "yellow", "yellowgreen"), 100), 
            zlim = c(l2, l3), 
            zval = c(l2, l2+0.2*(l3-l2), l2+0.4*(l3-l2), l2+0.6*(l3-l2), l2+0.8*(l3-l2), l3),
            digit=1,
            main = "Moderate")
colorlegend(posx = c(0.67, 0.72), 
            col = intpalette(c("yellowgreen", "green", "green1", "green2", "forestgreen", "darkturquoise", "dodgerblue2", "dodgerblue3", "darkorchid3", "deeppink"), 100), 
            zlim = c(l3, l4), 
            zval = c(l3, l3+0.2*(l4-l3), l3+0.4*(l4-l3), l3+0.6*(l4-l3), l3+0.8*(l4-l3), l4),
            #digit=1,
            main = "High")


#----------

install.packages("grDevices")
require("grDevices")

c0Pal<-colorRampPalette(intpalette(c("firebrick4", "firebrick3", "firebrick1", "indianred", "indianred2", "tomato2", "tomato1", "darkorange2", "darkorange1"), 100))
c1Pal<-colorRampPalette(intpalette(c("darkorange1", "darkorange", "orange2", "orange1", "orange", "goldenrod2", "gold2", "gold1", "gold", "yellow2", "yellow1", "yellow", "yellowgreen"), 100))
c2Pal<-colorRampPalette(intpalette(c("yellowgreen", "green", "green1", "green2", "forestgreen", "darkturquoise", "dodgerblue2", "dodgerblue3", "darkorchid3", "deeppink"), 100))


FDc0<-FieldData[FieldData[,which(colnames(FieldData)==var)]<l2 & FieldData[,which(colnames(FieldData)==var)]>=l1,]
FDc1<-FieldData[FieldData[,which(colnames(FieldData)==var)]<l3 & FieldData[,which(colnames(FieldData)==var)]>=l2,]
FDc2<-FieldData[FieldData[,which(colnames(FieldData)==var)]<l4 & FieldData[,which(colnames(FieldData)==var)]>=l3,]

totrow <- nrow(FDc0)+nrow(FDc1)+nrow(FDc2)


colsoil0<-c0Pal(totrow)[as.numeric(cut(FDc0[,which(colnames(FieldData)==var)],breaks=totrow))]
colsoila<-c1Pal(totrow)[as.numeric(cut(FDc1[,which(colnames(FieldData)==var)],breaks=totrow))]
colsoilb<-c2Pal(totrow)[as.numeric(cut(FDc2[,which(colnames(FieldData)==var)],breaks=totrow))]


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

points(FDsf,pch=15,cex=3.5,col=rgb(FDsf@data$red,FDsf@data$green,FDsf@data$blue))

#---------

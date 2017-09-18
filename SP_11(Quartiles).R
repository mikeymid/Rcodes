
#--------1st, 2nd, 3rd, 4rt Quartile & 5th and 95th Percentile
#Proj1: Soil Nutrient Distribution within Field
#4-10-17



install.packages("maps")
install.packages("dplyr")
install.packages("shape")
install.packages("grDevices")
install.packages("sp")

require(maps)
require(dplyr)
require(shape)
require("grDevices")
require(sp)


soil_data <-"//finch/nacornbreed/Environment_Modeling/Public/Ross/BreedingSoilSampleData/"
if(!exists("nv3")){nv3<-read.csv(paste(soil_data,"2014-2016-locations-samples-nonveris-3.csv",sep=""),stringsAsFactor=FALSE)}

#-------

site_name <- "MNPX"
var <- "organicMatter"


ReqRows <- filter(nv3, fieldId == site_name)
ReqCol <- select(ReqRows, sampleId, ph, cec, fe, cu, mg, b, k, mn, p, s, organicMatter, slope, curve, clay, sand, silt, omRatio, ecRatio, soil_texture_class, longitude, latitude)
FieldData <- ReqCol

getwd()
write.csv(FieldData, file = "MNPX_SOM.csv")


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
l05 <- as.numeric(quantile(FieldData[,which(colnames(FieldData)==var)], .05)) 
l95 <- as.numeric(quantile(FieldData[,which(colnames(FieldData)==var)], .95)) 


hist(FieldData[,which(colnames(FieldData)==var)], main = paste("Histogram of", var), xlab = var)
summary(FieldData[,which(colnames(FieldData)==var)])


#-------


#layout(matrix(c(1, 2, 1, 2), 2, 2, byrow = TRUE), widths = c(1, 2), heights = c(1,3))
par(mfrow=c(1, 2))
#useful link: http://www.statmethods.net/advgraphs/layout.html

emptyplot(main = paste(var, "Color Gradients"))

colorlegend(posx = c(0.17, 0.20), 
            col = intpalette(c("firebrick4", "firebrick3", "firebrick1", "indianred", "indianred2", "tomato2", "tomato1", "darkorange2", "darkorange1"), 100),
            zlim = c(l1, l2), 
            zval = c(l1, l05, l2),
            digit=1, main="1st Quartile")
colorlegend(posx = c(0.37, 0.40), 
            col = intpalette(c("darkorange1", "darkorange", "orange2", "orange1", "orange", "goldenrod2", "gold2", "gold1", "gold", "yellow2", "yellow1", "yellow", "yellowgreen"), 100), 
            zlim = c(l2, l3), 
            zval = c(l2, l3),
            digit=1, main = "2nd Quartile")
colorlegend(posx = c(0.57, 0.60), 
            col = intpalette(c("yellowgreen", "green", "green1", "green2", "forestgreen", "darkturquoise"), 100), 
            zlim = c(l3, l4), 
            zval = c(l3, l4),
            digit=1, main = "3rd Quartile")
colorlegend(posx = c(0.77, 0.80), 
            col = intpalette(c("darkturquoise", "dodgerblue2", "dodgerblue3", "darkorchid3", "deeppink"), 100),
            zlim = c(l4, l5), 
            zval = c(l4, l95, l5),
            digit=1, main = "4th Quartile")


#----------


c0Pal<-colorRampPalette(intpalette(c("firebrick4", "firebrick3", "firebrick1", "indianred", "indianred2", "tomato2", "tomato1", "darkorange2", "darkorange1"), 100))
c1Pal<-colorRampPalette(intpalette(c("darkorange1", "darkorange", "orange2", "orange1", "orange", "goldenrod2", "gold2", "gold1", "gold", "yellow2", "yellow1", "yellow", "yellowgreen"), 100))
c2Pal<-colorRampPalette(intpalette(c("yellowgreen", "green", "green1", "green2", "forestgreen", "darkturquoise"), 100))
c3Pal<-colorRampPalette(intpalette(c("darkturquoise", "dodgerblue2", "dodgerblue3", "darkorchid3", "deeppink"), 100))


FDc0<-FieldData[FieldData[,which(colnames(FieldData)==var)]<l2 & FieldData[,which(colnames(FieldData)==var)]>=l1,]
FDc1<-FieldData[FieldData[,which(colnames(FieldData)==var)]<l3 & FieldData[,which(colnames(FieldData)==var)]>=l2,]
FDc2<-FieldData[FieldData[,which(colnames(FieldData)==var)]<l4 & FieldData[,which(colnames(FieldData)==var)]>=l3,]
FDc3<-FieldData[FieldData[,which(colnames(FieldData)==var)]<=l5 & FieldData[,which(colnames(FieldData)==var)]>=l4,]

totrow <- nrow(FDc0)+nrow(FDc1)+nrow(FDc2)+nrow(FDc3)

colsoil0<-c0Pal(totrow)[as.numeric(cut(FDc0[,which(colnames(FieldData)==var)],breaks=totrow))]
colsoila<-c1Pal(totrow)[as.numeric(cut(FDc1[,which(colnames(FieldData)==var)],breaks=totrow))]
colsoilb<-c2Pal(totrow)[as.numeric(cut(FDc2[,which(colnames(FieldData)==var)],breaks=totrow))]
colsoilc<-c3Pal(totrow)[as.numeric(cut(FDc3[,which(colnames(FieldData)==var)],breaks=totrow))]


FDc0<-cbind(FDc0,colsoil0)
FDc1<-cbind(FDc1,colsoila)
FDc2<-cbind(FDc2,colsoilb)
FDc3<-cbind(FDc3,colsoilc)

colnames(FDc0)[ncol(FDc0)]<-"colsoil"
colnames(FDc1)[ncol(FDc1)]<-"colsoil"
colnames(FDc2)[ncol(FDc2)]<-"colsoil"
colnames(FDc3)[ncol(FDc3)]<-"colsoil"

FD <-rbind(FDc0, FDc1, FDc2, FDc3)
FD <-cbind(FD,t(col2rgb(FD$colsoil)/255))


#---------


head(FD)
dim(FD)

FDsf<-FD

coordinates(FDsf)<-c("longitude","latitude")

xmin<-FDsf@bbox[1,1]-.1*(FDsf@bbox[1,2]-FDsf@bbox[1,1])
xmax<-FDsf@bbox[1,2]+.1*(FDsf@bbox[1,2]-FDsf@bbox[1,1])
ymin<-FDsf@bbox[2,1]-.1*(FDsf@bbox[2,2]-FDsf@bbox[2,1])
ymax<-FDsf@bbox[2,2]+.1*(FDsf@bbox[2,2]-FDsf@bbox[2,1])

map("world",col="#ffffff",fill=TRUE,bg="white",lwd=0.05,xlim=c(xmin,xmax), ylim = c(ymin,ymax));
map("usa",col="#f2f2f2",fill=TRUE,bg="white",lwd=0.05,add=TRUE);
map("state",add=TRUE)

points(FDsf,pch=15,cex=2.3,col=rgb(FDsf@data$red,FDsf@data$green,FDsf@data$blue))


#---------


#usefullink: https://www.datacamp.com/community/tutorials/15-questions-about-r-plots#gs.OyEq=OE





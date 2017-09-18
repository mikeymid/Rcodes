

#Project 1
#Understanding the Soil Nutrient Distribution at Field-Level



#-------------

#Step 1: Getting the data (.csv file) into R and plot in U.S. Map



rossfp<-"//finch/nacornbreed/Environment_Modeling/Public/Ross/BreedingSoilSampleData/"
nv3<-read.csv(paste(rossfp,"2014-2016-locations-samples-nonveris-3.csv",sep=""),stringsAsFactor=FALSE)

#nv3 : non-veris file number 3

head(nv3);dim(nv3);
nv3

#map-making

install.packages("maps")
library(maps)

install.packages("sp")
library(sp)


map("world",col="#ffffff",fill=FALSE,bg="black",lwd=0.05,xlim=c(-110, -67), ylim = c(25,50));
#you need maps package here
#lwd is the line width

#alternative-way
#map("usa")
#map("world",add=TRUE)

#you can also add/use county level maps
#map("county", region = "Minnesota")

coordinates(nv3) <-c("longitude","latitude")
#coordinates function comes from sp package

plot(nv3,add=TRUE,col="blue", pch = 19, cex = 0.7)
#just to make it fancier - have a different plot inside
#plot(nv3,add=TRUE,col="blue", pch = 19, cex = 1.5)
#plot(nv3,add=TRUE,col="yellow", pch = 19, cex = 0.5)
dim(nv3)

#if you get the rror plot size small - just drag the "plot" window in R
#if you get figure margin too large - use "par" function or just restart



#------------

#Step 2 Select the "field of interest" and create the "bounding-box" using latlong



install.packages("dplyr")
require(dplyr)

#Selecting the required Rows
ReqRows <- filter(nv3, fieldId == "MNPX")
dim(ReqRows)


#Selecting the required columns
ReqCol <- select(ReqRows, sampleId, ph, longitude, latitude)
dim(ReqCol)

#you might get some erro here telling "spatial" data stuffs
#just assign the csv to nv3 again and redo these steps

#Assigning it to a variable
FieldData <- ReqCol

coordinates(FieldData) <-c("longitude","latitude")
#just to be on the safe side
#Understanding data - basic stats

View(FieldData)

#basic stats and finding min-max of latlongs
summary(FieldData)



#---------------------

#Step 3: Automate the process of creating the Bounding box for zooming in and out @FieldData



str(FieldData)
#str() will elicit contents of a defined variable, dataframe, or matrix

head(FieldData@coords);dim(FieldData@coords)
#Here, we observe a spatial data frame

#we need the four coordinates from the bounding box
FieldData@bbox[1,1]
FieldData@bbox[1,2]
FieldData@bbox[2,1]
FieldData@bbox[2,2]

#Defining the coordinates/variables for creating the function

xmin <- FieldData@bbox[1,1]-0.10*(FieldData@bbox[1,2]-FieldData@bbox[1,1])
xmax <- FieldData@bbox[1,2]+0.10*(FieldData@bbox[1,2]-FieldData@bbox[1,1])
ymin <- FieldData@bbox[2,1]-0.10*(FieldData@bbox[2,2]-FieldData@bbox[2,1])
ymax <- FieldData@bbox[2,2]+0.10*(FieldData@bbox[2,2]-FieldData@bbox[2,1])

#create buffers so that you will get a better picture of the field data
#zoom in and zoom out accordingly by changing the % buffer

#Time to plot the field map
map("world",col="#ffffff",fill=FALSE,bg="white",lwd=0.05,xlim=c(xmin, xmax), ylim = c(ymin, ymax));

#Add the field sample data points
plot(FieldData,add=TRUE,col="red", pch = 19, cex = 0.7)

#if you use ggplot2 - use as.data.frame(coordinates(FieldData)) for convertign spatial objects

#---------------


#Step 4: Statistical Rampage !!!!

#Plotting the field points 
#Size based on the pH values

install.packages("ggplot2")
require(ggplot2)


fieldplot <- ggplot(data = FieldData) + geom_point(mapping = aes(x = longitude, y = latitude, size = ph, color = ph))
#this might give error as we had converted the value to spatial format initially
#try running the step 1 codes again or use the as.data.frame function to convert

fieldplot + scale_color_gradient(low="red", high="blue")

#more fancy color gradients
#fieldplot + scale_color_gradientn(colours = rainbow(3))

head(FieldData)
hist(FieldData$ph)
summary(FieldData$ph)

#How much % data belongs to certain categories?
sum(FieldData$ph<5.5)/length(FieldData$ph)
sum(FieldData$ph>6.5)/length(FieldData$ph)


#helpful links
#colors and gradients - http://www.sthda.com/english/wiki/ggplot2-colors-how-to-change-colors-automatically-and-manually
#ggplot - http://r4ds.had.co.nz/data-visualisation.html


----------------------------#Legends & other cool gradients @Adam

  
install.packages("shape")
require(shape)
#shape package documentation: https://www.rdocumentation.org/packages/shape/versions/1.4.2

emptyplot(main = "Color Gradients Example")
#emptyplot	open a plot without axes, labels,...

colorlegend(posx = c(0.15, 0.18), 
            col = heat.colors(20), 
            zlim = c(0, 5), 
            zval = c(0, 5),
            cex=1.0, #size relative to original
            main="pH < 5")

colorlegend(posx = c(0.35, 0.38), 
            col = intpalette(c("yellow4","yellow3","yellow2","yellow", "blue"), 100), 
            zlim = c(5, 6), 
            zval = c(5, 5.1, 5.2, 5.3, 5.4, 5.5, 5.6, 5.7, 5.8 ,5.9),
            digit=1,
            main="5-6 pH Range")


colorlegend(posx = c(0.55, 0.58), 
            col = intpalette(c("mediumblue","skyblue","turquoise1"), 100), 
            zlim = c(6, 7), 
            zval = c(6, 6.1, 6.2, 6.3, 6.4, 6.5, 6.6, 6.7, 6.8, 6.9),
            digit=1, #to have decimal
            main="6-7 pH Range")
#decimals like 5.25 may not work in displays - it will be rounded to 4 if we are not using the "digit" 

colorlegend(posx = c(0.75, 0.78), 
            col = intpalette(c("midnightblue","mediumpurple4","mediumorchid4","magenta4","magenta3","magenta","maroon2","maroon1"), 100), 
            zlim = c(7, 14), 
            zval = c(7, 14),
            digit=1, #to have decimal
            #you can change "inset" too
            main="pH > 7")

-------------#change colours so that they are continuous

#Define color gradients

install.packages("grDevices")
require("grDevices")

#library(help = "grDevices") will give you the documentation for the package
#?colorRampPalette
#colorRamp: interpolate a set of colors to create new color palettes (like topo.colors)

c0Pal<-colorRampPalette(heat.colors(20))
c1Pal<-colorRamp(intpalette(c("yellow4","yellow3","yellow2","yellow", "blue"), 100))
c2Pal<-colorRampPalette(intpalette(c("mediumblue","skyblue","turquoise1"), 100))
c3Pal<-colorRampPalette(intpalette(c("midnightblue","mediumpurple4","mediumorchid4","magenta4","magenta3","magenta","maroon2","maroon1"), 100))

#Subsetting depending on the variable value

hist(FieldData$ph)

FDc0<-FieldData[which(FieldData$ph<5),] #FD: FieldData
FDc1<-FieldData[FieldData$ph<6 & FieldData$ph>=5,]
FDc2<-FieldData[FieldData$ph<7 & FieldData$ph>=6,]
FDc3<-FieldData[FieldData$ph>=7,]

#enumerate 
nrow(FDc0)
nrow(FDc1)
nrow(FDc2)
nrow(FDc3)


totrow <- nrow(FDc0)+nrow(FDc1)+nrow(FDc2)+nrow(FDc3)


#Cutting the gradients into pieces=n(rows)?
colsoil0<-c0Pal(totrow)[as.numeric(cut(FDc0$ph,breaks=totrow))]
#might give you an error as the subset is empty: "'from' must be finite"
colsoila<-c1Pal(totrow)[as.numeric(cut(FDc1$ph,breaks=totrow))]
colsoilb<-c2Pal(totrow)[as.numeric(cut(FDc2$ph,breaks=totrow))]
colsoilc<-c3Pal(totrow)[as.numeric(cut(FDc3$ph,breaks=totrow))]


#validation:dim(FDc3)
#dim(colsoilc)

######## Error in data.frame(..., check.names = FALSE) : arguments imply differing number of rows: 190, 252
#above section make sure you use specific FD-$ph instead of FieldData

#adding a column - i.e., assigned gradient
FDc0<-cbind(FDc0,colsoil0)
#might give you an error as the subset is empty
FDc1<-cbind(FDc1,colsoila)
FDc2<-cbind(FDc2,colsoilb)
FDc3<-cbind(FDc3,colsoilc)

#Alternative way
#defining an empty df and adding only subsets that have values
FD<-c()
#tot up the rows
if(nrow(FDc0)>0){FD<-rbind(FD,FDc0)}
if(nrow(FDc1)>0){FD<-rbind(FD,FDc1)}
if(nrow(FDc2)>0){FD<-rbind(FD,FDc2)}
if(nrow(FDc3)>0){FD<-rbind(FD,FDc3)}
head(FD);dim(FD);


###Have common names for column to bind the data frame
colnames(FDc0)[ncol(FDc0)]<-"colsoil"
colnames(FDc1)[ncol(FDc1)]<-"colsoil"
colnames(FDc2)[ncol(FDc2)]<-"colsoil"
colnames(FDc3)[ncol(FDc3)]<-"colsoil"


FD <-cbind(FD,t(col2rgb(FD$colsoil)/255))
#255 shades?

head(FD)
dim(FD)


FDsf<-FD
#FieldData in Spatial Format

coordinates(FDsf)<-c("longitude","latitude")
#sp package

#----- just trying a condition
str(FDsf)
hist(FDsf@data$ph)
FDsf@data[which(FDsf@data$ph>6),]
sum(FDsf@data$ph>6)/nrow(FDsf@data)
#------

xmin<-FDsf@bbox[1,1]-.1*(FDsf@bbox[1,2]-FDsf@bbox[1,1])
xmax<-FDsf@bbox[1,2]+.1*(FDsf@bbox[1,2]-FDsf@bbox[1,1])
ymin<-FDsf@bbox[2,1]-.1*(FDsf@bbox[2,2]-FDsf@bbox[2,1])
ymax<-FDsf@bbox[2,2]+.1*(FDsf@bbox[2,2]-FDsf@bbox[2,1])

map("world",col="#ffffff",fill=TRUE,bg="white",lwd=0.05,xlim=c(xmin,xmax), ylim = c(ymin,ymax));
map("usa",col="#f2f2f2",fill=TRUE,bg="white",lwd=0.05,add=TRUE);
map("state",add=TRUE)
#maps package

#plot the points
points(FDsf,pch=15,cex=3.52,col=rgb(FDsf@data$red,FDsf@data$green,FDsf@data$blue))


map("world",col="#ffffff",fill=TRUE,bg="white",lwd=0.05,xlim=c(xmin,xmax), ylim = c(ymin,ymax));
map("usa",col="#f2f2f2",fill=TRUE,bg="white",lwd=0.05,add=TRUE);
map("state",add=TRUE)
#maps package

#plot the points
FDsf6<-FDsf[which(FDsf@data$ph>6),]
points(FDsf6,pch=15,cex=0.8,col=rgb(FDsf6@data$red,FDsf6@data$green,FDsf6@data$blue))
head(FDsf6@data)




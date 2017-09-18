
##### CREATE COLOR GRADIENTS
#Visualize the Color Gradient Legend using SHAPE package 



install.packages("shape")
library(shape)
#shape package documentation: https://www.rdocumentation.org/packages/shape/versions/1.4.2


emptyplot(main = "Color Gradients Example")
#emptyplot	open a plot without axes, labels,...


colorlegend(posx = c(0.03,0.06), 
            col = intpalette(c("black","azure4"), 100), 
            zlim = c(0, 10000), zval = c(0,2500,5000,7500,10000),main="<10k",digit=0)

#colorlegend	adds a color legend to a plot
#format: intpalette(inputcol, numcol = length(x.to), x.from = NULL, x.to = NULL)
#posx: relative position of left and right edge of color bar on first axis, [0,1]
#zlim: two-valued vector, the minimum and maximum z values
#zval: a vector of z-values to label legend.

colorlegend(posx = c(0.15, 0.18), 
            col = intpalette(c("darkred","firebrick3","firebrick1","darksalmon"), 100), 
            #decimals like 4.25 may not work in displays (zval)
            #it will be rounded to 4 if we are not using the digit function i.e.,
            #digit = 1
            #cex = 1, size relative to the original
            zlim = c(10000, 30000), zval = c(10000,15000,20000,25000,50000),main="10-30k")

colorlegend(posx = c(0.27, 0.30), 
            col = intpalette(c("orangered2","orangered1","orangered","orange2","orange1","orange"), 100), 
            zlim = c(30000,50000), zval = c(30000,35000,40000,45000,50000),main="30-50k")

colorlegend(posx = c(0.39, 0.42), 
            col = intpalette(c("midnightblue","mediumpurple4","mediumorchid4","magenta4","magenta3","magenta","maroon2","maroon1"), 100), 
            zlim = c(50000,75000), zval = c(50000,55000,60000,65000,70000,75000),main="50-75k")

colorlegend(posx = c(0.51, 0.54), 
            col = intpalette(c("yellow4","yellow3","yellow2","yellow"), 100), 
            zlim = c(75000,100000), zval = c(75000,80000,85000,90000,95000,100000),main="75-100k")

colorlegend(posx = c(0.63, 0.66), 
            col = intpalette(c("mediumblue","skyblue","turquoise1"), 100), 
            zlim = c(100000,150000), zval = c(100000,110000,120000,130000,140000,150000),main="100-150k")

colorlegend(posx = c(0.75, 0.78), 
            col = intpalette(c("darkgreen","forestgreen","green3"), 100), 
            zlim = c(150000,250000), zval = c(150000,175000,200000,225000,250000),main="150-250k")

colorlegend(posx = c(0.87, 0.9), 
            col = intpalette(c("springgreen4","springgreen3","springgreen2","springgreen1","springgreen","green","lawngreen"), 100), 
            zlim = c(250000,1500000), zval = c(250000,500000,750000,1000000,1250000,1500000),main="250k+")

install.packages("grDevices")
require("grDevices")

#library(help = "grDevices") will give you the documentation for the package
#?colorRampPalette
#colorRamp: interpolate a set of colors to create new color palettes (like topo.colors)

#Define the color gradients
c0Pal<-colorRampPalette(intpalette(c("black","azure4"), 100))
c1Pal<-colorRampPalette(intpalette(c("darkred","firebrick3","firebrick1","darksalmon"), 100))
c2Pal<-colorRampPalette(intpalette(c("orangered2","orangered1","orangered","orange2","orange1","orange"), 100))
c3Pal<-colorRampPalette(intpalette(c("midnightblue","mediumpurple4","mediumorchid4","magenta4","magenta3","magenta","maroon2","maroon1"), 100))
c4Pal<-colorRampPalette(intpalette(c("yellow4","yellow3","yellow2","yellow"), 100))
c5Pal<-colorRampPalette(intpalette(c("mediumblue","skyblue","turquoise1"), 100))
c6Pal<-colorRampPalette(intpalette(c("darkgreen","green3","green"), 100))
c7Pal<-colorRampPalette(intpalette(c("springgreen4","springgreen3","springgreen2","springgreen1","springgreen","green","lawngreen"), 100))

#Simulate 10,000 random points
rlong<-runif(10000,-95,-90)
rlat<-runif(10000,35,41)

#Simulate random values between 0 and 1,500,000.
rdata<-runif(10000,0,1500000)

#Visualize random data
hist(rdata)

#Create data frame
swcol<-data.frame(cbind(rlong,rlat,rdata))
head(swcol);dim(swcol);
colnames(swcol);
str(swcol);

##Subsetting depending on the variable value
swcol20<-swcol[which(swcol$rdata<10000),]
swcol2a<-swcol[swcol$rdata<30000&swcol$rdata>=10000,]
swcol2b<-swcol[swcol$rdata<50000&swcol$rdata>=30000,]
swcol2c<-swcol[swcol$rdata<75000&swcol$rdata>=50000,]
swcol2d<-swcol[swcol$rdata<100000&swcol$rdata>=75000,]
swcol2e<-swcol[swcol$rdata<150000&swcol$rdata>=100000,]
swcol2f<-swcol[swcol$rdata<250000&swcol$rdata>=150000,]
swcol2g<-swcol[swcol$rdata>=250000,]
nrow(swcol20)
nrow(swcol2a)
nrow(swcol2b)
nrow(swcol2c)
nrow(swcol2d)
nrow(swcol2e)
nrow(swcol2f)
nrow(swcol2g)

nrow(swcol20)+nrow(swcol2a)+nrow(swcol2b)+nrow(swcol2c)+nrow(swcol2d)+nrow(swcol2e)+nrow(swcol2f)+nrow(swcol2g)

#dim(swcol2f)

#Cutting the gradients into pieces=n(rows)
colsoil0<-c0Pal(10000)[as.numeric(cut(swcol20$rdata,breaks=10000))]
colsoila<-c1Pal(10000)[as.numeric(cut(swcol2a$rdata,breaks=10000))]
colsoilb<-c2Pal(10000)[as.numeric(cut(swcol2b$rdata,breaks=10000))]
colsoilc<-c3Pal(10000)[as.numeric(cut(swcol2c$rdata,breaks=10000))]
colsoild<-c4Pal(10000)[as.numeric(cut(swcol2d$rdata,breaks=10000))]
colsoile<-c5Pal(10000)[as.numeric(cut(swcol2e$rdata,breaks=10000))]
colsoilf<-c6Pal(10000)[as.numeric(cut(swcol2f$rdata,breaks=10000))]
colsoilg<-c7Pal(10000)[as.numeric(cut(swcol2g$rdata,breaks=10000))]
#you can change breaks and c-pal to anything depending on how you wwant to cut

#adding a column - i.e., assigned gradient
swcol20<-cbind(swcol20,colsoil0)
swcol2a<-cbind(swcol2a,colsoila)
swcol2b<-cbind(swcol2b,colsoilb)
swcol2c<-cbind(swcol2c,colsoilc)
swcol2d<-cbind(swcol2d,colsoild)
swcol2e<-cbind(swcol2e,colsoile)
swcol2f<-cbind(swcol2f,colsoilf)
swcol2g<-cbind(swcol2g,colsoilg)

#dim(swcol2f)
#head(swcol2f)
#colnames(swcol2f)

###Have common names for column to bind the data frame
colnames(swcol20)[ncol(swcol20)]<-"colsoil"
colnames(swcol2a)[ncol(swcol2a)]<-"colsoil"
colnames(swcol2b)[ncol(swcol2b)]<-"colsoil"
colnames(swcol2c)[ncol(swcol2c)]<-"colsoil"
colnames(swcol2d)[ncol(swcol2d)]<-"colsoil"
colnames(swcol2e)[ncol(swcol2e)]<-"colsoil"
colnames(swcol2f)[ncol(swcol2f)]<-"colsoil"
colnames(swcol2g)[ncol(swcol2g)]<-"colsoil"

swcol2<-rbind(swcol2g,swcol2f,swcol2e,swcol2d,swcol2c,swcol2b,swcol2a,swcol20)
swcol2<-cbind(swcol2,t(col2rgb(swcol2$colsoil)/255))
#why 255 here? - 255 shades?

head(swcol2);dim(swcol2);

swcol3<-swcol2
#Spatial Format

#install.packages("sp")
#require(sp)
coordinates(swcol3)<-c("rlong","rlat")

str(swcol3)

#bounding box buffer
xmin<-swcol3@bbox[1,1]-.1*(swcol3@bbox[1,2]-swcol3@bbox[1,1])
xmax<-swcol3@bbox[1,2]+.1*(swcol3@bbox[1,2]-swcol3@bbox[1,1])
ymin<-swcol3@bbox[2,1]-.1*(swcol3@bbox[2,2]-swcol3@bbox[2,1])
ymax<-swcol3@bbox[2,2]-.1*(swcol3@bbox[2,2]-swcol3@bbox[2,1])

#install.packages("maps")
#require(maps)
map("world",col="#ffffff",fill=TRUE,bg="white",lwd=0.05,xlim=c(xmin,xmax), ylim = c(ymin,ymax));
map("usa",col="#f2f2f2",fill=TRUE,bg="white",lwd=0.05,add=TRUE);
map("state",add=TRUE)

#plot the points
points(swcol3,pch=15,cex=0.8,col=swcol3$colsoil)



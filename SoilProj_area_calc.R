

#------------RandomExample @Adam


# " simulate 12 points in Iowa.  I plot the points and the polygon of a simulated field.  I report the acres"

npts<-12
pts<-cbind(-93.754+runif(npts)*(-93.748+93.754),41.961+runif(npts)*(41.965-41.961))
pts<-pts[chull(pts),]
#just to get the order of coordinates right
plot(pts)
polygon(pts)
geosphere::areaPolygon(pts)/4046.8564224


#----------Soil Data in Hand


soil_data <-"//finch/nacornbreed/Environment_Modeling/Public/Ross/BreedingSoilSampleData/"
if(!exists("nv3")){nv3<-read.csv(paste(soil_data,"2014-2016-locations-samples-nonveris-3.csv",sep=""),stringsAsFactor=FALSE)}


site_name <- "MNPX"
var <- "organicMatter"


ReqRows <- filter(nv3, fieldId == site_name)
ReqCol <- select(ReqRows, sampleId, ph, cec, fe, cu, mg, b, k, mn, p, s, organicMatter, slope, curve, clay, sand, silt, omRatio, ecRatio, soil_texture_class, longitude, latitude)
FieldData <- ReqCol

FDsf<-FieldData

coordinates(FDsf)<-c("longitude","latitude")

xmin<-FDsf@bbox[1,1]-.1*(FDsf@bbox[1,2]-FDsf@bbox[1,1])
xmax<-FDsf@bbox[1,2]+.1*(FDsf@bbox[1,2]-FDsf@bbox[1,1])
ymin<-FDsf@bbox[2,1]-.1*(FDsf@bbox[2,2]-FDsf@bbox[2,1])
ymax<-FDsf@bbox[2,2]+.1*(FDsf@bbox[2,2]-FDsf@bbox[2,1])


#---------Area calc.


#defining the coordinates
pt1<-cbind(xmin, ymin)
pt2<-cbind(xmin, ymax)
pt3<-cbind(xmax, ymax)
pt4<-cbind(xmax, ymin)

pts<-rbind(pt1, pt2, pt3, pt4)

pts<-pts[chull(pts),]
#creating the c hull
plot(pts)
polygon(pts)
#creates polygon from the coordiante points

geosphere::areaPolygon(pts)/4046.8564224
#reporting area in acres


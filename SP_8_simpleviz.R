

soil_data <-"//finch/nacornbreed/Environment_Modeling/Public/Ross/BreedingSoilSampleData/"
nv3<-read.csv(paste(soil_data,"2014-2016-locations-samples-nonveris-3.csv",sep=""),stringsAsFactor=FALSE)

site_name = "MNPX"

ReqRows <- filter(nv3, fieldId == site_name)
ReqCol <- select(ReqRows, sampleId, ph, cec, fe, cu, mg, b, k, mn, p, s, organicMatter, slope, curve, clay, sand, silt, omRatio, ecRatio, soil_texture_class, longitude, latitude)
FieldData <- ReqCol

fieldplot <- ggplot(data = FieldData) + geom_point(mapping = aes(x = longitude, y = latitude, size = organicMatter, color = ph))

fieldplot + scale_color_gradient(low="red", high="blue")
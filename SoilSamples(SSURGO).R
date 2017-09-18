### LIST ALL R PACKAGES REQURIED
rpack<-c("alphahull","automap","base","devtools","dplyr","gdata","geoR","geosphere","ggmap","ggplot2","graphics","grDevices","gridExtra","gtools","httr","mapproj","maps","maptools","openxlsx","plotKML","prevR","psych","raster","RCurl","reshape2","rgdal","rgeos","rjson","rLiDAR","SDMTools","shape","shapefiles","soiltexture","sp","stringr","utils","xlsx","XML")
rpack<-unique(rpack);
rpack<-rpack[order(rpack)]
length(rpack);

### CALL ALL PACKAGES REQUIRED
lapply(rpack,require,character.only=TRUE)
paste(rpack[which(unlist(lapply(rpack,require,character.only=TRUE))==FALSE)]," failed to Load",sep="")

#### Where I want to save the raw data
#vsoilfp<-"//FINCH/nacornbreed/Environment_Modeling/Private/Velocity Soil API/"

#' Get a Ping token, which can be used to authenticate what needs to be done
#' @param client_id: a client id pre-registered with the authentication server
#' @param client_secret: the client secret associated with the client_id
#' @param prod_environment: a boolean value that indicates whether to call the prod endpoint or not.
#'     Default to False, so the endpoint for non-prod will be used
#' @return the response from this call

get_token <- function(client_id, client_secret, prod_environment=TRUE){
  url <- "https://test.amp.monsanto.com/as/token.oauth2"
  if (prod_environment) {url <- "https://amp.monsanto.com/as/token.oauth2"}
    payload <- list(
    grant_type = "client_credentials",
    client_id = client_id,
    client_secret = client_secret
  )
    req <- POST(url,
              add_headers("Content-Type" = "application/x-www-form-urlencoded"),
              body = payload,
              encode = "form"
  )
  return(req)
}

#' Get CFR Sites data - All sites in Json format
#' @param access_token: access token retrieved from PingID. e.g. 'Bearer secretaccesskeyToken'
#' @param prod_environment: a boolean value that indicates whether to call the prod endpoint or not.
#'     Default to False, so the endpoint for non-prod will be used
#' @return the response from this call

get_soil_data <- function(access_token, prod_environment=TRUE){
  url <- "https://api.monsanto.com:443/soilsamples/v2/published-imports?datefilter=2013-09-01"
  if (prod_environment) {
    url <- "https://api.monsanto.com:443/soilsamples/v2/published-imports?datefilter=2013-09-01"
  }
  req <- GET(url,verbose = TRUE,config(followlocation = FALSE,ssl_verifypeer=FALSE),
             add_headers(
               "Content-Type" = "application/json",
               "Authorization" = access_token
             )
  )
  return(req)
}

client_id <- "BREEDING-IT-ADAM-GOLD-CLIENT-SVC"
client_secret <- "xHjZe4MehkaQc2ZfjyY7PwUEGHSu15UQbsq3xaBSRsOC8NhY5d"
response <- get_token(client_id, client_secret)
content <- content(response);content
token <- paste(content$token_type, content$access_token, sep=" ")
response <- get_soil_data(token)
str(response)
responser<-as.character(response)
nchar(responser)
responser2<-  fromJSON(responser)

responser2$features[[1]]
responser2$features[[2]]
length(responser2$features)

summary<-data.frame();
length(responser2$features)
rawsoilsum<-c()
j<-1000
for(j in 1:length(responser2$features)){
#for(j in sample(length(responser2$features),10)){

Sys.sleep(0.1)
print(j)
typej<-responser2$features[j][[1]]$type[[1]]
polyj<-responser2$features[j][[1]]$geometry$type[[1]]
rowsj<-responser2$features[j][[1]]$properties$importRowsCount[[1]]
userj<-responser2$features[j][[1]]$properties$userId[[1]]
publj<-as.character(as.POSIXct(as.numeric(substr(as.character(responser2$features[j][[1]]$properties$publishDate),1,10)),origin = "1970-01-01",tmz="GMT"))
updaj<-as.character(as.POSIXct(as.numeric(substr(as.character(responser2$features[j][[1]]$properties$updatedDate),1,10)),origin = "1970-01-01",tmz="GMT"))
namej<-responser2$features[j][[1]]$properties$importFileName[[1]]

summaryi<-cbind(j,typej,polyj,rowsj,userj,publj,updaj,namej)
remove(typej,polyj,rowsj,userj,publj,updaj,namej)

coorddf<-data.frame(matrix(unlist(responser2$features[j][[1]]$geometry$coordinates[[1]]),ncol=2,byrow=T))
polysoil<-paste("POLYGON((",paste(paste(coorddf[,1],"%20",coorddf[,2],sep=""),collapse=","),"))",sep="");print(polysoil)
#writeClipboard(polysoil)
urlsoil<-paste("https://api.monsanto.com:443/soilsamples/v2/wkt/POLYGON((",paste(paste(coorddf[,1],"%20",coorddf[,2],sep=""),collapse=","),"))",sep="");print(urlsoil);
#writeClipboard(urlsoil)

if(min(length(unique(coorddf[,1])),length(unique(coorddf[,2])))==1){
  centrP<-data.frame(t(c( mean(coorddf[,1]), mean(coorddf[,2]))));
  areaP<-0;
#  cntryP<-map.where(database="world", mean(coorddf[,1]), mean(coorddf[,2]));
}
if(min(length(unique(coorddf[,1])),length(unique(coorddf[,2])))>1){
  centrP<-data.frame(t(c( mean(coorddf[,1]), mean(coorddf[,2]))));
  areaP<-geosphere::areaPolygon(coorddf)/4046.8564224;
#  cntryP<-map.where(database="world", centroid(coorddf)[1], centroid(coorddf)[2]);
}
colnames(centrP)<-c("LongCenter","LatCenter")
summaryi<-cbind(summaryi,centrP[1,],areaP,polysoil)
#summaryi<-cbind(summaryi,centroid(coorddf),geosphere::areaPolygon(coorddf)/4046.8564224,map.where(database="world", centroid(coorddf)[1], centroid(coorddf)[2]),polysoil)

get_soil_data2 <- function(access_token, prod_environment=TRUE){
  url <- urlsoil
  if (prod_environment) {
    url <- urlsoil
  }
  
  req <- GET(url,verbose = TRUE,config(followlocation = FALSE,ssl_verifypeer=FALSE),
             add_headers(
               "Content-Type" = "application/json",
               "Authorization" = access_token
             )
  )
  return(req)
}

response <- get_token(client_id, client_secret)
content <- content(response);content
# example token: "Bearer EhD0oVpPSmL6KDem0N4gaBwtmgwA"
token <- paste(content$token_type, content$access_token, sep=" ")
responsesoil <- get_soil_data2(token)
responsesoil2<-fromJSON(as.character(responsesoil))
substr(responsesoil,1,1000)
responsesoil2[[2]]

soilfactors<-data.frame(colnames(t(data.frame(unlist(responsesoil2[1])))))
if(prod(dim(soilfactors))>0){
soilfactors<-t(as.character(soilfactors[,1]))

colnames(soilfactors)<-as.character(soilfactors[1,])


summaryi<-cbind(summaryi,soilfactors)

class(coorddf)
coorddf1<-data.frame(matrix(c(
-97.78857707977295,
42.05537905854437,
-97.78857707977295,
42.04655196602637,
-97.72952556610107,
42.04655196602637,
-97.72952556610107,
42.05537905854437,
-97.78857707977295,
42.05537905854437),ncol=2,byrow=TRUE))

coorddf

urlssurgo<-"https://api01.agro.services:443/loc360/api/ssurgo/shape/wkt/POLYGON((-97.78857707977295%2042.05537905854437%2C-97.78857707977295%2042.04655196602637%2C-97.72952556610107%2042.04655196602637%2C-97.72952556610107%2042.05537905854437%2C-97.78857707977295%2042.05537905854437))"

urlssurgo<-paste("https://api01.agro.services:443/loc360/api/ssurgo/shape/wkt/POLYGON((",
                 paste(paste(format(round(coorddf1[,1],14),nsmall=14),"%20",format(round(coorddf1[,2],14),nsmall=14),sep=""),collapse="%2C"),
                 "))",sep="");

get_ssurgo_data <- function(access_token, prod_environment=TRUE){
  url <- urlssurgo
  if (prod_environment) {
    url <- urlssurgo
  }
  req <- GET(url,verbose = TRUE,config(followlocation = FALSE,ssl_verifypeer=FALSE),
             add_headers(
               "Content-Type" = "application/json",
               "Authorization" = access_token
             )
  )
  return(req)
}

response <- get_token(client_id, client_secret)
content <- content(response);content
# example token: "Bearer EhD0oVpPSmL6KDem0N4gaBwtmgwA"
token <- paste(content$token_type, content$access_token, sep=" ")
responsessurgo <- get_ssurgo_data(token)
responsessurgo2<-fromJSON(rawToChar(responsessurgo$content))

length(responsessurgo2[[2]])  #Number of SSURGO Polygons intersecting chull
responsessurgo2[[1]][1] #example for first ssurgo polygon, mapping unit
responsessurgo2[[2]][1] #example for first ssurgo polygon, attributes
responsessurgo2[[1]][length(responsessurgo2[[2]])] #example for last ssurgo polygon, mapping unit
responsessurgo2[[2]][length(responsessurgo2[[2]])] #example for last ssurgo polygon, attributes
}

responsessurgo2[[2]][1]$de8fcf2da8aacc73a298260bb3ff5b76488961b4$mapUnit
responsessurgo2[[2]][1]$de8fcf2da8aacc73a298260bb3ff5b76488961b4$component


summary<-smartbind(data.frame(summary),data.frame(summaryi))
}

summary<-summary[-1,]
rownames(summary)<-summary$j
#head(summary);dim(summary)

write.csv(summary, "soilsamples.csv")
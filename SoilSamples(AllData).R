### LIST ALL R PACKAGES REQURIED
rpack<-c("alphahull","automap","base","devtools","dplyr","gdata","geoR","geosphere","ggmap","ggplot2","graphics","grDevices","gridExtra","gtools","httr","mapproj","maps","maptools","openxlsx","plotKML","prevR","psych","raster","RCurl","reshape2","rgdal","rgeos","rjson","rLiDAR","SDMTools","shape","shapefiles","soiltexture","sp","stringr","utils","xlsx","XML")
rpack<-unique(rpack);
rpack<-rpack[order(rpack)]
length(rpack);

### CALL ALL PACKAGES REQUIRED
lapply(rpack,require,character.only=TRUE)
paste(rpack[which(unlist(lapply(rpack,require,character.only=TRUE))==FALSE)]," failed to Load",sep="")

### API CREDENTIALS FOR AMGOLD
client_id <- "BREEDING-IT-ADAM-GOLD-CLIENT-SVC"
client_secret <- "xHjZe4MehkaQc2ZfjyY7PwUEGHSu15UQbsq3xaBSRsOC8NhY5d"

### Set Default digits for precise coordinates
options(digits=14)

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

### Get Soil Sample Summary data

get_soil_data <- function(access_token, prod_environment=TRUE){
  url <- "https://api.monsanto.com:443/soilsamples/v2/published-imports?format=bbox&fromdate=2013-09-01"
  if (prod_environment) {
    url <- "https://api.monsanto.com:443/soilsamples/v2/published-imports?format=bbox&fromdate=2013-09-01"
  }
  req <- GET(url,verbose = TRUE,config(followlocation = FALSE,ssl_verifypeer=FALSE),
             add_headers(
               "Content-Type" = "application/json",
               "Accept" = "application/json",
               "Authorization" = access_token
            )
         )
  return(req)
}

get_soil_rowkey <- function(access_token, urlsoilkey, userid, prod_environment=TRUE){
  url <- urlsoilkey
  if (prod_environment) {
    url <- urlsoilkey
  }
  req <- GET(urlsoilkey,verbose = TRUE,config(followlocation = FALSE,ssl_verifypeer=FALSE),
             add_headers(
               "Content-Type" = "application/json",
               "Authorization" = access_token,
               "MonUserId" = userid
             )
  )
  return(req)
}

response <- get_token(client_id, client_secret)
content <- content(response);content
token <- paste(content$token_type, content$access_token, sep=" ")
response <- get_soil_data(token)
responser<-as.character(response)
responser2<-fromJSON(responser)

j<-1
summary<-data.frame()
for(j in (nrow(summary)+1):length(responser2)){

Sys.sleep(0.01);
print(j);
  
summaryj<-data.frame(t(unlist(responser2[j])))
if("importDate"%in%colnames(summaryj)){summaryj$importDate<-as.POSIXct(as.numeric(substr(as.character(summaryj$importDate),1,10)),origin = "1970-01-01",tmz="GMT")}
if("updatedDate"%in%colnames(summaryj)){summaryj$updatedDate<-as.POSIXct(as.numeric(substr(as.character(summaryj$updatedDate),1,10)),origin = "1970-01-01",tmz="GMT")}

urlsoilkey<-paste("https://api.monsanto.com:443/soilsamples/v2/rowKey/",as.character(summaryj[1,"rowKey"]),sep="");#print(urlsoil);

response <- get_token(client_id, client_secret)
content <- content(response);
token <- paste(content$token_type, content$access_token, sep=" ")
responsesoil <- get_soil_rowkey(token,urlsoilkey,as.character(summaryj[1,"userId"]))
soil<-fromJSON(as.character(responsesoil))
s<-1;t<-1

### Import the data into a data frame
soildf<-c() #The Data frame for a soil sample
if("soilSamples"%in%names(soil)){ #Check if there exists soil sample data 
 if(length(soil$soilSamples)>0){ #Another check if there exists soil sample data
   for(s in 1:length(soil$soilSamples)){ #For each soil sample data point s
     soil_s<-t(data.frame(unlist(soil$soilSamples[[s]]))) #extract the sample data from point s
     row.names(soil_s)<-s #name the rows by the soil sample iterator s
     soildf<-smartbind(soildf,soil_s) #bind rows by the common column names
   }
   soildf<-soildf[-1,] #smartbind duplicates the first row.  This is my fix.
   row.names(soildf)<-paste(summaryj[1,"importFileName"],seq(1,length(soil$soilSamples)),sep="|")
   #Save Data Frame
   #length(list.files("SoilSamples/"))
   #list.files("SoilSamples/")
   if(!file.exists(paste("SoilSampleData/",as.character(summaryj[1,"rowKey"])))){
   write.csv(soildf,paste("SoilSampleData/",as.character(summaryj[1,"rowKey"]),sep="") )
   }
   #Calculate Convex Hull
   if(prod(c("longitude","latitude")%in%colnames(soildf))==1){
     chulldf<-unique(soildf[which(!is.na(soildf$longitude)&!is.na(soildf$latitude)),c("longitude","latitude")])
     chulldf<-chulldf[chull(chulldf),]
     chull_acres<-geosphere::areaPolygon(chulldf)/4046.8564224
     chulldf<-paste(paste(chulldf[,1],"%20",chulldf[,2],sep=""),collapse=",")
     summaryj<-cbind(summaryj,chulldf,chull_acres)
     colnames(summaryj)[(ncol(summaryj)-1):ncol(summaryj)]<-c("chull","chull.acres")
     }
   for(t in 1:ncol(soildf)){ #for every column
     if(prod(is.finite(suppressWarnings(as.numeric(soildf[,t]))))==1){ #if all values in column are numeric
       soildf[,t]<-as.numeric(as.character(soildf[,t])) #transform data into numeric
       summaryj<-cbind(summaryj, #summary statstics
         mean(soildf[!is.na(soildf[,t]),t]), #mean
         median(soildf[!is.na(soildf[,t]),t]), #median
         var(soildf[!is.na(soildf[,t]),t]), #variance
         min(soildf[!is.na(soildf[,t]),t]), #min
         max(soildf[!is.na(soildf[,t]),t]),  #max  
         sum(!is.na(soildf[,t]))  #n  
       )
       colnames(summaryj)[(ncol(summaryj)-4):ncol(summaryj)]<-c( #rename columns
         paste(colnames(soildf)[t],"mean",sep="."), #var.mean
         paste(colnames(soildf)[t],"median",sep="."), #var.median
         paste(colnames(soildf)[t],"var",sep="."), #var.variance
         paste(colnames(soildf)[t],"min",sep="."), #var.min
         paste(colnames(soildf)[t],"max",sep="."), #var.max
         paste(colnames(soildf)[t],"n",sep=".") #var.n
       )
     } #close check for Numeric
     if(sum(is.finite(suppressWarnings(as.numeric(soildf[,t]))))==0){ #if at least one value is not numeric
      maxuniq<-3 #limit the length of unique values in data frame
        if(length(unique(soildf[,t]))<=maxuniq){ #max unique values
         #save unique values in format {Element1, Element2, Element3}
       summaryj<-cbind(summaryj,paste("{",paste(unique(soildf[,t]),collapse=", "),"}",sep=""))
       colnames(summaryj)[ncol(summaryj)]<-colnames(soildf)[t]
       }
       if(length(unique(soildf[,t]))>maxuniq){ #max of 3 unique values
         #indicator variable exists
         summaryj<-cbind(summaryj,TRUE)
         colnames(summaryj)[ncol(summaryj)]<-colnames(soildf)[t]
       }
     } #close check for Non-Numeric
   } #Close loop for all columns
 } #Close loop for second check to test if soil sample data exists
} #Close loop for first check to test if soil sample data exists

try(summary<-smartbind(summary,summaryj),silent=TRUE)
remove(summaryj,s,t,urlsoilkey,soil,chulldf,chull_acres)
} # Close loop for ALL soil files
print(j)
summary<-summary[-1,]
row.names(summary)<-summary$importId
summary$publishedDate[(unlist(gregexpr("-",summary$publishedDate))>0)==FALSE]<-as.POSIXct(as.numeric(substr(as.character(summary$publishedDate[(unlist(gregexpr("-",summary$publishedDate))>0)==FALSE]),1,10)),origin = "1970-01-01",tmz="GMT")
write.csv(summary,"SoilSamples(Summary).csv")



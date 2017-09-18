?assign

k=5;
for(i in 1:k){
  assign(paste("df",i,sep=""),runif(rpois(1,100))) #randomly assigns random unif(0,1) values.  The number of elements is Poisson Random  
}

i=2
get(paste("df",i,sep=""))
head(df2)
dim(df2)
length(df2)
unique(df2)



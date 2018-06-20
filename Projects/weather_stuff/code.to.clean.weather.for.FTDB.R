temp.max<-read.csv(file.choose())
temp.min<-read.csv(file.choose())
ppt<-read.csv(file.choose())

fix.weather.headings<-function(x) {
names(x)<-tolower(names(x))
names(x)<-gsub(".","_",names(x),fixed=T)
names(x)<-gsub("temperature","temp",names(x),fixed=T)
return(x)
}

temp.max<-fix.weather.headings(temp)
temp.min<-fix.weather.headings(temp.min)
ppt<-fix.weather.headings(ppt)

colnames(temp.max)[length(x[1,])]<-"quality_max"
colnames(temp.min)[length(x[1,])]<-"quality_min"
colnames(ppt)[length(x[1,])]<-"quality_ppt"

temp.join<-join(temp.min,temp.max,by=c("product_code","bureau_of_meteorology_station_number","year","month","day"))
temp.ppt.join<-join(temp.join,ppt,by=c("product_code","bureau_of_meteorology_station_number","year","month","day"))

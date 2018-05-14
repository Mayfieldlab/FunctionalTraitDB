######################################
#### Code written by Trace Martyn ####
#### Version 1: 15-06-2017        ####
######################################

# clear workspace
rm(list=ls())

##### Cleaning code for SURV1 ####

### set working directory
setwd("/home/uqtmart7/data/Dropbox/Mayfield Lab/FunctionalTraitDatabase/Projects/SURV1/RAW")

raw<-read.csv('quadrat_scale_data_June_2017.csv')

# list all sites
sites<-unique(raw$remnant)

## projects dataframe
projects<-data.frame(project_id=1,researcher="JohnDwyer",email="j.dwyer2@uq.edu.au",study_sites=paste(sites,collapse="_"))

# list all years
years<-unique(raw$year)

## field_season dataframe
field_season<-data.frame(field_season_id=c(1,2),project_id=1,year=years,crew=c("JohnDwyer","JohnDwyer_ClaireWainwright"))

## site dataframe
site<-data.frame(site_id=seq(1,length(sites)),site=sites,area=0,units="ha",lat=0,long=0,max_temp=0,min_temp=0,ann_precip=0)

## treatment dataframe
treatment<-data.frame(treatment_id=c(1,2),treatment=c("Edge","Interior"))

## make plot dataframe

# make smaller dataframe without extranious values for plot dataframe
raw.plot<-data.frame(year=raw$year,site=raw$remnant,block=raw$site,plot=raw$quadrat, edge=raw$edge)

# remove duplicate values 
raw.plot<-raw.plot[!duplicated(raw.plot),]

# add treatment values - match the edge code (0,1) to treatment code listed above (1,2)
raw.plot$treatment<-unlist(lapply(raw.plot$edge, function (x) replace (x,x==1,2)))
raw.plot$treatment<-unlist(lapply(raw.plot$treatment, function (x) replace (x,x==0,1)))

# match site name with site_id above
raw.plot<-merge(raw.plot,site[,c("site_id","site")],by="site")

# match field season year with field_season_id above
raw.plot<-merge(raw.plot,field_season[,c("field_season_id","year")],by="year")

# sort the dataframe so it is easy to compare to original 'raw'
raw.plot<-raw.plot[order(raw.plot$field_season_id,raw.plot$site_id,raw.plot$block,raw.plot$plot,raw.plot$edge),]

# plot dataframe
plot<-data.frame(plot_id=seq(1,length(raw.plot$plot)),field_season_id=raw.plot$field_season_id,site_id=raw.plot$site_id,block=raw.plot$block,treatment_id=raw.plot$treatment)

###########################3
## make trait summary dataframe

# read in raw trait data (this is actually only average data - will get actual individual data from John on Monday June 19 2017)
raw.trait<-read.csv("species_in_quadrat_scale_data_June_2017.csv")

# add field_season_id from above
raw.trait<-merge(raw.trait,field_season[,c("year","field_season_id")],"year")

# split the large dataframe by field_season_id incase there are different traits for different seasons
raw.trait.fs.1<-na.omit(raw.trait[which(raw.trait$field_season_id==1),])
raw.trait.fs.2<-na.omit(raw.trait[which(raw.trait$field_season_id==2),])

# visually insepect which column headers are traits
head(raw.trait.fs.1)
head(raw.trait.fs.2)

# extract column names for trait values
trait.col.names.1<-colnames(raw.trait.fs.1)[8:30]
trait.col.names.2<-colnames(raw.trait.fs.2)[8:30]

# make trait dataframe
  #list of traits = paste in column headers without the "." and then all merged into one string separted by "_"
trait_summary<-data.frame(field_season_id=c(1,2),traits=c(paste(gsub("\\.","",trait.col.names.1),collapse = "_"),paste(gsub("\\.","",trait.col.names.2),collapse = "_")))

#####################
## write out csv's
setwd("/home/uqtmart7/data/Dropbox/Mayfield Lab/FunctionalTraitDatabase/Projects/SURV1/CLEAN")
write.csv(projects,"projects.csv",row.names=F)
write.csv(field_season,"field_season.csv",row.names=F)
write.csv(site,"site.csv",row.names=F)
write.csv(treatment,"treatment.csv",row.names=F)
write.csv(plot,"plot.csv",row.names=F)
write.csv(trait_summary,"trait_summary.csv",row.names = F)
###########################






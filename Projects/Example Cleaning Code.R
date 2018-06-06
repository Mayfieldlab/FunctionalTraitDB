######################################
#### Code written by Isaac Towers ####
#### Version 1:  06-06-2018       ####
######################################

####Clear workspace

rm(list=ls())

#####This is an example code which shows you how to set the appropriate working directories,
#####and produce CSVs with standardised names. Although some parts will require adaptation for 
#####the specific project that you are working on, it has been designed so that in some cases,
#####you simply change the input names that I have used to the ones appropriate to your project.
#####In this code, I have used SURV1 which is John Dwyer's survey data from 2011.


                               #####PLUG-AND-PLAY REQUIRED INFO#########

####Insert the name of the project folder

project.folder<-"SURV1"

####Insert the name, email of the principal investigator

researcher<-"JohnDwyer"
email<-"j.dwyer2@uq.edu.au"

####Project ID number

project_id<-1


####set working directory to the designated project folder (no change required for this line)
setwd(project.folder)


#####    The following needs to be changed as per the requirements of the project     ####


####To bring in a raw datasheet to be reformatted - all project folders include a "raw"
####file, thus the only thing that needs to be changed here is the name of the 
####file (i.e. quadrat_scale_data_June_2017.csv) and the name of the object (i.e. raw.dataframe)

plot.level<-read.csv('raw/quadrat_scale_data_June_2017.csv')
individual.level<-read.csv("raw/species_in_quadrat_scale_data_June_2017.csv")



####Which study sites did this project occur at?

study_sites<-unique(plot.level$remnant)

####Create projects dataframe
projects<-data.frame(project_id=project_id,
                     researcher=researcher,
                     study_sites=paste(study_sites,collapse="_"))

####list all years that the study occurred - if not available in raw dataframe then 
####fill in manual years as a vector

#years<-c(2010,2011,...)
year<-unique(plot.level$year)


####min and max growing season temperature for each field season
####set up empty vectors to recieve the information in the next step
fs_min_temp_C<-as.vector(rep(NA, length(year)))
fs_max_temp_C<-as.vector(rep(NA, length(year)))


#####this study actually has multiple sites within a field season, so this is min and max
#####temperature across all sites for a given field season
for(i in 1:length(year)){
  fs_min_temp_C[i]<-min(plot.level[plot.level$year==year[i],]$gs.tmin)
  fs_max_temp_C[i]<-max(plot.level[plot.level$year==year[i],]$gs.tmax)
  }



####Create field season dataframe 

#Field_season_id appropriate if split over years, if only one field season then fill in "1" only
#If crew does not change between years then fill in only one entry
field_season<-data.frame(field_season_id=c(1,2),
                         project_id=project_id,
                         year=year,crew=c("JohnDwyer","JohnDwyer_ClaireWainwright"),
                         fs_min_temp_C=fs_min_temp_C,
                         fs_max_temp_C=fs_max_temp_C)


####min and max growing season temperature for each site, name of the dataframe and name 
###of temperature variable e.g. gs.tmin needs to be changed to your own example
min_temp_C<-as.vector(rep(NA, length(study_sites)))
max_temp_C<-as.vector(rep(NA, length(study_sites)))

for(i in 1:length(study_sites)){
  min_temp_C[i]<-min(plot.level[plot.level$remnant==study_sites[i],]$gs.tmin)
  max_temp_C[i]<-max(plot.level[plot.level$remnant==study_sites[i],]$gs.tmax)
}


####Create site dataframe
site<-data.frame(site_id=seq(1,length(study_sites)),
                 site=study_sites,
                 area=-9999,
                 units=-9999,
                 lat=-9999,
                 long=-9999,
                 max_temp_C=max_temp_C,
                 min_temp_C=min_temp_C)

## treatment dataframe - each treatment is assigned an identifier and a name for the treatment
treatment<-data.frame(treatment_id=c(1,2),
                      treatment=c("Edge","Interior"))


#### Plot dataframe will have the same amount of observations as the plot.level data.frame so we will
#### assign the plot.level to a new name with just the variables needed for the plot level

# make smaller dataframe without extranious values for plot dataframe
plot.level.thinned<-data.frame(year=plot.level$year,
                               site=plot.level$remnant,
                               block=plot.level$site,
                               plot=plot.level$yrsq,
                               edge=plot.level$edge)

###remove duplicated values if they are present
plot.level.thinned<-plot.level.thinned[!duplicated(plot.level.thinned),]

####edge is currently a variable assigned as either 0=interior or 1=edge but when we want 
####to compare across the entire trait database we want these values to match the treatment ID
####for all studies which compare edge to interior

plot.level.thinned$treatment<-unlist(lapply(plot.level.thinned$edge, function (x) replace (x,x==1,2)))
plot.level.thinned$treatment<-unlist(lapply(plot.level.thinned$treatment, function (x) replace (x,x==0,1)))

# match site name with site_id above

plot.level.thinned<-merge(plot.level.thinned,site[,c("site_id","site")],by="site")

# match field season year with field_season_id above
plot.level.thinned<-merge(plot.level.thinned,field_season[,c("field_season_id","year")],by="year")

# sort the dataframe so it is easy to compare to original 'raw'
plot.level.thinned<-plot.level.thinned[order(plot.level.thinned$field_season_id,plot.level.thinned$site_id,plot.level.thinned$block,plot.level.thinned$plot,plot.level.thinned$edge),]

###add plot id to plot.level.thinned
plot.level.thinned$plot_id<-seq(1,length(plot.level.thinned$plot))


###make the plot data frame
plot<-data.frame(plot_id=plot.level.thinned$plot_id,field_season_id=plot.level.thinned$field_season_id,site_id=plot.level.thinned$site_id,block=plot.level.thinned$block,treatment_id=plot.level.thinned$treatment)


#### to make the species-level dataframe

#####make species dataframe

species<-data.frame(species=unique(individual.level$species), species_id=seq(1:length(unique(individual.level$species))))

###individual data frame will have the same amount of observations of the raw individual-level data set
###just get the variables we will need


individual.level.thinned<-data.frame(plot=individual.level$yrsq, species=individual.level$species)
individual.level.thinned<-merge(individual.level.thinned, plot.level.thinned[,c("plot","plot_id")], by="plot")
individual.level.thinned<-merge(individual.level.thinned, species[,c("species","species_id")], by="species")
individual.level.thinned$individual_id<-seq(1:length(individual.level.thinned))


####make the individual dataframe
individual<-data.frame(individual_id=individual.level.thinned$individual_id
                       ,plot_id=individual.level.thinned$plot_id
                       ,species_id=individual.level.thinned$species_id)


###########################
## make trait summary dataframe

individual.level.trait<-merge(individual.level,field_season[,c("year","field_season_id")],"year")











# add field_season_id from above
raw.trait<-merge(raw.trait,field_season[,c("year","field_season_id")],"year")


# split the large dataframe by field_season_id incase there are different traits for different seasons
raw.trait.fs.1<-(raw.trait[which(raw.trait$field_season_id==1),])
raw.trait.fs.2<-(raw.trait[which(raw.trait$field_season_id==2),])

# visually insepect which column headers are traits
head(raw.trait.fs.1)
head(raw.trait.fs.2)

# extract column names for trait values
trait.col.names.1<-colnames(raw.trait.fs.1)[8:length(colnames(raw.trait.fs.1))]
trait.col.names.2<-colnames(raw.trait.fs.2)[8:length(colnames(raw.trait.fs.1))]

# make trait dataframe
#list of traits = paste in column headers without the "." and then all merged into one string separted by "_"
trait_summary<-data.frame(field_season_id=c(1,2),traits=c(paste(gsub("\\.","",trait.col.names.1),collapse = "_"),paste(gsub("\\.","",trait.col.names.2),collapse = "_")))



####make individual-level dataframe

raw.trait.individual<-data.frame(plot=raw.trait$yrsq, species=raw.trait$species)
raw.trait.individual<-merge(raw.trait.individual, plot[,c("plot_id","plot")], by="plot")
raw.trait.individual<-merge(raw.trait.individual, species[,c("species_id","species")], by="species")

####start by removing extraneous variables



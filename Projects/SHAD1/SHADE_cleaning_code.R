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


###function to write clean csvs automatically given the name of the dataframe
write.clean.csv<-function(x) write.csv(x, paste("clean/",deparse(substitute(x)),".csv", sep=""))


                               #####PLUG-AND-PLAY REQUIRED INFO#########

####Insert the name of the project folder

project.name<-"SHAD1"

####Insert the name, email of the principal investigator

researcher<-"ClaireWainwright"
email<-"cewain@u.washington.edu"

####Project ID number

project_id<-2


####set working directory to the designated project folder (no change required for this line)
setwd(project.name)


#####    The following needs to be changed as per the requirements of the project     ####


####To bring in a raw datasheet to be reformatted - all project folders include a "raw"
####file, thus the only thing that needs to be changed here is the name of the 
####file (i.e. quadrat_scale_data_June_2017.csv) and the name of the object (i.e. plot.level)

plot.level<-read.csv('raw/shade1_plot_data.csv')


####Which study sites did this project occur at? If this column does not exist in data then manually entry
####using line below which is ###ed out

#study_sites<-unique(plot.level$remnant)
study_sites<-c("Perenjori")

####Create projects dataframe
projects<-data.frame(project_id=project_id,
                     project=project.name,
                     researcher=researcher,
                     study_sites=paste(study_sites,collapse="_"),
                     notes=NA)

####list all years that the study occurred - if not available in raw dataframe then 
####fill in manual years as a vector

year<-c(2015)
#year<-unique(plot.level$year)


####Create field season dataframe 

#Field_season_id appropriate if split over years, if only one field season then fill in "1" only
#If crew does not change between years then fill in only one entry
field_season<-data.frame(field_season_id=c(1),
                         project_id=project_id,
                         year=year,crew=c("ClaireWainwright","TomFlannagan"),
                         notes=NA)


####Create site dataframe
site<-data.frame(site_id=seq(1,length(study_sites)),
                 site=study_sites,
                 area=-9999,
                 units=-9999,
                 lat=-9999,
                 long=-9999,
                 notes=NA)

## treatment dataframe - each treatment is assigned an identifier and a name for the treatment
treatment<-data.frame(treatment_id=c(1,2),
                      treatment=c("Open","Shade"))


#### Plot dataframe will have the same amount of observations as the plot.level data.frame so we will
#### assign the plot.level to a new name with just the variables needed for the plot level

# make smaller dataframe without extranious values for plot dataframe
###remove duplicated values if they are present

plot.level.unique<-plot.level[!duplicated(plot.level$Plot.ID),]

####edge is currently a variable assigned as either 0=interior or 1=edge but when we want 
####to compare across the entire trait database we want these values to match the treatment ID
####for all studies which compare edge to interior

plot.level.unique$Treatment<-as.character(plot.level.unique$Treatment)

for (i in 1:nrow(plot.level.unique))
  {
    if(plot.level.unique[i,"Treatment"]=="Open"){
        plot.level.unique[i,"Treatment"]<-1}else{
        plot.level.unique[i,"Treatment"]<-2
      }
  }


###make the plot data frame. I did not use merge because this project only has one site
plot<-data.frame(plot_id=plot.level.unique$Plot.ID,field_season_id=unique(field_season$field_season_id),
                 site_id=1,block=plot.level.unique$Block,treatment_id=plot.level.unique$Treatment, 
                 lat=site$lat, long=site$lat)


######making environmental dataframes######

shade_env_variables<-read.csv("raw/2015_plant_level_data_CEW170712.csv")

              
soil.moisture<-data.frame(soil_moisture_id=seq(1:length(shade_env_variables$Plot.ID)),
                        plot_id=shade_env_variables$Plot.ID,
                        soil_moisture_earlyAug_hc=shade_env_variables$Mean.soilmoisture.22.or.23.Aug.hicomp,
                        soil_moisture_lateAug_hc=shade_env_variables$Mean.soilmoisture.22.or.23.Aug.hicomp,
                        soil_moisture_earlySep_hc=shade_env_variables$Mean.soilmoisture.3Sep.hicomp,
                        soil_moisture_earlyAug_solo=shade_env_variables$Mean.solo.soilmoisture,
                        soil_moisture_lateAug_solo=shade_env_variables$Mean.solo.soilmoisture.22or23.Aug,
                        soil_moisture_earlySep_solo=shade_env_variables$Mean.solo.soilmoisture.3Sep,
                        date_collected=2015,
                        notes=NA)


bare_ground<-data.frame(bare_ground_id=seq(1:length(shade_env_variables$Plot.ID)),
                        plot_id=shade_env_variables$Plot.ID,
                        bare_ground_percent=shade_env_variables$Bare,
                        date_collected=2015,
                        notes=NA)
Moss_cover<-data.frame(moss_cover_id=seq(1:length(shade_env_variables$Plot.ID)),
                        plot_id=shade_env_variables$Plot.ID,
                        Moss_cover_percent=shade_env_variables$Moss,
                        date_collected=2015,
                        notes=NA)

Crust_cover<-data.frame(Crust_ground_id=seq(1:length(shade_env_variables$Plot.ID)),
                        plot_id=shade_env_variables$Plot.ID,
                        Crust_cover_percent=shade_env_variables$Crust,
                        date_collected=2015,
                        notes=NA)

Coarse_woody_debri<-data.frame(CWD_id=seq(1:length(shade_env_variables$Plot.ID)),
                        plot_id=shade_env_variables$Plot.ID,
                        CWD_percent=shade_env_variables$CWD,
                        date_collected=2015,
                        notes=NA)

Rock_cover<-data.frame(Rock_id=seq(1:length(shade_env_variables$Plot.ID)),
                        plot_id=shade_env_variables$Plot.ID,
                        rock_percent=shade_env_variables$Rock,
                        date_collected=2015,
                        notes=NA)
Log_near<-data.frame(Near_log_id=seq(1:length(shade_env_variables$Plot.ID)),
                       plot_id=shade_env_variables$Plot.ID,
                       Log_near=shade_env_variables$Near.under.log,
                       date_collected=2015,
                       notes=NA)
Jam_litter<-data.frame(Jam.litter_id=seq(1:length(shade_env_variables$Plot.ID)),
                       plot_id=shade_env_variables$Plot.ID,
                       Jam_litter=shade_env_variables$Jam.litter,
                       date_collected=2015,
                       notes=NA)
York_gum_cover<-data.frame(York_gum_id=seq(1:length(shade_env_variables$Plot.ID)),
                       plot_id=shade_env_variables$Plot.ID,
                       York_gum_percent=shade_env_variables$Euc.litter,
                       date_collected=2015,
                       notes=NA)
Colwell_phosphorous<-data.frame(Colwell_p_id=seq(1:length(shade_env_variables$Plot.ID)),
                           plot_id=shade_env_variables$Plot.ID,
                           Colwell_P=shade_env_variables$Colwell.P,
                           date_collected=2015,
                           notes=NA)
Canopy_cover<-data.frame(Canopy_cover_id=seq(1:length(shade_env_variables$Plot.ID)),
                           plot_id=shade_env_variables$Plot.ID,
                           Canopy_cover=shade_env_variables$Canopy.cover.final,
                           date_collected=2015,
                           notes=NA)


##############repeat in the same way for all environment variables


#### to make the species-level dataframe

#######################TBA#####################################

####Species level dataframe and all higher-level csvs related to taxonomy are still to come
####Species information will be extracted from a common SLQ database and the species IDS
####matched up to the appropriate species in the spreadsheet. At the moment, we are currently
####just using the species name as a placeholder

individual.level<-read.csv("raw/shad1_plant_lvl_focal.csv")

###individual data frame will have the same amount of observations of the raw individual-level data set
###just get the variables we will need

individual.level.shade<-data.frame(plot=individual.level$Plot.ID, species=individual.level$Focal.sp)

#####assign each individual an ID, but paste the name of the project to the front

individual.level.shade$individual_id<-paste(project.name, seq(1:length(individual.level.shade[,1])), sep="_")


####make the individual dataframe
individual<-data.frame(individual_id=individual.level.shade$individual_id
                       ,plot_id=individual.level.shade$plot
                       ,species=individual.level.shade$species)

####remember that above, species could be essentially whatever you like, we are still working on liking the 
####the SLq database of species to the R code



###########################

# make trait dataframe
#list of traits = paste in column headers without the "." and then all merged into one string separted by "_"
trait_summary<-data.frame(field_season_id=1,traits =c("Height", "Leaf_length", "Mean-Lat"))

###########################TO MAKE TRAIT CSVs###########################################

######assign the individual ID

individual.level.trait$individual_id<-individual.level.thinned$individual_id


height<-data.frame(height_id=seq(1:length(individual.level$Height))
                ,individual_id=individual.level.shade$individual_id
                ,height_mm=individual.level$Height
                ,date_collected=2015,
                notes=NA)

Leaf_length<-data.frame(Leaf_lenght_id=seq(1:length(individual.level$Leaf.length))
                   ,individual_id=individual.level.shade$individual_id
                   ,Leaf_length_mm=individual.level$Leaf.length
                   ,date_collected=2015,
                   notes=NA)
Mean_lat<-data.frame(Mean_lat_id=seq(1:length(individual.level$Mean.Lat))
                     ,individual_id=individual.level.shade$individual_id
                     ,Mean_lat_mm=individual.level$Mean.Lat
                     ,date_collected=2015,
                     notes=NA)

write.clean.csv(projects)
write.clean.csv(field_season)
write.clean.csv(site)
write.clean.csv(plot)
write.clean.csv(individual)
write.clean.csv(height)
write.clean.csv(Leaf_length)
write.clean.csv(Mean_lat)
write.clean.csv(trait_summary)
write.clean.csv(treatment)
write.clean.csv(soil.moisture)
write.clean.csv(bare_ground)
write.clean.csv(Moss_cover)
write.clean.csv(Rock_cover)
write.clean.csv(Canopy_cover)
write.clean.csv(Log_near)
write.clean.csv(York_gum_cover)
write.clean.csv(Jam_litter)
write.clean.csv(Colwell_phosphorous)

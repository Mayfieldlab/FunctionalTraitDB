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

project.name<-"DENS1"

####Insert the name, email of the principal investigator

researcher<-"ClaireWainwright"
email<-"cewain@u.washington.edu"

####Project ID number

project_id<-3


####set working directory to the designated project folder (no change required for this line)
setwd(project.name)


#####    The following needs to be changed as per the requirements of the project     ####


####To bring in a raw datasheet to be reformatted - all project folders include a "raw"
####file, thus the only thing that needs to be changed here is the name of the 
####file (i.e. quadrat_scale_data_June_2017.csv) and the name of the object (i.e. plot.level)

plot.level<-read.csv('raw/DENs1_final_heights.csv')


####Which study sites did this project occur at? If this column does not exist in data then manually entry
####using line below which is ###ed out

#study_sites<-unique(plot.level$remnant)
study_sites<-c("Growth_chamber")

####Create projects dataframe
projects<-data.frame(project_id=project_id,
                     project=project.name,
                     researcher=researcher,
                     study_sites=paste(study_sites,collapse="_"),
                     notes=NA)

####list all years that the study occurred - if not available in raw dataframe then 
####fill in manual years as a vector

year<-c(2012)
#year<-unique(plot.level$year)


####Create field season dataframe 

#Field_season_id appropriate if split over years, if only one field season then fill in "1" only
#If crew does not change between years then fill in only one entry
field_season<-data.frame(field_season_id=c(1),
                         project_id=project_id,
                         year=year,crew=c("ClaireWainwright"),
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
treatment<-data.frame(treatment_id=c(1,2,3,4),
                      treatment=c("Control","Low","Medium","High"))


#### Plot dataframe will have the same amount of observations as the plot.level data.frame so we will
#### assign the plot.level to a new name with just the variables needed for the plot level

# make smaller dataframe without extranious values for plot dataframe
###remove duplicated values if they are present

plot.level.unique<-plot.level[!duplicated(plot.level$Pot_ID_let),]


plot.level.unique$Treatment<-as.character(plot.level.unique$Density)

for (i in 1:nrow(plot.level.unique))
  {
    if(plot.level.unique[i,"Treatment"]=="high"){
        plot.level.unique[i,"Treatment"]<-3}else{
        if(plot.level.unique[i,"Treatment"]=="medium"){
        plot.level.unique[i,"Treatment"]<-2}else{
        if(plot.level.unique[i,"Treatment"]=="low"){
        plot.level.unique[i,"Treatment"]<-1}else{
        plot.level.unique[i,"Treatment"]<-0
      }
    }
  }
}

###make the plot data frame. I did not use merge because this project only has one site
plot<-data.frame(plot_id=plot.level.unique$Pot_ID_let,field_season_id=unique(field_season$field_season_id),
                 site_id=1,block=NA,treatment_id=plot.level.unique$Treatment, 
                 lat=site$lat, long=site$lat)


######making environmental dataframes######

#This was a growth chamber experiment run once in 2012. 

####Species level dataframe and all higher-level csvs related to taxonomy are still to come
####Species information will be extracted from a common SLQ database and the species IDS
####matched up to the appropriate species in the spreadsheet. At the moment, we are currently
####just using the species name as a placeholder

###individual data frame will have the same amount of observations of the raw individual-level data set
###just get the variables we will need

#include species names based on project codes (metadata sheet from "raw/2012_densitydata.xlsx")

A<- "W.nitida"
B<- 'H.glutinosum.glutinosum'
C<- 'G.berardiana'
D<- "H.glabra"
E<- "P.airoides"
F<- "grass.2"

#

DENS1_heights<-read.csv("raw/DENS1_heights.csv")

DENS1_heights<-gather(DENS1_heights,species,heights,(c(7:11,13:17,
                                                       19:23,25:29,
                                                       31:35,37:41)))


######assign the individual ID

individual.level.dens<-data.frame(plot=DENS1_heights$Pot_ID_let, species=DENS1_heights$species)


#####assign each individual an ID, but paste the name of the project to the front

individual.level.dens$individual_id<-paste(project.name, seq(1:length(individual.level.dens[,1])), sep="_")

####make the individual dataframe
individual<-data.frame(individual_id=individual.level.dens$individual_id
                       ,plot_id=individual.level.dens$plot
                       ,species=individual.level.dens$species)

####remember that above, species could be essentially whatever you like, we are still working on liking the 
####the SLq database of species to the R code


###########################

# make trait dataframe
#list of traits = paste in column headers without the "." and then all merged into one string separted by "_"
trait_summary<-data.frame(field_season_id=1,traits =c("Height"))

###########################TO MAKE TRAIT CSVs###########################################


height<-data.frame(height_id=seq(1:length(DENS1_heights$heights))
                ,individual_id=individual.level.dens$individual_id
                ,height_mm=DENS1_heights$heights
                ,date_collected=DENS1_heights$Date,
                Days_after_planting=DENS1_heights$Days_after_planting,
                notes=NA)

write.clean.csv(projects)
write.clean.csv(field_season)
write.clean.csv(site)
write.clean.csv(plot)
write.clean.csv(individual)
write.clean.csv(height)
write.clean.csv(trait_summary)
write.clean.csv(treatment)

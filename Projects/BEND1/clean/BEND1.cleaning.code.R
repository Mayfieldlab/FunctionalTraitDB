######################################
#### Code written by Trace Martyn ####
#### Version 1: 15-06-2017        ####
######################################

rm(list=ls())

##### Cleaning code for BEND1 ####

### set working directory
setwd("/home/uqtmart7/data/Dropbox/Mayfield Lab/FunctionalTraitDatabase/Projects/BEND1/RAW")

## projects dataframe
projects<-data.frame(project_id=1,researcher="MaiaRaymundo",email="raymundo.mlh@gmail.com",study_sites="bendering")

## field_season dataframe
field_season<-data.frame(field_season_id=c(1,2,3,4),project_id=1,year=c(2014,2015,2016,2017),crew=c("HaoRanLin_MargaretMayfield_XingwenLoy_EmmaLodourceur_JohnPark_ClaireWainwright_AlexanderNance_LeanderLoveAnderegg","HaoRanLin_XingwenLoy","MaiaRaymundo","MaiaRaymundo"))

## site dataframe
site<-data.frame(site_id=1,site="bendering",area=1602,units="ha",lat=0,long=0,max_temp=24.3,min_temp=9.4,ann_precip=361.3)

## treatment dataframe
treatment<-data.frame(treatment_id=c(1,2,3,4,5,6),treatment=c("OpenDry","OpenWet","ControlDry","ControlWet","LidDry","LidWet"))

# Below are various codes use here and in the raw files for the treatments
#Wet = w "Wet"
#Dry = d "Dry"
#Open = o "Open"
#Control/Wall = c "Control"
#Wall+Lid = k "Lid
########################

#### function to add treatment code to dataframe based on 'exclusion' and 'water' columns (in that order into the function) ####
BEND.treatment<- function (x,w) {
  treatment.ew<-vector()
for (i in 1:length(x)) {
  ex<-x[i]
  wat<-w[i]
  if (ex=="c" & wat=="w") {treatment.ew[i]<-4}
  else if (ex=="o" & wat=="w") {treatment.ew[i]<-2}
  else if (ex=="k" & wat=="w") {treatment.ew[i]<-6}
  else if (ex=="c" & wat=="d") {treatment.ew[i]<-3}
  else if (ex=="o" & wat=="d") {treatment.ew[i]<-1}
  else if (ex=="k" & wat=="d") {treatment.ew[i]<-5}
  }
  return (treatment.ew)
}
############################

#### function to extract block number out of the 'unique.plot. column ####
BEND.block<- function (x) {
m<-sapply(as.character(x), function(k) strsplit(k, "[^0-9]"))
sol<-as.numeric(unlist(m))
return(sol[!is.na(sol)])
}
#############################

## read in raw file
raw<-read.csv('bend_box2014_2015.csv')

# make smaller dataframe without extranious values
raw.plot<-data.frame(exclsuion=raw$exclusion,water=raw$water,unique.plot=raw$unique.plot)
# remove duplicate values 
raw.plot<-raw.plot[!duplicated(raw.plot),]
# add block number
raw.plot$block.num<-BEND.block(raw.plot$unique.plot)
# add treatment values
raw.plot$treatment<-BEND.treatment(raw.plot$exclsuion,raw.plot$water)
 
## make plot dataframe
# plot dataframe
plot<-data.frame(plot_id=seq(1,length(unique(raw.plot$unique.plot))),field_season_id=1,site_id=1,block=raw.plot$block.num,treatment_id=raw.plot$treatment)

#####################
## write out csv's
setwd("/home/uqtmart7/data/Dropbox/Mayfield Lab/FunctionalTraitDatabase/Projects/BEND1/CLEAN")
write.csv(projects,"projects.csv",row.names=F)
write.csv(field_season,"field_season.csv",row.names=F)
write.csv(site,"site.csv",row.names=F)
write.csv(treatment,"treatment.csv",row.names=F)
write.csv(plot,"plot.csv",row.names=F)


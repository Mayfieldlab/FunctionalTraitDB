######################################
#### Code written by Trace Martyn ####
#### Version 1: 15-06-2017        ####
######################################

rm(list=ls())

##### Cleaning code for TIME1 ####

### set working directory
setwd("/home/uqtmart7/data/Dropbox/Mayfield Lab/FunctionalTraitDatabase/Projects/TIME1/RAW")

## projects dataframe
projects<-data.frame(project_id=1,researcher="Trace_Martyn",email="t.martyn@uq.net.au",study_sites="perenjori")

## field_season dataframe
field_season<-data.frame(field_season_id=1,project_id=1,year=2016,crew="TraceMartyn_JulieGuenat_MargaretMayfield")

## site dataframe
site<-data.frame(site_id=1,site="perenjori",area=3.5,units="km.sq",lat=0,long=0,max_temp=20.0,min_temp=7.5,ann_precip=298.3)

## treatment dataframe
treatment<-data.frame(treatment_id=1,treatment="control")
########################

##### function to scrub TEM's H###D### code for plot id number #####
scrub.TEM<- function(x) {
den<-sapply(strsplit(as.character(x),"D"),"[[",2)
code.scrub<-gsub("H","",x=as.character(x))
code<-sapply(strsplit(gsub("D","_",code.scrub),"_"),"[[",1)
dm<-data.frame(cbind(den,code))
return(dm) }
###########################

##### function to add TEM's block id based on plot.number ####
block.TEM<- function(x) {
  vc.bl<-data.frame(plot=as.numeric(x),block=0)
  for (i in 1:length(x)) {
    pt<-vc.bl$plot[i]
    if(findInterval(pt,c(1,21))==T) {vc.bl$block[i]<-1}
    else if(findInterval(pt,c(21,41))==T) {vc.bl$block[i]<-2}
    else if(findInterval(pt,c(41,61))==T) {vc.bl$block[i]<-3}
    else if(findInterval(pt,c(61,81))==T) {vc.bl$block[i]<-4}
    else if(findInterval(pt,c(81,101))==T) {vc.bl$block[i]<-5}
  }
  return(vc.bl)
}
###########################

## read in raw file
raw<-read.csv('TIME1.csv')

## make plot dataframe
# extract the plot numbers from raw file
plot.code<-scrub.TEM(raw$ID)
# plot dataframe
plot<-data.frame(plot_id=unique(plot.code$code),field_season_id=1,site_id=1,block=1,treatment_id=1)
# add block numbers
plot$block<-block.TEM(plot$plot_id)[,2]

## make trait summary dataframe
# look for what traits are available
head(raw)
# list traits seperated by "_"
traits<-"NumberOfBuds_NumberOfFlowers_NumberOfFruits_MaxHeightmm_ShapeLong_Shape90_MeanLateralShape_ShapeRatio"
trait_summary<-data.frame(field_season_id=1,trait_summary=traits)

#####################
## write out csv's
setwd("/home/uqtmart7/data/Dropbox/Mayfield Lab/FunctionalTraitDatabase/Projects/TIME1/CLEAN")
write.csv(projects,"projects.csv",row.names=F)
write.csv(field_season,"field_season.csv",row.names=F)
write.csv(site,"site.csv",row.names=F)
write.csv(treatment,"treatment.csv",row.names=F)
write.csv(plot,"plot.csv",row.names=F)
write.csv(trait_summary,"trait_summary.csv")


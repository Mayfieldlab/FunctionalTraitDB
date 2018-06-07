######################################
#### Code written by Isaac TOwers ####
#### Version 1: 28-05-2018       ####
######################################

# clear workspace
rm(list=ls())

##### Cleaning code for WARM1 ####

raw<-read.csv('WaRM_CTD25_05_17_raw.csv')
sites<-droplevels(unique(raw$Site))
projects<-data.frame(project_id=1,researcher="TravisBritton",email="j.dwyer2@uq.edu.au",study_sites=paste(sites,collapse="_"))

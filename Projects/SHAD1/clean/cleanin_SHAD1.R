###############################################
# Project: Traits database                    #
# Script to clean SHAD1 project data          #
#                                             #
# author: Malyon                              #      
# date: July 2017                             #
###############################################


# Set path to project folder
############################
local_path <- '~/Dropbox/' # this is where you put in the path to whatever folder holds the Mayfield Lab folder on your computer
path <- paste0(local_path, 'Mayfield Lab/FunctionalTraitDatabase/Projects/SHAD1/')

# Load relevant files 
#######################

metadata <- read.csv(paste0(path, 'raw/2015_plant_level_metadata_CEW170712.csv'), header = T, stringsAsFactors = F)
plantdata <- read.csv(paste0(path, 'raw/2015_plant_level_data_CEW170712.csv'), header = T, stringsAsFactors = F)

## IMPORTANT NOTE: I'm ignoring the soil results and the germination & viability data for now


# create some ID variables - those will be modifed in the database (?)
project_id <- '1'
field_season_id <- '1'
site_id <-
treatment_id <-
  
  
# Now on to the output 
########################

# projects table  // UNFINISHED //
#----------------
projects <- data.frame(project_id = project_id,
                       researcher = 'ClaireWainwright',
                       email = 'cewain@u.washington.edu',
                       study_sites = '')
write.csv(projects, paste0(path, 'clean/projects.csv'), row.names = F)

# field season table  // UNFINISHED //
#--------------------
field_season <- data.frame(field_season_id = field_season_id,
                           project_id = project_id,
                           year = 2015,
                           crew = 'ClaireWainwright_TomFlannagan_MaiaRaymundo',
                           fs_max_temp_C = NA,  # not available in the collected data
                           fs_min_temp_C = NA,  # not available in the collected data
                           fs_mean_precip_mm = NA)   # not available in the collected data
write.csv(field_season, paste0(path, 'clean/field_season.csv'), row.names = F)





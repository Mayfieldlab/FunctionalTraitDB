###############################################
# Project: Traits database                    #
# Script to clean SHAD1 project data          #
#                                             #
# author: Malyon                              #      
# date: July 2017                             #
###############################################


# Set path to project folder
############################
local_path <- '~/Documents/' # this is where you put in the path to whatever folder holds the Mayfield Lab folder on your computer
path <- paste0(local_path, 'GitHub/FunctionalTraitDB/Projects/SHAD1/')

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

# projects table  
#----------------
projects <- data.frame(project_id = project_id,
                       project = 'WA shade experiment',
                       researcher = 'ClaireWainwright',
                       email = 'cewain@u.washington.edu',
                       study_sites = 'Perenjori')
write.csv(projects, paste0(path, 'clean/projects.csv'), row.names = F)

# field season table 
#--------------------
field_season <- data.frame(field_season_id = field_season_id,
                           project_id = project_id,
                           year = 2015,
                           crew = 'ClaireWainwright_TomFlannagan_MaiaRaymundo',
                           fs_max_temp_C = NA,  # not available in the collected data
                           fs_min_temp_C = NA,  # not available in the collected data
                           fs_mean_precip_mm = NA)   # not available in the collected data
write.csv(field_season, paste0(path, 'clean/field_season.csv'), row.names = F)

# site table UNFINISHED 
#-------------------
site <- data.frame(site_id = site_id,
                   site = 'West Perenjori Nature Reserve',
                   area = 3.6,
                   units = 'km2',
                   lat = ,
                   max_temp_C = ,
                   min_temp_C = ,
                   annual_temp_mm = )
write.csv(site, paste0(path, 'clean/site.csv'), row.names = F)

# treatment table 
#------------------
treatment <- data.frame(treatment_id = treatment_id, 
                        treatment = 'shade, open')
write.csv(treatment, paste0(path, 'clean/treatment.csv'), row.names = F)

# trait summary table - not even sure if all of these are traits?
#-------------------
trait_summary <- data.frame(field_season_id = field_season_id,
                            traits = Focal.height_Solo.height_Height_Num.fl.total_Num.fl.seeding.total_Seedcount.extrap.interger_Mean.solo.seedcount.extrap.integer.block_Delta.seedcount.meansolospeciesblock_Solo.seedcount.extrap.integer_Delta.seedcount.highcomp.solo.pair_no.developed.flowers_Mean.seed.per.flower_Extrapolated.Seed.Total_Viability_Germination)
write.csv(trait_summary, paste0(path, 'clean/trait_summary.csv'), row.names = F)

# plot table 
#------------------
plot <- data.frame(plot_id = plot_id,
                   field_season_id = field_season_id,
                   site_id = site_id,
                   block = )
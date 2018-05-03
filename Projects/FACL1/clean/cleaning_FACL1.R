###############################################
# Project: Traits database                    #
# Script to clean FACL1 project data          #
#                                             #
# author: Malyon                              #      
# date: June 2017                             #
###############################################


# Set path to project folder
############################
local_path <- '~/Dropbox/' # this is where you put in the path to whatever folder holds the Mayfield Lab folder on your computer
path <- paste0(local_path, 'Mayfield Lab/FunctionalTraitDatabase/Projects/FACL1/')

# Load relevant files 
#######################
field_counts <- read.csv(paste0(path, 'raw/field_counts.csv'), header = T,
                         stringsAsFactors = F)

field_plant_level_with_env <- read.csv(paste0(path, 'raw/field_plant_level_with_env.csv'), header = T,
                         stringsAsFactors = F)

field_plot_level <- read.csv(paste0(path, 'raw/field_plot_level.csv'), header = T,
                         stringsAsFactors = F)
# Afaik this contains plot environmental and density data for the 18 plots at Bendering: W.acuminata grown in monoculture (8)
# and W.acuminata grown surrounded by A.cupaniana (10)


## ISSUES : 
# There's a different number of plots in each files 
# files don't say which plots are at which site


# create some ID variables - those will be modifed in the database (?)
project_id <- '1'
field_season_id <- '1'
site_id <- c('1', '2')
treatment_id <- c()

# # REDUNDANT FILES: 
# field_plant_level <- read.csv(paste0(path, 'raw/field_plant_level.csv'), header = T,
#                               stringsAsFactors = F)
# this is the same file as field_plant_level_with_env, but with 4 fewer columns (soil moisture, 
# phosphorus, nitrate and mean canopy)


# Now on to the output 
########################

# projects table
#----------------
projects <- data.frame(project_id = project_id,
                       researcher = 'ClaireWainwright',
                       email = 'cewain@u.washington.edu',
                       study_sites = c('bendering', 'kunjin'))
write.csv(projects, paste0(path, 'clean/projects.csv'), row.names = F)

# field season table  // UNFINISHED //
#--------------------
field_season <- data.frame(field_season_id = field_season_id,
                           project_id = project_id,
                           year = 2013,
                           crew = 'ClaireWainwright_XingwenLoy_AngelaGardner_Lalita Fitriani',
                           fs_max_temp_C = NA,  # not available in the collected data, check methods
                           fs_min_temp_C = NA,  # not available in the collected data, check methods
                           fs_mean_precip_mm = NA)   # available in methods but different for each site
write.csv(field_season, paste0(path, 'clean/field_season.csv'), row.names = F)

# trait summary table   // UNFINISHED // 
#---------------------
trait_summary <- data.frame(field_season_id = field_season_id,
                            traits = c('', ''))
write.csv(trait_summary, paste0(path, 'clean/trait_summary.csv'), row.names = F)

# site table   // UNFINISHED //
#------------
site <- data.frame(site_id = site_id,
                   site = '',
                   area = NA,
                   units = NA,
                   lat = NA,  # can be found in methods
                   long = NA, # can be found in methods
                   max_temp_C = NA,  # not available in the collected data - methods ? 
                   min_temp_C = NA,  # not available in the collected data - methods ? 
                   ann_precip_mm = NA)   # not available in the collected data - methods ? 


# treatment table   // UNFINISHED //  
#-----------------
treatment <- data.frame(treatment_id = treatment_id,
                        treatment = c())
write.csv(treatment, paste0(path, 'clean/treatment.csv'), row.names = F)

# plot table   // UNFINISHED //
#------------

# create the df
plot <- data.frame(plot_id = ,
                   field_season_id = ,
                   site_id = ,
                   block = ,
                   treatment_id = ,
                   lat = , 
                   long = )
write.csv(plot, paste0(path, 'clean/plot'), row.names = F)

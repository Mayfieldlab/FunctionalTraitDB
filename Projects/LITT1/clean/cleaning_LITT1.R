###############################################
# Project: Traits database                    #
# Script to clean LITT1 project data          #
#                                             #
# author: Malyon                              #      
# date: June 2017                             #
###############################################


# Set path to project folder
############################
local_path <- '~/Dropbox/' # this is where you put in the path to whatever folder holds the Mayfield Lab folder on your computer
path <- paste0(local_path, 'Mayfield Lab/FunctionalTraitDatabase/Projects/LITT1/')

# Load relevant files 
#######################

plot_level <- read.csv(paste0(path, 'raw/litter_plot_level_Wainwright_20aug14.csv'), header = T,
                       stringsAsFactors = F)
# contains plot environment data
Kunj_plot_level <-  read.csv(paste0(path, 'raw/compiled_Kunj_plot_level.csv'), header = T,
                             stringsAsFactors = F)
# this file is a merged file of plot_level, species densities and IEM results for each plot 
Kunj_all_survey_data <-  read.csv(paste0(path, 'raw/compiled_Kunj_all_survey_data.csv'), header = T,
                                  stringsAsFactors = F)
# *** I'm confused - this file has two species columns that aren't in Kunj_plot_level, but fewer species columns overall ??? ***
Kunjin_harvest_species <-  read.csv(paste0(path, 'raw/compiled_Kunjin_harvest_species.csv'), header = T,
                                     stringsAsFactors = F)
Kunjin_harvest_individuals <- read.csv(paste0(path, 'raw/compiled_Kunjin_harvest_individuals.csv'), header = T,
                                       stringsAsFactors = F)
# *** There's more rows in the harvest_species df than the harvest_indivs column ?? Investigate ***
# update: If I remove the rows where Plant.biomass is NA, I get the same number of rows for both files
Kunj_seed_mass_per_individual  <-  read.csv(paste0(path, 'raw/compiled_Kunj_seed_mass_per_individual.csv'), header = T,
                                            stringsAsFactors = F) 
# seed mass data
anion_exchange_strips  <-  read.csv(paste0(path, 'raw/compiled_Kunj_survey_Sep_2013.csv'), header = T,
                                    stringsAsFactors = F)
# this file contains anion-exchange membrane strip data

# create some ID variables - those will be modifed in the database (?)
project_id <- '1'
field_season_id <- '1'
site_id <- '1'
treatment_id <- c(1, 2)


# REDUNDANT FILES: 
# plot_inventory <- read.csv(paste0(path, 'raw/Litter_plot_inventory_Wainwright.csv'), header = T,
#                            stringsAsFactors = F)  
# this file contains an inventory of all plots, including more plots than what is mentionned in the methods (154) ?? 
# other than that, redundant info
# Kunj_plot_level_annuals_only  <-  read.csv(paste0(path, 'raw/compiled_Kunj_plot_level_annuals_only.csv'), header = T,
#                                            stringsAsFactors = F)
# this file is the exact same as Kunj_plot_level, but with 10 fewer columns (9 non_annual plant species and Wallaby grass)
# Kunj_survey_Aug_2013  <-  read.csv(paste0(path, 'raw/compiled_Kunj_survey_Aug_2013.csv'), header = T,
#                                    stringsAsFactors = F)
# summary table of species densities - redundant
# Kunj_species_level_annuals_only  <-  read.csv(paste0(path, 'raw/compiled_Kunj_species_level_annuals_only.csv'), header = T,
#                                               stringsAsFactors = F)
# redundant species density info (annual species only)
# Kunj_rarefield_Aug_richness  <-  read.csv(paste0(path, 'raw/compiled_Kunj_rarefield_Aug_richness.csv'), header = T,
#                                           stringsAsFactors = F)
# this appears to be another redundant file of species densities
# focal_species_biomass <-  read.csv(paste0(path, 'raw/compiled_focal_species_biomass.csv'), header = T,
#                                    stringsAsFactors = F)
# this file just contains mean biomass measures of focal species ie. data analysis. Redundant info 

  
# Now on to the output 
########################

# projects table
#----------------
projects <- data.frame(project_id = project_id,
                       researcher = 'ClaireWainwright',
                       email = 'cewain@u.washington.edu',
                       study_sites = 'kunjin')
write.csv(projects, paste0(path, 'clean/projects.csv'), row.names = F)

# field season table  // UNFINISHED //
#--------------------
field_season <- data.frame(field_season_id = field_season_id,
                           project_id = project_id,
                           year = 2013,
                           crew = 'ClaireWainwright_XingwenLoy',
                           fs_max_temp_C = NA,  # not available in the collected data
                           fs_min_temp_C = NA,  # not available in the collected data
                           fs_mean_precip_mm = NA)   # not available in the collected data
write.csv(field_season, paste0(path, 'clean/field_season.csv'), row.names = F)

# trait summary table  
#---------------------
trait_summary <- data.frame(field_season_id = field_season_id,
                            traits = c('seed_mass', 'biomass'))
write.csv(trait_summary, paste0(path, 'clean/trait_summary.csv'), row.names = F)

# site table   // UNFINISHED //
#------------
site <- data.frame(site_id = site_id,
                   site = 'kunjin',
                   area = NA,
                   units = NA,
                   lat = NA,  # can be found in methods
                   long = NA, # can be found in methods
                   max_temp_C = NA,  # not available in the collected data - methods ? 
                   min_temp_C = NA,  # not available in the collected data - methods ? 
                   ann_precip_mm = NA)   # not available in the collected data - methods ? 


# treatment table   
#-----------------
treatment <- data.frame(treatment_id = treatment_id,
                        treatment = c('control', 'added_litter'))
write.csv(treatment, paste0(path, 'clean/treatment.csv'), row.names = F)

# plot table   // UNFINISHED //
#------------
# note: 120 plots total (see methods), but 9 were discarded due to animal damage

# gather the info
plots <- plot_level[, c('Block', 'Plot.ID', 'Treatment')]
# renumber & rename according to database framework
plots$Block <- as.factor(plots$Block)
levels(plots$Block) <- seq_along(levels(plots$Block))   # this ensures we have a key of plot IDs as per the database and 
# plot IDs as they are referred to in the raw data 
plots$plot <- as.factor(plots$Plot.ID)
levels(plots$plot) <- seq_along(levels(plots$plot))
plots[plots$Treatment == 'Control', ]$Treatment <- 'control'
plots[plots$Treatment == 'Litter', ]$Treatment <- 'added_litter'

# create the df
plot <- data.frame(plot_id = plots$plot,
                   field_season_id = field_season_id,
                   site_id = site_id,
                   block = plots$Block,
                   treatment_id = plots$Treatment,
                   lat = NA,  # there is a 'GPS.ID" column in the plot_level df but I don't know 
                   long = NA) # how that relates to actual GPS coordinates
write.csv(plot, paste0(path, 'clean/plot'), row.names = F)

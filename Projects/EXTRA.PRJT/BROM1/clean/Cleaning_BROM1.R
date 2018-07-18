# ########################################
# Project: Traits database
# Script to clean BROM1 project data 
# 
# author: Chrissy Elmer 
# date: July 2017
# #######################################

# Import the original datafile from 2014 ----
BROM1 <- read.csv("/Users/margiemayfield/Dropbox/Mayfield\ Lab/FunctionalTraitDatabase/Projects/BROM1/RAW/2014_bromus_plots.csv")
colnames(BROM1)
nrow(BROM1)
# Project Table ----
make_project <- function(id, researcher, email, study_site) {
    project <- data.frame("project_id"=id, 
                          "researcher"= researcher, 
                          "email"= email, 
                          "study_site" = study_site)
    return(project)
}
make_project("1", "Hao Ran", "", "Kunjin")


# Field Season Table ----
make_field_season <- function(id, project_id, year, crew) {
    field_season <- data.frame("field_season_id"=id,
                               "project_id" = project_id, 
                               "year" = year, 
                               "crew" = crew)
    return(field_season)
}
make_field_season("1", "1", "2014", "Hao Ran")

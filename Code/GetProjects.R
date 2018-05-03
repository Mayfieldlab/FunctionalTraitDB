
# -------------------------------------------------------------
# Code to combine project csvs for input into SQLite database
# 
# by Chrissy 2017
# -------------------------------------------------------------


## Libraries and Functions
library("reshape") # for merge_recurse()

group_db_data <- function(proj_folder, 
                          table_name, 
                          save_path, 
                          add_proj=FALSE) {
    # Combines all files of the same name from different project folders. Only 
    # works if all folders to be combined have the same name and column names.
    #
    # Args: 
    #   proj_folder:    Path name of the project folder
    #   table_name:     name of tables to be combined (should all be the same name)
    #   save_path:      path name for the save location and name of combined file
    #   add_proj:       if TRUE, adds project column to table, if FALSE, it doesn't. 
    #                   Default is FALSE
    #
    # Returns:
    #   A csv file in a given directory of the combined files. The .csv has no 
    #   row or solumn names for ease of import into SQLite database
    
    # access all project files with specific name
    folder_list <- list.files(proj_folder, 
                              recursive = TRUE, 
                              pattern = table_name, 
                              full.names = TRUE)
    
    # create a list of projects
    project_list <- list.files(proj_folder)
    
    #read.csv for each directory
    data_files <- lapply(folder_list, read.csv)
    
    # Add project code into table
    if (add_proj == TRUE) {
        for (i in 1:length(data_files)) {
            data_files[[i]]$project_title <- as.character(project_list[i])
        }
    }
    
    # Merge all data frames 
    all_projects <- merge_recurse(data_files)
    
    # give each row a unique identifier
    all_projects$project_id <- 1:nrow(all_projects)
    
    # Write table without row or column names (for easy import into SQLite db)
    write.table(all_projects, file = save_path, sep = ",", 
                row.names = FALSE, col.names = FALSE)
}


# Run function

# Project, with add_proj = TRUE
group_db_data("/Users/margiemayfield/Google\ Drive/FunctionalTraitDatabase/Construction/projects", 
              "projects.csv", 
              "/Users/margiemayfield/Google\ Drive/FunctionalTraitDatabase/Construction/final_tables/projects.csv", 
              add_proj = TRUE)

# Field season
group_db_data("/Users/margiemayfield/Google\ Drive/FunctionalTraitDatabase/Construction/projects",
              "field_season.csv", 
              "/Users/margiemayfield/Google\ Drive/FunctionalTraitDatabase/Construction/final_tables/field_season.csv",
              add_proj = FALSE)

# Site
group_db_data("/Users/margiemayfield/Google\ Drive/FunctionalTraitDatabase/Construction/projects",
              "site.csv", 
              "/Users/margiemayfield/Google\ Drive/FunctionalTraitDatabase/Construction/final_tables/site.csv",
              add_proj = FALSE)

# Treatment
group_db_data("/Users/margiemayfield/Google\ Drive/FunctionalTraitDatabase/Construction/projects",
              "treatment.csv", 
              "/Users/margiemayfield/Google\ Drive/FunctionalTraitDatabase/Construction/final_tables/treatment.csv",
              add_proj = FALSE)

# Plot
group_db_data("/Users/margiemayfield/Google\ Drive/FunctionalTraitDatabase/Construction/projects",
              "plot.csv", 
              "/Users/margiemayfield/Google\ Drive/FunctionalTraitDatabase/Construction/final_tables/plot.csv",
              add_proj = FALSE)
##################################
#     Code to subset species based on Johns 2010 and 2011 survey data. 
#     Species data will be used for Fuctional trait database 
#     by Chrissy Elmer 2017

# Load libraries ##### 
library(stringr) ## For str_split_fixed function

# Upload data and subset into required columns ####
#------------------------------------------------
john_species <-read.csv("/Users/cme/Google\ Drive/FunctionalTraitDatabase/Species/species_in_quadrat_scale_data_June_2017.csv")
john_species <- data.frame("species" = john_species$species, 
                           "life.form"=john_species$life.form, 
                           "invasive"=john_species$exotic)
head(john_species)



# Select only the rows with unique species ####
#-----------------------------------------
j_sub <-subset(john_species, !duplicated(species))
head(j_sub)

# Split "species" column to "Genus" and "Species" ####
#------------------------------------------------
genus_species <- data.frame(str_split_fixed(j_sub$species, "\\.", 2))
colnames(genus_species) <- c("genus", "species")
head(genus_species)

# Split "life.form" into "life_form" and "habit" ####
#------------------------------------------------
###   Some species have three eg. "tuberous.perennial.forb" 
lf_habit <- data.frame(str_split_fixed(j_sub$life.form, "\\.", 3))
colnames(lf_habit) <- c("life_form", "habit", "habit2")
lf_habit

    # fill in empty values with NA's and then omit them. 
lf_habit$habit2[lf_habit$habit2 == ""] <- NA
no_nas <- na.omit(lf_habit)
no_nas

    # get row numbers of those to delete later
row_nums <- rownames(no_nas)
row_nums

    # reformat to ensure columns are named correctly
reformat_lf_habit <- data.frame("life_form" = no_nas$habit, 
                                "habit" = paste(no_nas$habit2, no_nas$life_form, sep="+"))

    # delete original rows where the data is wrong based on the rownames 
update_lf_hab<- lf_habit[!rownames(lf_habit) %in% row_nums, ]
length(update_lf_hab$life_form)

    # delete last column, and add new rows
clean_lf_hab <- data.frame("life_form"=update_lf_hab$life_form,
                           "habit"=update_lf_hab$habit)

    # rbind the reformated lf_hab data to the clean_lf_hab data
clean_lf_hab <- rbind(clean_lf_hab, reformat_lf_habit)
length(clean_lf_hab$habit)

# Exotic: change all 1 to exotic, and 0 to native
#------------------------------------------------
j_sub$invasive[j_sub$invasive == 0] <- "native"
j_sub$invasive[j_sub$invasive == 1] <- "exotic"
head(j_sub, n=50)


# Final Species table ####
#---------------------
species <- data.frame("species_id", 
                      "family", 
                      "genus" =, 
                      "species", 
                      "invasive", 
                      "habit", 
                      "life_form")

family <- data.frame("family_id", 
                     "family")

genus <-data.frame("genus_id" = 1:length(unique(genus_species$genus)), 
                   "genus" = unique(genus_species$genus))

genus
invasive <- data.frame("invasive_id" = c(1, 2), 
                       "invasive" = c("native", "exotic"))

habit <- data.frame("habit_id" = 1:length(unique(clean_lf_hab$life_form)), 
                    "habit" = unique(clean_lf_hab$life_form))
head(habit)

life_form <- data.frame("life_form_id"= 1:length(unique(clean_lf_hab$habit)), 
                        "life_form"=unique(clean_lf_hab$habit))
life_form

# Function to get a list of unique species names from 'x' dataframe, and 'y' column name.
unique_species <- function(df, y) {
  sub = subset(df, !duplicated(y))
}

unique_species(john_species, species)




## CLAIRE's species data 
#-----------------------
claire_species <-read.csv("/Users/cme/Google\ Drive/FunctionalTraitDatabase/Species/Claire_species_20attributes_v2.csv")

claire_species2 <-read.csv("/Users/cme/Google\ Drive/FunctionalTraitDatabase/Species/TEM.Species.List_15_06_2017.csv")

colnames(john_species)
colnames(claire_species)
colnames(claire_species2)






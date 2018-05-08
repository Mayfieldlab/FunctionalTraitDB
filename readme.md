![](FinalSchema.png)

# **Mayfield Lab Functional Trait Database**
#### *Maylon Bimler, Cath Bowler, Lachalan Charles, Trace Martyn, Abigail Pastore, Isaac Towers*
#### *Mayfield Plant Ecology Lab PI: Prof. Margie Mayfield*
#### *University of Queensland*
##### *Initial commit: May 8, 2018*

***

## Introduction

This is a database that combines all completed datsets from projects that have individual-level trait data available. We have in this repository the data and code to create the SQLite database as well as example queries. 

This project was initialized with M. Bimler, C. Bowler, C. Elmer, and T. Martyn in May 2017 but was dropped during the field season and post. It has since been picked up by the above authors in May 2018. 

### Timeline for completion

Below is the *tentative* timeline for completion of the database (pre-2018 field season data aquistion).

* May 11 = T. Martyn send Mal current protocol.
* May 16 = M. Bimler and T. Martyn present current protocol to the group.
* May 16 = All receive assignments for projects.
* Jun 6 = All data cleaning is complete.
* Jun 6 = Assign tasks for data compling, DB assembly, DB check, QAQC, and example query making.
* Jun 29 = Functional trait datdabase is up-to-date to the best of everyone's knowledge
* Recurring = Update the protocol

## Adding new projects

Assign a new project a 4-letter code and sequential number identifier. For example: Watering project = **WATR1**. If another watering project is added later ten that proejct will be **WATR2**.

Next make a folder for that project labeled with the unique ID *(e.g. **WATR1**)*. Within that folder, place 2 sub-folder *'raw'* and *'clean'* (both names should be lowercase). Within the *'raw'* folder, you should place all raw data files relevent to the project	as well as a *'readme.txt'* that describes where those files were originally located	in the MayfieldLab Dropbox and what data are in each. Within the *'clean'* folder, you should have the R code file used to create the cleaned data csv's as well as multiple csvs for that project structured as the following.

### List of CSVs for each project

The files must be names exactly as listed below (in all lowercase) and have the same column headings.

* projects.csv
	+ project_id = a unique integer given to that project **(PKey)**
	+ project = a text string giving a title to the project *(e.g. Survey of 12 sites along a climatic gradient)*
	+ researcher = a text string noting the head PI/researcher for the proejct
	+ email = a text string noting the current email address of head PI
	+ study_sites = a text string listing the study sites of the project

* field_season.csv
	+ field_season_id = a unique integer given to the field season **(PKey)**
	+ project_id = **FKey** to *'projects'* table
	+ year = a 4-integer year identifying the year of the field season *(e.g. 2018)*
	+ crew = a text string listing the field crew with names separated by underscores *(e.g. JohnDwyer_ClaireWainwright)*
	+ fs_min_temp_C = the minimum temperature in ^o^C for the field season
	+ fs_max_temp_C = the maximum temperature in ^o^C for the field season 
	+ fs_mean_precip_mm = the mean precipitaiton over the field season period.

* site.csv
	+ site_id = unique integer for site **(PKey)**
	+ site = text string for site  name *(e.g. West Perenjori Nature Reserve)*
	+ area = area of the site (estimated is okay) *(e.g. 3)*
	+ units = units of the above estimation of site *(e.g. km2)*
	+ lat = latitude value of site
	+ long = longitude value of site
	+ max_temp_C = long term (30-yr) mean annual maximum temperature in ^o^C
	+ min_temp_C = long term (30-yr) mean annual minimum temperature in ^o^C
	+ ann_precip_mm = long term (30-yr) mean annual precipitation in mm

* treatment.csv
	+ treatment_id = unique integer for treatment **(PKey)**
	+ treatment = string text describing teatment

* trait_summary.csv
	+ field_season_id = **FKey** to *'field_season'* table
	+ traits = text string of traits that were collected in the field season seperated by underscore *(e.g. seedmass_sla_leafarea)*
* plot.csv
	+ plot_id = unique integer for plot **(PKey)**
	+ field_season_id = **FKey** to *'field_season'* table
	+ site_id = **FKey** to *'site'* table
	+ block = integer with block number *(if no block present fill with NULL)*
	+ plot_size_cm2 = numeric plot size in cm^2^
	+ plot_shape = text string noting shape *(e.g. circle or square)*
	+ treatment_id = FKey to 'treatment' table
	+ lat = latitude value for the plot *(if not present fill with NULL)*
	+ long = longitude value for the plot *(if not present fill with NULL)*

* individual.csv
	+ individual_id = unique integer for individual plant **(PKey)**
	+ plot_id = **FKey** to *'plot'* table
	+ species_id = **FKey** to *'species'* table

### List of potential environmental CSVs for plots

Below is a list of potential tables for various plot-level enviornmental characterstics.

* plant_avail_p.csv
* plant_avail_n.csv
* plant_avail_k.csv
* soil_ph.csv
* canopy_cover.csv
* per_woody_debris.csv
* per_litter.csv
* per_bareground.csv

#### Example environmental table
Below is an example table with column headings listed.

* plant_avail_p.csv
	+ plant_avail_p_id = unique integer for variable entry **(PKey)**
	+ plant_avail_p = text string describing the environmental variable
	+ plot_id = **FKey** to *'plot'* table
	+ soilp_kg_cm = numeric value for soil P
	+ date_collected = date sample was collected

### List of potential trait CSVs for individuals

Below is a list of potential tables for various individual-level traits.

* seed_mass.csv
* height.csv
* width.csv
* sla.csv
* leaf_area.csv
* leaf_dry_mass.csv

#### Example trait table
Below is an example table with column headings listed.

* seed_mass.csv
	+ seed_mass_id = unique integer for trait entry **(PKey)**
	+ individual_id = **FKey** to *'individual'* table
	+ seedmass_mg = numeric value of the trait
	+ date_collected = date sample was collected

***
### Potential future additions
* Include species-level trait values
* Include growth chamber/glasshouse experiments
* Add spatial data
* Others??
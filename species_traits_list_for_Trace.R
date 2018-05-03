# Species and traits list for Trace  #
######################################

# author: Malyon
# data: June 2017

# collating what traits we have for which species from the 
# LITT1, FACL1, SHAD1 and WATR1 projects so that Trace can 
# fill in the blanks in the field 

library(reshape2)
library(dplyr)

### The FACL1 project only collected traits on 1 species so I'm entering it manually 
facl1 <- data.frame(project = 'FACL1',
                    species = 'W.acuminata',
                    traits = c('plant_height', 'biomass', 'flower_number'))

### Add in the LITT1 stuff
# seed mass: 
Kunj_seed_mass_per_individual  <-  read.csv('~/Dropbox/Mayfield Lab/FunctionalTraitDatabase/Projects/LITT1/raw/compiled_Kunj_seed_mass_per_individual.csv',
                                            header = T, stringsAsFactors = F) 
litt1 <- data.frame(project = 'LITT1',
                    species = unique(Kunj_seed_mass_per_individual$Species),
                    traits = 'seed_mass')
# biomass: 
Kunjin_harvest_species <- read.csv('~/Dropbox/Mayfield Lab/FunctionalTraitDatabase/Projects/LITT1/raw/compiled_Kunjin_harvest_species.csv',
                                   header = T, stringsAsFactors = F) 
Kunjin_harvest_species <- Kunjin_harvest_species[is.na(Kunjin_harvest_species$Plant.biomass) == F, ] # remove NAs
litt1.2 <- data.frame(project = 'LITT1',
                      species = unique(Kunjin_harvest_species$Species),
                      traits = 'biomass')

### Next up is the shade data 
plant_level_data <- read.csv('~/Dropbox/Mayfield Lab/FunctionalTraitDatabase/Projects/SHAD1/raw/plant_level_data.csv',
                             header = T, stringsAsFactors = F)
tom_shade <- read.csv('~/Dropbox/Mayfield Lab/FunctionalTraitDatabase/Projects/SHAD1/raw/tom_shade.csv',
                     header = T, stringsAsFactors = F)
# in this project, traits were only collected on the focal individuals (and no on the neighbours)
# Claire's shade data
shad1.1 <- plant_level_data[ , c('Focal.sp', 'Height', 'Num.fl.total', 'Seedcount.extrap.integer')]
colnames(shad1.1) <- c('species', 'height', 'flower_number', 'seed_number')
shad1.1 <- melt(shad1.1, id.vars = 'species')
shad1.1 <- data.frame(project = 'SHAD1',
                      species = shad1.1$species,
                      traits =  shad1.1$variable)
shad1.1 <- unique(shad1.1)
# Tom's shade data
# rename species in tom's data 
tom_shade[tom_shade$species == 'h', ]$species <- 'H.glutinosum'
tom_shade[tom_shade$species == 'c', ]$species <- 'A.calendula'
tom_shade[tom_shade$species == 'p', ]$species <- 'P.airoides'
tom_shade[tom_shade$species == 'v', ]$species <- 'V.rosea'
shad1.2 <- tom_shade[ , c('species', 'Height', 'canopy.arch', 'Longest.Leaf', 'no.developed.flowers', 'Mean.seed.per.flower')]
colnames(shad1.2) <- c('species', 'height', 'canopy.arch', 'longest_leaf', 'flower_number', 'mean_seed_number_per_flower')
shad1.2 <- melt(shad1.2, id.vars = 'species')
shad1.2 <- data.frame(project = 'SHAD1',
                      species = shad1.2$species,
                      traits = shad1.2$variable)
shad1.2 <- unique(shad1.2)

### And finally for the watering data 
# I'm still waiting on Claire to get back to me before collating the raw data into the Project folder, so I'm using the files she sent me 
# for the coexistence project

# species_attributes <- read.csv('~/Dropbox/Work/Projects/2017_Coex_Envmt/1.data/raw/watering/species attributes_v2.csv',
#                               header = T, stringsAsFactors = F)
# species_attributes <- species_attributes[ , c('Correct.species.name', 'Mean.maxheight.Perenjori.2011.mm', 'Mean.maxheight.Bendering.2011.mm',
#                                               'Phenology.averaged.2011', 'Mean.canopy.shape.Perenjori', 'Mean.canopy.shape.Bendering')]
# I was going to include these traits until I realised they are averaged over the species (no individual trait data available for those)

plot_data <- read.csv('~/Dropbox/Work/Projects/2017_CoexEnvmt/1.data/raw/watering/2014 plot data cleaned up by Claire.csv',
                      header = T, stringsAsFactors = F)
# rename species
plot_data[plot_data$Focal.sp == 'A', ]$Focal.sp <- 'A.calendula'
plot_data[plot_data$Focal.sp == 'H', ]$Focal.sp <- 'H.glabra'
plot_data[plot_data$Focal.sp == 'W', ]$Focal.sp <- 'W.acuminata'
plot_data[plot_data$Focal.sp == 'T', ]$Focal.sp <- 'T.cyanopetala'
watr1 <- plot_data[ , c('Focal.sp', 'Aboveground.biomass.g', 'Belowground.biomass.g', 'Number.flowers.total', 'Seedcount.extrapolated.integer')]
colnames(watr1) <- c('species', 'above_biomass', 'below_biomass', 'flower_number', 'seed_number')
watr1 <- melt(watr1, id.vars = 'species')
watr1 <- na.omit(watr1)
watr1 <- data.frame(project = 'WATR1',
                    species = watr1$species,
                    traits =  watr1$variable)
watr1 <- unique(watr1)


### collate everything together: 
final.df <- rbind(facl1, litt1, litt1.2, shad1.1, shad1.2, watr1)
write.csv(final.df, '~/Dropbox/Mayfield Lab/FunctionalTraitDatabase/species_traits_list_MB.csv', row.names = F)


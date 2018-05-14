## Project - HOIR1 
## Collation started on 14 Jun 2017 by Trace Martyn
## Original file location in DROPBOX: >Mayfield Lab >Master Data Vault >Western Australia >Ring Plots (Mayfield_HilleRisLambers_Stouffer)



This project file ('complete.Rdata') contains estimated seed set (fecundity) data on 773 individuals of six focal annual plant species common to the York Gum woodlands in SW Western Australia. Seed set per focal plant was estimated for each plant by counting up the total number of flowers (or inflorescences) on each plant and multiplying that number by the average number of seeds produced per flower(infor.) using 1-3 flowers(inflor.) per plant.  In addition to seed production values, this dataset also includes the identity and abundance of all plants within a 7.5 cm radius around each focal plant. More details are available in the readme file and in the methods of the paper associated with this dataset.

######################################################
Info for complete.Rdata

This file contains an R list object, called fecundity.data, made up of six data frames, one per focal species. Each data frame is set up in the same way with the following columns:
Seeds, focal, site, quadrat, the name of each possible competitor species.

Row identifiers are unique identifiers for each focal plant.
“seeds”: contains the number of seeds produced by the focal plant in that row (this value is estimated from real field data -  see methods of associated paper methods for details)
“focal”: just tells you which focal species the focal plant is
“site”: tells you which site the focal plant was located in: K = Kunjin, B = Bendering
“quadrat”: is the quadrat number the focal plant is in, separate from the site.  There are generally three focal plants per quadrat so these numbers appear 1-3 times in each data frame.
Competitor columns (each the species name of a competitor species): data entered these columns are abundances – so 0 indicates that no plants of that species were present in the quadrat around that focal plant and any other number is the number of individuals in that neighbourhood.

The following is a sample work flow for this dataset using the R code (fit.fecundity.model.R) for which it is structured to work with.  This code is available from Margaret Mayfield or Daniel Stouffer and as a supplementary file (Data File 1) in the paper associated with this dataset: Higher-order interactions capture unexplained complexity in diverse communities.

####
# sample workflow for data analysis from manuscript
# this code fits the no competition, direct competition only, and direct and higher-order competition models to a sample dataset
####

## save the "complete.Rdata" file from Dryad in your working directory  
## save the "fit.fecundity.model.R" file accompanying the manuscript in your working directory

## setwd()## set this to suit your system

# load the data frame - example data provided or complete dataset from Dryad, code here for complete dataset
load('complete.Rdata')## list with one data.frame per focal species (six data.frames total)

# read in the model-fitting function - function provided with manuscript
source('fit.fecundity.model.R')

# fit a negative-binomial model without any effect of competition
null.model <- fit.fecundity.model(fecundity.data, type="negbin", fit.alphas=FALSE, fit.betas=FALSE)

# fit a negative-binomial model with direct competition only
alpha.model <- fit.fecundity.model(fecundity.data, type="negbin", fit.alphas=TRUE, fit.betas=FALSE)

# fit a negative-binomial model with direct competition and higher-order competition
beta.model <- fit.fecundity.model(fecundity.data, type="negbin", fit.alphas=TRUE, fit.betas=TRUE)



# Interface SQLlite3 and R 
# load library
library(RSQLite)
library(DBI)
library(sqldf)

home_dir<-getwd()
setwd("test_trait_database")
# connect to the sqlite file
con <- dbConnect(RSQLite::SQLite(), dbname="test_trait.db")

# get a list of all tables
alltables <- dbListTables(con)

# get the field season as a data.frame
p1 <- dbGetQuery( con,'SELECT * FROM field_season' )

# count the field seasons in the SQLite table
p2 <- dbGetQuery( con,'SELECT COUNT(*) FROM field_season' )

# find years of the field seasons
p3 <- dbGetQuery(con, "SELECT year FROM field_season")

#Clear the results of the last query
dbClearResult(p3)

#Select from the field season table just the years 2016
p4 <- dbGetQuery(con, "SELECT * from field_season WHERE year LIKE '2016'")

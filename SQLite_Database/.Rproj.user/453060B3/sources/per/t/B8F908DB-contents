# notes on creating a database from https://www.r-bloggers.com/r-and-sqlite-part-1/

library(RSQLite)
library(DBI)
library(sqldf)

## extract the home directory
home_dir<-getwd()
## set the working directory
setwd("test_trait_database")
## make a new folder to test R creating databases in 
# system("mkdir testing_R_db")
## reset the working directory
setwd("testing_R_db")

## make a new database
db <- dbConnect(SQLite(), dbname="Test.species.sqlite")

## write in the tables for tha database
dbWriteTable(conn = db, name = "life_form", value = "life_form.csv",
             row.names = FALSE, header = TRUE)
dbWriteTable(conn = db, name = "family", value = "family.csv",
             row.names = FALSE, header = TRUE)
dbWriteTable(conn = db, name = "invasive", value = "invasive.csv",
             row.names = FALSE, header = TRUE)
dbWriteTable(conn = db, name = "species", value = "species.csv",
             row.names = FALSE, header = TRUE)
dbWriteTable(conn = db, name = "genus", value = "genus.csv",
             row.names = FALSE, header = TRUE)
dbWriteTable(conn = db, name = "habit", value = "habit.csv",
             row.names = FALSE, header = TRUE)

## check the list of tables in the database
dbListTables(db)                

## query a dataframe of genus and species native status
species.status<-dbGetQuery(db, "SELECT * FROM genus,invasive INNER JOIN species ON species.genus_id = genus.genus_id AND species.invasive_id = invasive.invasive_id")

## clean the dataframe by remove the rows with "_id"
species.status.clean<-species.status[,-grep("id",names(species.status))]



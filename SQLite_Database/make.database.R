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

#############
## make a fake database to test
## using the RSQLite package
db <- dbConnect(SQLite(), dbname="Test.sqlite")
## using the sqldf pacakge
sqldf("attach 'Test1.sqlite' as new")

###############
## adding data to the database the hard way
dbSendQuery(conn = db, "CREATE TABLE School (SchID INTEGER, Location TEXT,
              Authority TEXT, SchSize TEXT)")
dbSendQuery(conn = db, "INSERT INTO School VALUES (1, 'urban', 'state', 'medium')")
dbSendQuery(conn = db, "INSERT INTO School VALUES (2, 'urban', 'independent', 'large')")
dbSendQuery(conn = db, "INSERT INTO School VALUES (3, 'rural', 'state', 'small')")

## list tables in the database
dbListTables(db)            
## list columsn in the school table
dbListFields(db, "School")
## look at the data in the table
dbReadTable(db, "School")     

## remove the school table
dbRemoveTable(db, "School") 

#######################
## adding data to the database the easy way
dbWriteTable(conn = db, name = "Student", value = "student.csv",
             row.names = FALSE, header = TRUE)
dbWriteTable(conn = db, name = "Class", value = "class.csv",
             row.names = FALSE, header = TRUE)
dbWriteTable(conn = db, name = "School", value = "school.csv",
             row.names = FALSE, header = TRUE)

## list tables in the database
dbListTables(db)            
## list columsn in the school table
dbListFields(db, "School")
## look at the data in the table
dbReadTable(db, "School")     

######################
## also read the csvs in as df first in R
dbRemoveTable(db, "School")   # Remove the tables
dbRemoveTable(db, "Class")
dbRemoveTable(db, "Student")

School <- read.csv("school.csv")  # Read csv files into R
Class <- read.csv("class.csv")
Student <- read.csv("student.csv")

# Import data frames into database
dbWriteTable(conn = db, name = "Student", value = Student, row.names = FALSE)
dbWriteTable(conn = db, name = "Class", value = Class, row.names = FALSE)
dbWriteTable(conn = db, name = "School", value = School, row.names = FALSE)

dbListTables(db)                 # The tables in the database
dbListFields(db, "School")       # The columns in a table
dbReadTable(db, "School")        # The data in a table

# dbGetQuery(conn, "CREATE TABLE Data (DataID integer primary key autoincrement, 
#            DataTypeID integer, DataName varchar)")

dbGetQuery(db, "SELECT * FROM School CROSS JOIN Student WHERE Gender = 'female' ")

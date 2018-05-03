This project involved one field season in 2013

Data collected by Claire Wainwright and Xingwen Loy
Methods should be described in the publication listed below. 

### Files: 

publication1.pdf: Claire, JD and MM's publication for this data. Contains methods. Full reference at the bottom

# /raw folder: 
/claire_IEM_assays_2013.xls: results from deploying ion exchange membranes in each plot (IEMs) to test whether nitrate and ammonium cycling rates differed among treatment and control plots
/IEM extraction.xlsx: list of plot names and corresponding sample labels for the experiment above 
*** those 2 files contain IEM data for plots from both the FACL1 and LITT1 projects - we will have to match plot numbers to figure out which are from which ***
note: the IEM data seems to be repeated in some of the sheets from the Litter_expt_Wainwright_compiled_170619.xlsx file ?? 

/Litter_expt_Wainwright_compiled_170619.xlsx 
/Litter plot inventory Wainwright.xlsx
/litter plot level Wainwright 20aug14.xlsx
All the field data (plants & traits) for this project is contained in the 3 files above - any other 'litter project' files present in the Dropbox are redundant.

All files were copied from Mayfield Lab/Master Data Vault/Western Australia/Wainwright/Litter on 21/06/2017

Those files were then saved as .csv files for cleaning in R. 
The .xlsx and .csv file names match. 
Any 'compiled_xxx.csv' file is a sheet saved from the /Litter_expt_Wainwright_compiled_170619.xlsx, with 'xxx' standing for the sheet name

# /clean folder: 
/cleaning_LITT1.R: script to clean raw data files for input into database
database-ready data are saved as .csv, with one file for each database table. 
see databaseschema.png for a reference of table names and what they each contain

** Claire is (hopefully) writing up some metadata **


Publications: 
Wainwright, Claire E., John M. Dwyer, and Margaret M. Mayfield. "Effects of exotic annual grass litter and local environmental gradients on annual plant community structure." Biological Invasions 19.2 (2017): 479-491.


-- Malyon 21/06/2017
-- extra comments Malyon 22/06/2017

This project involved both 1 field season in 2013 and one growth chamber experiment. 

** I'm not sure how we want to incorporate the growth chamber experiment data though I guess that's a problem for another day **

Data collected by Claire Wainwright, Xingwen Loy, Angela Gardner, Lalita Fitriani
Methods should be described in the draft manuscript present in this folder.

NOTE: This project also incorp[orated data from the HOIR1 project (ring data) - described as Kunjin field data in the methods

### Files:

/Wainwright_Facilitation_JEcol_20feb17.docx: draft manuscript for publication using this data, emailed by Claire on 20/06/2017. Should contain methods.

# /raw folder:
/claire_IEM_assays_2013.xls: results from deploying ion exchange membranes in each plot (IEMs) to test whether nitrate and ammonium cycling rates differed among treatment and control plots
/IEM extraction.xlsx: list of plot names and corresponding sample labels for the experiment above 
*** those 2 files contain IEM data for plots from both the FACL1 and LITT1 projects - we will have to match plot numbers to figure out which are from which ***
copied from Mayfield Lab/Master Data Vault/Western Australia/Wainwright/Litter on 21/06/2017

/Waitzia.grass.data.2014.15dec14.xlsx: contains both field data and growth chamber data. Field data are the sheets with the prefix 'field', growth chamber data are the sheets with the prefix 'UQ'
copied from Mayfield Lab/Master Data Vault/Western Australia/Wainwright/Facilitation on 21/06/2017

Those files were then saved as .csv files for cleaning in R. The .csv file names match the sheet names in Waitzia.grass.data.2014.15dec14.xlsx 
As previously, field data are prefixed by 'field', growth chamber data are prefixed by 'UQ'.

Some sheets were not saved as .csv files because they contain analysis rather than raw data, or redundant data that wasn't used in the analyses (“Sheet 1”, “field unmanip plots WAAC” (this is actually from the Bendering experiment BEND1), “UQ sp lvl”, “UQ means”, “field means for plotting”, “model coefs”, “HOI calcs”, and “Sheet 2”)

# /clean folder: 
/cleaning_FACL1.R: script to clean raw FIELD data files for input into database
database-ready data are saved as .csv, with one file for each database table. 
see databaseschema.png for a reference of table names and what they each contain


** Claire is (hopefully) writing up some metadata **


Publications: 
In prep, draft is in folder (/Wainwright_Facilitation_JEcol_20feb17.docx)


-- Malyon 21/06/2017
-- comments on 23/06/2017

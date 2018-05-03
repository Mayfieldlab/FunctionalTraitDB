/* 
	 MAYFIELD LAB
	 -------------
	 FUNCTIONAL TRAIT DATABASE SCHEMA 2017
	 chrissy elmer
*/

-- Change working directory to .db location then:
sqlite3 databasefile.db

-- Use these statements to display your query as a table
.headers on 
.mode columns 

-- To view constraints of table created
select sql from sqlite_master where type='table' and name='demo_tab';

-- to Query multiple tables 
SELECT ... FROM table1 NATURAL JOIN table2... NATURAL JOIN table3 ...

-- to Query specific columns on multiple tables 
SELECT block, plot, site.site, treatment.treatment FROM plot 
LEFT OUTER JOIN treatment ON plot.treatment = treatment.id 
LEFT OUTER JOIN site ON plot.site = site.id;


--------------------------------------------------------------------------------------------------

-- DATABASE CONSTRUCTION AND CONSTRAINTS
CREATE TABLE projects (
project_id integer PRIMARY KEY, 
researcher text NOT NULL, 
email text NOT NULL, 
site text NOT NULL);

INSERT INTO projects (project_id, researcher, email, site)
VALUES (1, 'chrissy elmer', 'c.elmer@uq.edu.au', 'Tasmania');

INSERT INTO projects (project_id, researcher, email, site)
VALUES (2, 'cath bowler', 'c.bowler@uq.edu.au', 'WA');

CREATE TABLE field_season ( 
fs_id integer PRIMARY KEY, 
project_id integer, 
year integer NOT NULL, 
crew_list text NOT NUll, 
FOREIGN KEY(project_id) REFERENCES projects(project_id));

INSERT INTO field_season VALUES (1, 1, 2016, 'Chrissy, Loy, Leander, Hannah, Ian');
INSERT INTO field_season VALUES (2, 1, 2017, 'Chrissy, Loy, Leander, Hannah, Ian');
INSERT INTO field_season VALUES (3, 2, 2015, 'Cath, Trace, Maia, Margie');
INSERT INTO field_season VALUES (4, 2, 2016, 'Cath, Trace, Maia, Margie');



CREATE TABLE traits ( 
trait_id integer PRIMARY KEY, -- probably don't need the trait_id column
fs_id integer, 
traits text NOT NULL, 
FOREIGN KEY(fs_id) REFERENCES field_season(fs_id));

INSERT INTO traits VALUES (1, 1, 'SLA, leaf area, RTD'), 
(2, 2, 'biomass, leaf area, RTD'), 
(3, 3, 'L:S, leaf area, RTD'), 
(4, 4, 'SLA, height, RTD');

-------
CREATE TABLE site (
id integer NOT NULL PRIMARY KEY, 
site text NOT NULL, 
area_km2 integer,
longitude integer,
latitude integer,
max_temp integer, 
min_temp integer, 
ann_precip_mm integer);

INSERT INTO site VALUES (1, 'bendering', 300, 152.00000, 27.00000, 2, 1, 100);
INSERT INTO site (id, site) VALUES (2, 'Kunjin');


-------
CREATE TABLE treatment ( 
id integer NOT NULL PRIMARY KEY, 
treatment text NOT NULL);

INSERT INTO treatment VALUES (1, 'control'), 
(2, 'water'), 
(3, 'shade'), 
(4, 'density_30'), 
(5, 'density_60');


--------
CREATE TABLE plot (
plot_id integer PRIMARY KEY,
fs_id integer NOT NULL,
site text NOT NULL,
block integer NOT NULL,
plot integer NOT NULL,
treatment text,
FOREIGN KEY(fs_id) REFERENCES field_season(fs_id), 
FOREIGN KEY(site) REFERENCES site(site), 
FOREIGN KEY(treatment) REFERENCES treatment(id));

INSERT INTO plot VALUES (1, 1, 1, 1, 1, 1);
INSERT INTO plot VALUES (2, 1, 1, 1, 2, 2);
INSERT INTO plot VALUES (3, 1, 1, 2, 1, 1);
INSERT INTO plot VALUES (4, 1, 1, 2, 2, 2);

INSERT INTO plot VALUES (5, 1, 2, 1, 2, 2), (6, 2, 2, 1, 2, 2), (7, 1, 2, 1, 1, 1);


------
CREATE TABLE soil_moisture ( 
	id PRIMARY KEY,
	plot_id integer,
	value integer NOT NULL,
	unit text NOT NULL,
	date_collected text, 
	FOREIGN KEY(plot_id) REFERENCES plot(plot_id));

INSERT INTO soil moisture VALUES (1, 1, 33, '%', '3/1/17');



--------
CREATE TABLE family  (
	id integer NOT NULL PRIMARY KEY, 
	family text NOT NULL);

INSERT INTO family VALUES (1, asteraceae), (2, goodeniaceae);


CREATE TABLE invasive (
	id integer NOT NULL PRIMARY KEY, 
	invasive NOT NULL);

INSERT INTO invasive VALUES (1, native), (2, exotic);


CREATE TABLE habit (
	id integer NOT NULL PRIMARY KEY, 
	habit text NOT NULL);

INSERT INTO habit VALUES (1, graminoid), (2, forb);


CREATE TABLE life_form  (
	id integer NOT NULL PRIMARY KEY, 
	life_form text NOT NULL);

INSERT INTO life_form VALUES (1, annual), (2, biannual), (3, perennial);



-------
CREATE TABLE species (
	species_id integer PRIMARY KEY,
	family text NOT NULL REFERENCES family(id), 
	genus text NOT NULL, 
	species text NOT NULL, 
	invasive integer REFERENCES invasive(id), 
	habit integer REFERENCES habit(id),
	life_form integer REFERENCES life_form(id));

INSERT INTO species VALUES (1, 1, 'Arctotheca', 'calendula', 1, 2, 1)


-------
CREATE TABLE individual (
	indv_id integer PRIMARY KEY, 
	species_id integer NOT NULL, 
	plot_id integer NOT NULL, 
	FOREIGN KEY(species_id) REFERENCES species(species_id), 
	FOREIGN KEY(plot_id) REFERENCES plot(plot_id));




CREATE TABLE sla ( 
	indv_id integer PRIMARY KEY,
	value integer NOT NULL,
	unit text NOT NULL,
	date_collected text, 
	FOREIGN KEY(indv_id) REFERENCES individual(indv_id));
---------------
-- SQL GUIDE 
--------------
-- all lines must end in ";"" unless they're preceeded by "."


-- Create table 
CREATE TABLE projects (
project_id integer PRIMARY KEY, 
researcher text NOT NULL);


-- Insert values 
INSERT INTO projects VALUES 
(3, 'Claire Wainwright; Hao Ran', 'claire.wainwright@uq.net.au', 'BEND1'),
(4, 'Hao Ran; Steph', '', 'BEND1');


-- Add column
ALTER TABLE contacts ADD COLUMN age integer;


-- Update values 
UPDATE contacts SET age = 22.9 WHERE proj_id = 1;


-- CREATE UNIQUE INDEX
CREATE UNIQUE INDEX id ON projects(site);

-- REPLACE means insert or replace (not update!)
REPLACE INTO projects(id, researcher) VALUES (1, 'Chrissy')


-- import csv
.mode csv
.import /filename tablename -- if no existing table, it will use headers for column names
.schema tablename


-- export table as csv
ec

-- create trigger
ALTER TABLE employee ADD COLUMN updatedon date;
# vi employee_update_trg.sql
CREATE TRIGGER employee_update_trg AFTER UPDATE ON employee
BEGIN 
	UPDATE employee SET updatedon = datetime('NOW') WHERE rowid = new.rowid;
END;
company.db < employee_update_trg.sql


-- create view, this creates a new table
create view empdept as select empid, e.name, title, d.name, location from employee e, dept d where e.deptid = d.deptid;
	select * from empdept


explain query plan SELECT * FROM empdept;

-- savepoint and roll back 
SAVEPOINT major;
-- make some changes but decide you don't want them 
ROLLBACK to SAVEPOINT major;


-- UNION QUERY
SELECT empid, name, title FROM c1.employee UNION SELECT empid, name, title from c2.employee;


/* 
	SQLite Tutorial 
	----------------
		Create a database, add a table and values, update the table and add new columns
		https://www.tutorialspoint.com/sqlite/sqlite_update_query.htm 
*/


/* create a database */
sqlite3 testdb.db 


/* Create a table
the blue bits = type of input
	null = null value 
	integer = number
the red bits = contraints
	not null = row in column must have a value 
	UNIQUE = every row in that column must be unique */


CREATE TABLE contacts (
	contact_id integer PRIMARY KEY, 
	first_name text NOT NULL, 
	last_name text NOT NULL, 
	email text NOT NULL UNIQUE, 
	phone text NOT NULL UNIQUE
);



/* INSERT DATA INTO TABLE */
INSERT INTO contacts (contact_id, first_name, last_name, email, phone)
VALUES (1, 'chrissy', 'elmer', 'c.elmer@uq.edu.au', '0474808044');

/* ALTER TABLE TO ADD NEW COLUMN and value */ 
ALTER TABLE contacts ADD COLUMN age integer;

UPDATE contacts SET age = 22.9 WHERE first_name = 'chrissy'

DELETE FROM table WHERE id = 2;

/* Querying the database
	Column view */ 
.header on
.mode column
.width 12 6

SELECT * from contacts;


-- JOINING TABLES 
-------------------
--from tables 
company (id, name, age, address, salary)
department (id, dept, emp_id)



-- CROSS JOIN 
SELECT ... FROM table1 CROSS JOIN table2 ...
-- eg. 
SELECT emp_id, name, dept FROM company CROSS JOIN department;



-- INNER JOIN
SELECT ... FROM table1 JOIN table2 USING (column1, column2...)
-- or
SELECT ... FROM table1 INNER JOIN table2 ON conditional_expression ...

-- eg. 
SELECT emp_id, name, dept FROM company INNER JOIN department ON company.id = department.emp_id 




-- NATURAL JOIN (automatically tests for equality between the values of every column in both tables)
SELECT ... FROM table1 NATURAL JOIN table2...


select student.student_name, exams.exam_code, ...
from student
join wrote_exam using (student_number)
join exams using (exam_code)
where ...
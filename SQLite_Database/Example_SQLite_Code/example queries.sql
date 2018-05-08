---------------------------------------------

-- Mayfield Lab Functional Trait database 

-- example queries

---------------------------------------------

-- Summary table of project, field season and traits 
select projects.project_id, researcher, email, site, trait_summary.fs_id, year, crew_list, traits from projects 
join field_season on projects.project_id = field_season.project_id 
join trait_summary on trait_summary.fs_id = field_season.fs_id;

-- add this to be site specific
WHERE site = 'Tasmania';



-- Select plots based on site and treatment
-- Select the column names you want in format table.column (if not from base table)
-- select where to join (this is the primary and foreign key talking to each other)

select plot_id, fs_id, site.site, block, treatment.treatment from plot
join site on plot.site = site.id
join treatment on plot.treatment = treatment.id;


select family.family, genus.genus, species, invasive.invasive, habit.habit, life_form.life_form from species 
join family on species.family = family.family_id
join genus on species.genus = genus.genus_id
join invasive on species.invasive = invasive.invasive_id
join habit on species.habit = habit.habit_id
join life_form on species.life_form = life_form.life_form_id;


SELECT table1.col1, table1.col2, col3 FROM table1
JOIN col3 on table1.col3 = table2.col2;


--table1 = species 
col1 = id
col2 = species
col3 = traits


--table2 = traits
col1 = traits_id
col2 = traits


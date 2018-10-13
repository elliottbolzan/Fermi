We created database tables in a file called kondria.sql, which is also included in this zip. In this file, we create the tables Category, Disease, Condition, Profile, AssociatedWith, OfType, Symptom, and Has. We also created sample data in the file load.sql. 

To create the database in the shell, run:
createdb kondria

To load the tables into the database, run:
psql kondria -af create.sql

To load the sample data into these tables, run:
psql kondria -af load.sql

To run the database, run:
psql kondria

#################################
# SELECT
#################################

SELECT title, year FROM movies;
SELECT year FROM movies;

SELECT * FROM movies WHERE year = 2022;
SELECT * FROM movies WHERE year < 2022;

SELECT * FROM movies WHERE year < NOW();

SELECT * FROM movies WHERE year IS NOT NULL;

SELECT * FROM movies WHERE 1 = 1;
SELECT * FROM movies WHERE 2 * 2 = 4;
SELECT * FROM movies WHERE TRUE;

SELECT * FROM movies ORDER BY title;
SELECT * FROM movies ORDER BY year;
SELECT * FROM movies ORDER BY year ASC;
SELECT * FROM movies ORDER BY year DESC;


#################################
# INSERT
#################################

INSERT INTO movies (title, year) VALUES ("The Cremator", 1965);
INSERT INTO movies VALUES ("The Cremator", 1965);

INSERT INTO movies (title) VALUES ("The Cremator");

# Won't work because title is defined as NOT NULL
# INSERT INTO movies (year) VALUES (1293);


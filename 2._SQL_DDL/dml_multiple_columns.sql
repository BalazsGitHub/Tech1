SELECT year FROM movies;

SELECT title, year FROM movies;

SELECT * FROM movies WHERE year = 2022;

SELECT * FROM movies WHERE year < 2022;

SELECT * FROM movies WHERE year < NOW();

SELECT * FROM movies WHERE 1 = 1;

SELECT * FROM movies WHERE year IS NOT NULL;

SELECT * FROM movies WHERE TRUE;

SELECT * FROM movies ORDER BY year;

SELECT * FROM movies ORDER BY year ASC;

SELECT * FROM movies ORDER BY year DESC;

SELECT * FROM movies ORDER BY title;


INSERT INTO movies (title, year) VALUES("The Cremator", 1965);
INSERT INTO movies (title) VALUES("The Cremator");
INSERT INTO movies VALUES("The Cremator", 1965);




INSERT INTO movies(title) VALUES ("Nemo");

SELECT * FROM movies WHERE title = "Die hard";


DELETE FROM movies WHERE BINARY title = "Nemo";

DELETE FROM movies WHERE title = "Nemo" LIMIT 5;

INSERT INTO movies VALUES ("Don't look up");

SELECT * FROM movies;

SELECT * FROM movies WHERE title = "Nemo" LIMIT 1;

UPDATE movies SET title = "King Kong vs. Godzilla" WHERE title = "King Kong";
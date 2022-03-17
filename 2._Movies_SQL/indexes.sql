#todo create an index on movie ids
#and another one on movies.title

#Pros: SELECT is much faster
#Cons: INSERT, UPDATE, DELETE is much slower

CREATE INDEX movies_ids
ON movies (id);

CREATE INDEX movies_titles
ON movies (title);

CREATE INDEX movies_ids_titles
ON movies (id, title);

DROP INDEX index_1
ON movies;

SHOW INDEX
FROM movies;

SHOW ENGINES;

SELECT * FROM movies WHERE title = 'Finding Nemo';
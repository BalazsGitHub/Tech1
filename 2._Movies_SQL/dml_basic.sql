
# CRUD
############################
# Read
############################

# Read this as read all entries (rows) from the table movies
# * is a wildcard for ALL
SELECT * FROM movies;
SELECT * FROM movies WHERE title = "Die hard";
# Binary enforces case sensitivity
SELECT * FROM movies WHERE BINARY title = "king Kong";

SELECT * FROM movies WHERE title = "Don't Look Up" LIMIT 1;

############################
# Create
############################
INSERT INTO movies (title) VALUES ("Don't Look Up");
INSERT INTO movies VALUES ("Interstellar");


############################
# Update
############################

# Update King Kong to be King Kong Vs. Godzilla
UPDATE movies
SET title = "King Kong vs. Godzilla"
WHERE title = "King Kong";


############################
# Delete
############################

DELETE FROM movies WHERE title = "Don't Look Up";

DELETE FROM movies WHERE title = "Don't Look Up" LIMIT 5;


SHOW TABLES;

CREATE TABLE IF NOT EXISTS movies (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    year YEAR
);


CREATE TABLE IF NOT EXISTS directors (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255),
    movie_id INT,
    FOREIGN KEY (movie_id) REFERENCES movies(id)
    title VARCHAR(255) PRIMARY KEY -- NOT NULL and UNIQUE is not necessary as Primary key already sets it to not null
);

CREATE TABLE IF NOT EXISTS movies(
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    year YEAR
);

CREATE TABLE IF NOT EXISTS actors (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(255)
);

CREATE TABLE IF NOT EXISTS movies_actors (
    id INT AUTO_INCREMENT PRIMARY KEY,
    movie_id INT,
    actor_id INT,
    FOREIGN KEY (movie_id) REFERENCES movies(id),
    FOREIGN KEY (actor_id) REFERENCES actors(id)
);

CREATE TABLE IF NOT EXISTS production_teams (
    id INT AUTO_INCREMENT PRIMARY KEY,
    team_name VARCHAR(255)
);

CREATE TABLE IF NOT EXISTS movies_production_teams (
    id INT AUTO_INCREMENT PRIMARY KEY,
    movie_id INT,
    production_team_id INT,
    FOREIGN KEY (movie_id) REFERENCES movies(id) ON DELETE CASCADE,
    FOREIGN KEY (production_team_id) REFERENCES production_teams(id) ON DELETE CASCADE
);





#Create directors table
CREATE TABLE IF NOT EXISTS directors(
    id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(255),
    last_name VARCHAR(255)
);

# Create a foreign key to director that points to movies
-- ALTER TABLE directors ADD COLUMN f_key INTEGER UNIQUE ;
-- ALTER TABLE directors ADD FOREIGN KEY (f_key) REFERENCES movies (id);

CREATE TABLE directors(
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255),
    movie_id INT,
    FOREIGN KEY (movie_id) REFERENCES movies(id)
);

# Create the table actors and set up the correct relation
CREATE TABLE IF NOT EXISTS actors(
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255));

CREATE TABLE actors (
    actor_ID INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255),
    movie_ID INT,
 FOREIGN KEY (movie_ID) references movies(movie_ID));

/*create table movies_actors(
    movie_actor_id INT AUTO_INCREMENT,
    movie_id       INT NOT NULL,
    actor_id       INT NOT NULL,
    CONSTRAINT movie_actors_pk
    PRIMARY KEY (movie_actor_id),
    FOREIGN KEY (movie_id) REFERENCES movies(movie_id),
    FOREIGN KEY (actor_id) REFERENCES actors(actor_id));*/

CREATE TABLE IF NOT EXISTS movies_actors(
    id INT AUTO_INCREMENT PRIMARY KEY,
    movie_id INT NOT NULL,
    actor_ID INT NOT NULL,
    FOREIGN KEY (movie_id) REFERENCES movies (id),
    FOREIGN KEY (actor_ID) REFERENCES actors (id)
);


#Create a SELECT query that shows the title, year and name of the actors
SELECT movies.title, movies.year, actors.name
FROM movies
INNER JOIN actors on movies.id = actors.id;


CREATE TABLE IF NOT EXISTS production_teams(
    id INT AUTO_INCREMENT PRIMARY KEY,
    team_name VARCHAR(255));

#Creating many to many connection
CREATE TABLE IF NOT EXISTS movies_production_teams(
    id INT AUTO_INCREMENT PRIMARY KEY,
    movie_id INT,
    production_team_id INT,
    FOREIGN KEY  (movie_id) REFERENCES movies(id) ON DELETE CASCADE,
    FOREIGN KEY (production_team_id) REFERENCES production_teams(id) ON DELETE CASCADE);

#(Cascade deletion)
#UPDATE CASCADE

#Create an insert statement in movies_production_teams
INSERT INTO production_teams(team_name)
VALUES ('A-team');
INSERT INTO movies_production_teams(movie_id, production_team_id)
VALUES (3, 1);

#Delete the relationship of production team A
ALTER TABLE production_teams
DROP CONSTRAINT movies_production_teams.movies_production_teams_ibfk_1;

DELETE FROM production_teams
WHERE id = 1;


ALTER TABLE movies
ADD COLUMN ID INTEGER AUTO_INCREMENT UNIQUE NOT NULL;

ALTER TABLE movies
ADD COLUMN year YEAR NOT NULL AFTER title;

ALTER TABLE movies DROP COLUMN year;

ALTER TABLE movies MODIFY year INT(4);



DROP TABLE movies;

# DATABASES,TABLES,COLUMNS vs. DATA (in ROWS)
# DDL                      vs. DML
# CRUD




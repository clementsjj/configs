CREATE schema devopstest;
USE devopstest;
SELECT DATABASE();

#######################
# Create People Table #
#######################
CREATE TABLE people (
    personID INT NOT NULL AUTO_INCREMENT,
    fname VARCHAR(50),
    age INT,
    PRIMARY KEY (personID)
);
SHOW TABLES;
DESCRIBE People;

INSERT INTO people(fname, age) VALUES ('Alan', 30), ('Betty', 25), ('Christy', 35), ('Dave', 45), ('Elmo', 40);

insert into people(fname, age) values ('Fritz', 30);

SELECT * FROM people;


######################
# Create Bikes Table #
######################
CREATE TABLE bikes (
    bikeID INT NOT NULL AUTO_INCREMENT,
    bikeMake VARCHAR(50) NOT NULL,
    color VARCHAR(50) NOT NULL,
    IDperson int,
    FOREIGN KEY (IDperson) REFERENCES people(personID),
    PRIMARY KEY (bikeID)
);
SHOW TABLES;
DESCRIBE people;
# Need to add an ID column so that we can have a primary key
# Otherwise percona will throw an error saying everything needs a primary key
ALTER TABLE bikes ADD COLUMN `id` int(10);
# Assign the new column to be the primary key
ALTER TABLE bikes MODIFY COLUMN `id` INT(10) UNSIGNED PRIMARY KEY AUTO_INCREMENT;

ALTER TABLE bikes ADD PRIMARY KEY(id)

INSERT INTO bikes(bikeMake, color, IDperson) VALUES ('Trek', 'Red', 3);
INSERT INTO bikes(bikeMake, color, IDperson) VALUES ('Spin', 'Black', 6),('Centurion', 'Orange', 9),('Specialized', 'Purple', 12),('Cannondale', 'Green', 15);
SELECT * FROM bikes;



#########################
# Create Location Table #
#########################
CREATE TABLE location (
    locationID INT NOT NULL AUTO_INCREMENT,
    neighborhood VARCHAR(50),
    city VARCHAR(50),
    IDperson INT NOT NULL,
    FOREIGN KEY (IDperson) REFERENCES people(personID),
    PRIMARY KEY (locationID)
);
SHOW TABLES;
DESCRIBE people;

INSERT INTO location(neighborhood, city, IDperson) VALUES ('Columbia Heights', 'Washington, DC', 3), ('Bushwick', 'Brooklyn', 6),('Shaw', 'Washington, DC', 9),('Red Hook', 'Brooklyn', 12),('East Village', 'Manhattan', 15);



CREATE TABLE fun (id INT);


RENAME TABLE fun TO dumb;


------------------
INNER JOIN = Return all rows from multiple tables where the condition is met.


CREATE schema devopstest;
USE devopstest;
SELECT DATABASE();

#######################
# Create People Table #
#######################
CREATE TABLE People (
    PersonID INT NOT NULL AUTO_INCREMENT,
    FName VARCHAR(50),
    Age INT,
    PRIMARY KEY (PersonID)
);
SHOW TABLES;
DESCRIBE People;

INSERT INTO People(FName, Age) VALUES ('Alan', 30), ('Betty', 25), ('Christy', 35), ('Dave', 45), ('Elmo', 40);
SELECT * FROM People;


######################
# Create Bikes Table #
######################
CREATE TABLE Bikes (
    BikeMake VARCHAR(50) NOT NULL,
    Color VARCHAR(50) NOT NULL,
    IDPerson int,
    FOREIGN KEY (IDPerson) REFERENCES People(PersonID)
);
SHOW TABLES;
DESCRIBE People;
# Need to add an ID column so that we can have a primary key
# Otherwise percona will throw an error saying everything needs a primary key
ALTER TABLE Bikes ADD COLUMN `id` int(10);
# Assign the new column to be the primary key
ALTER TABLE Bikes MODIFY COLUMN `id` INT(10) UNSIGNED PRIMARY KEY AUTO_INCREMENT;

ALTER TABLE Bikes ADD PRIMARY KEY(id)

INSERT INTO Bikes(BikeMake, Color, IDPerson) VALUES ('Trek', 'Red', 3);
INSERT INTO Bikes(BikeMake, Color, IDPerson) VALUES ('Spin', 'Black', 6),('Centurion', 'Orange', 9),('Specialized', 'Purple', 12),('Cannondale', 'Green', 15);
SELECT * FROM Bikes;



#########################
# Create Location Table #
#########################
CREATE TABLE Location (
    id INT NOT NULL AUTO_INCREMENT,
    Neighborhood VARCHAR(50),
    City VARCHAR(50),
    IDPerson INT NOT NULL,
    FOREIGN KEY (IDPerson) REFERENCES People(PersonID),
    PRIMARY KEY (id)
);
SHOW TABLES;
DESCRIBE People;

INSERT INTO Location(Neighborhood, City, IDPerson) VALUES ('Columbia Heights', 'Washington, DC', 3), ('Bushwick', 'Brooklyn', 6),('Shaw', 'Washington, DC', 9),('Red Hook', 'Brooklyn', 12),('East Village', 'Manhattan', 15);


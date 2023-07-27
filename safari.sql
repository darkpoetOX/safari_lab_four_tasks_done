DROP TABLE IF EXISTS assignments;
DROP TABLE IF EXISTS animals;
DROP TABLE IF EXISTS staff;
DROP TABLE IF EXISTS enclosure;

CREATE TABLE enclosure(
    id SERIAL PRIMARY KEY,
    name VARCHAR(255),
    capacity INT,
    closedForMaintenance BOOLEAN
);

CREATE TABLE staff(
    id SERIAL PRIMARY KEY,
    name VARCHAR(255),
    employeeNumber INT
);

CREATE TABLE animals(
    id SERIAL PRIMARY KEY,
    name VARCHAR(255),
    type VARCHAR(255),
    age INT,
    enclosure_id INT REFERENCES enclosure(id)
);

CREATE TABLE assignments(
    id INT PRIMARY KEY,
    day VARCHAR(255),
    employeeId INT REFERENCES staff(id),
    enclosureId INT REFERENCES enclosure(id)
);

INSERT INTO enclosure (id, name, capacity, closedForMaintenance) VALUES (1, 'big cat field', 20, false);
INSERT INTO enclosure (id, name, capacity, closedForMaintenance) VALUES (2, 'big gorrila cage', 50, true);
INSERT INTO enclosure (id, name, capacity, closedForMaintenance) VALUES (3, 'big snake pit', 20, false);
INSERT INTO enclosure (id, name, capacity, closedForMaintenance) VALUES (4, 'big bear field', 45, true);

INSERT INTO animals (id, name, type, age, enclosure_id) VALUES (1, 'Tony', 'Tiger', 59, 1);
INSERT INTO animals (id, name, type, age, enclosure_id) VALUES (1, 'Harry', 'Bear', 59, 4);
INSERT INTO animals (id, name, type, age, enclosure_id) VALUES (2, 'Darren', 'Gorilla', 9, 2);
INSERT INTO animals (id, name, type, age, enclosure_id) VALUES (3, 'Tracy', 'Snake', 29, 3);

INSERT INTO staff (id, name, employeeNumber) VALUES (1, 'Captain Rik', 12345);
INSERT INTO staff (id, name, employeeNumber) VALUES (2, 'Captain Toon', 15678);
INSERT INTO staff (id, name, employeeNumber) VALUES (3, 'Holder Jane', 14555);
INSERT INTO staff (id, name, employeeNumber) VALUES (4, 'Helpful Rob', 13345);
INSERT INTO staff (id, name, employeeNumber) VALUES (5, 'Clown Joe', 11346);
INSERT INTO staff (id, name, employeeNumber) VALUES (6, 'Clark Doe', 12947);

INSERT INTO assignments (id, employeeId, enclosureId, day) VALUES (1, 1, 1, 'Monday');
INSERT INTO assignments (id, employeeId, enclosureId, day) VALUES (2, 1, 1, 'Tuesday');
INSERT INTO assignments (id, employeeId, enclosureId, day) VALUES (3, 2, 2, 'Wednesday');
INSERT INTO assignments (id, employeeId, enclosureId, day) VALUES (4, 3, 3, 'Thursday');
INSERT INTO assignments (id, employeeId, enclosureId, day) VALUES (5, 5, 2, 'Friday');
INSERT INTO assignments (id, employeeId, enclosureId, day) VALUES (6, 6, 4, 'Saturday');
INSERT INTO assignments (id, employeeId, enclosureId, day) VALUES (7, 1, 1, 'Sunday');


--Query 1. The names of the animals in a given enclosure
SELECT name FROM animals WHERE enclosure_id = 2;

--Query 2. The names of the staff working in a given enclosure.
SELECT s.name FROM staff AS s
INNER JOIN assignments AS a 
ON s.id = a.employeeId
WHERE a.enclosureId = 3;

--Query 3. The names of staff working in enclosures which are closed for maintenance
SELECT DISTINCT s.name FROM staff AS s
INNER JOIN assignments AS a ON s.id = a.employeeId
INNER JOIN enclosure AS e ON a.enclosureId = e.id
WHERE e.closedForMaintenance = true;

--Query 4. The name of the enclosure where the oldest animal lives. If there are two animals who are the same age choose the first one alphabetically.
SELECT e.name AS name_of_enclosure
FROM enclosure AS e
JOIN animals AS a ON e.id = a.enclosure_id
WHERE a.age = (
    SELECT MAX(age)
    FROM animals
)
ORDER BY a.age DESC, a.name
LIMIT 1;






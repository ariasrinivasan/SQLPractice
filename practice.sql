CREATE TABLE groceries (id INTEGER PRIMARY KEY, name TEXT, quantity INTEGER);
INSERT INTO groceries VALUES (1, "Bananas",4);

CREATE TABLE books (id INTEGER PRIMARY KEY, title TEXT, author TEXT, times_read INTEGER);
INSERT INTO books VALUES (1,"Last Lecture","Bill",1);
INSERT INTO books VALUES (2, "Complications","Atul",1);
INSERT INTO books VALUES (3,"Breath","Atul",2);

CREATE TABLE inventory (id INTEGER PRIMARY KEY, item_name TEXT, item_category TEXT, quantity INTEGER, price NUMERIC);
INSERT INTO inventory VALUES (1, "black dress", "clothing",1,12.99);
INSERT INTO inventory VALUES (2, "hoops", "accessories", 2,5.99);
INSERT INTO inventory VALUES (3, "rings", "accessories", 4, 2.99);
INSERT INTO inventory VALUES (4, "yellow top", "clothing", 1, 15.50);
INSERT INTO inventory VALUES (5, "blue crop top", "clothing", 3, 4.10);
INSERT INTO inventory VALUES (6, "jacket", "clothing", 6, 5.00);
INSERT INTO inventory VALUES (7, "coat", "clothing", 5, 6.00);
INSERT INTO inventory VALUES (8, "earrings", "accessories", 4, 7.50);
INSERT INTO inventory VALUES (9, "purse", "accessories", 1, 24.00);
INSERT INTO inventory VALUES (10, "perfume", "accessories", 4, 12.89);
INSERT INTO inventory VALUES (11, "black shirt", "clothing", 2, 17.99);
INSERT INTO inventory VALUES (12, "pink pants", "clothing", 3, 98.99);
INSERT INTO inventory VALUES (13, "jeans", "clothing", 1, 100.89);
INSERT INTO inventory VALUES (14, "necklace", "accessories", 3, 12.99);
INSERT INTO inventory VALUES (15, "choker", "accessories", 1, 12.00);
SELECT item_name, price ORDER BY price FROM inventory;
SELECT MAX(price) FROM inventory;

CREATE TABLE songs (
    id INTEGER PRIMARY KEY,
    title TEXT,
    artist TEXT,
    mood TEXT,
    duration INTEGER,
    released INTEGER);
    
INSERT INTO songs (title, artist, mood, duration, released)
    VALUES ("Bohemian Rhapsody", "Queen", "epic", 60, 1975);
INSERT INTO songs (title, artist, mood, duration, released)
    VALUES ("Let it go", "Idina Menzel", "epic", 227, 2013);
INSERT INTO songs (title, artist, mood, duration, released)
    VALUES ("I will survive", "Gloria Gaynor", "epic", 198, 1978);
INSERT INTO songs (title, artist, mood, duration, released)
    VALUES ("Twist and Shout", "The Beatles", "happy", 152, 1963);
INSERT INTO songs (title, artist, mood, duration, released)
    VALUES ("La Bamba", "Ritchie Valens", "happy", 166, 1958);
INSERT INTO songs (title, artist, mood, duration, released)
    VALUES ("I will always love you", "Whitney Houston", "epic", 273, 1992);
INSERT INTO songs (title, artist, mood, duration, released)
    VALUES ("Sweet Caroline", "Neil Diamond", "happy", 201, 1969);
INSERT INTO songs (title, artist, mood, duration, released)
    VALUES ("Call me maybe", "Carly Rae Jepsen", "happy", 193, 2011);
    
    SELECT title from songs;
    SELECT title from songs WHERE mood = "epic" OR released > 1990;
    SELECT title from songs WHERE mood = "epic" AND released > 1990 AND duration <240;
    
    SELECT type FROM drs_favorites;

SELECT * FROM exercise_logs WHERE type IN (
    SELECT type FROM drs_favorites);
    
SELECT * FROM exercise_logs WHERE type IN (
    SELECT type FROM drs_favorites WHERE reason = "Increases cardiovascular health");
    
/* LIKE */

SELECT * FROM exercise_logs WHERE type IN (
    SELECT type FROM drs_favorites WHERE reason LIKE "%cardiovascular%");

/*pivot table*/
SELECT type, SUM(calories) AS total_calories FROM exercise_logs GROUP BY type;

SELECT type, AVG(calories) AS avg_calories FROM exercise_logs
    GROUP BY type
    HAVING avg_calories > 70
    ; 
    
SELECT type FROM exercise_logs GROUP BY type HAVING COUNT(*) >= 2;

SELECT author, SUM(words) AS total_words FROM books 
  GROUP BY author
  HAVING total_words > 1000000;

  /* 50-90% of max*/
SELECT COUNT(*) FROM exercise_logs WHERE
    heart_rate >= ROUND(0.50 * (220-30)) 
    AND  heart_rate <= ROUND(0.90 * (220-30));


    /* CASE */
SELECT type, heart_rate,
    CASE 
        WHEN heart_rate > 220-30 THEN "above max"
        WHEN heart_rate > ROUND(0.90 * (220-30)) THEN "above target"
        WHEN heart_rate > ROUND(0.50 * (220-30)) THEN "within target"
        ELSE "below target"
    END as "hr_zone"
FROM exercise_logs;

SELECT COUNT(*),
    CASE 
        WHEN heart_rate > 220-30 THEN "above max"
        WHEN heart_rate > ROUND(0.90 * (220-30)) THEN "above target"
        WHEN heart_rate > ROUND(0.50 * (220-30)) THEN "within target"
        ELSE "below target"
    END as "hr_zone"
FROM exercise_logs
GROUP BY hr_zone;

SELECT name, number_grade, ROUND(fraction_completed * 100) AS percent_completed from student_grades;

SELECT COUNT(*), 
CASE
WHEN number_grade >= 90 THEN "A"
WHEN number_grade >= 80 THEN "B"
WHEN number_grade >= 70 THEN "C"
WHEN number_grade >= 60 THEN "D"
ELSE "F"
END AS "grade_logs"
FROM student_grades
GROUP BY grade_logs;


/*FULL JOINS*/
/*takes the full table listed first, and the corresponding matching information for each of those*/
SELECT * FROM student_grades, students;

/* IMPLICIT INNER JOIN*/
/*where there is overalap, the middle of the venn diagram*/
SELECT * FROM student_grades, students
WHERE student_grades.student_id = students.id;

/* EXPLICIT INNER JOIN*/
/*where there is overalap, the middle of the venn diagram*/
SELECT * FROM students /*what y ou want to start with...you want all these values*/
JOIN student_grades  /*what you want to bring into it*/
ON  students.id = student_grades.id; /*'ON' and the first one, and the matching identifier, and the second one, and the matching identifier. These can be called different things, as long as they match*/


CREATE TABLE persons (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT,
    age INTEGER);
    
INSERT INTO persons (name, age) VALUES ("Bobby McBobbyFace", 12);
INSERT INTO persons (name, age) VALUES ("Lucy BoBucie", 25);
INSERT INTO persons (name, age) VALUES ("Banana FoFanna", 14);
INSERT INTO persons (name, age) VALUES ("Shish Kabob", 20);
INSERT INTO persons (name, age) VALUES ("Fluffy Sparkles", 8);
INSERT INTO persons (name, age) VALUES ("Aria Srinivasan", 26);

CREATE table hobbies (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    person_id INTEGER,
    name TEXT);
    
INSERT INTO hobbies (person_id, name) VALUES (1, "drawing");
INSERT INTO hobbies (person_id, name) VALUES (1, "coding");
INSERT INTO hobbies (person_id, name) VALUES (2, "dancing");
INSERT INTO hobbies (person_id, name) VALUES (2, "coding");
INSERT INTO hobbies (person_id, name) VALUES (3, "skating");
INSERT INTO hobbies (person_id, name) VALUES (3, "rowing");
INSERT INTO hobbies (person_id, name) VALUES (3, "drawing");
INSERT INTO hobbies (person_id, name) VALUES (4, "coding");
INSERT INTO hobbies (person_id, name) VALUES (4, "dilly-dallying");
INSERT INTO hobbies (person_id, name) VALUES (4, "meowing");
INSERT INTO hobbies (person_id, name) VALUES (6,"dancing");

SELECT hobbies.name AS hobby, persons.name
FROM persons
JOIN hobbies
ON hobbies.person_id = persons.id
WHERE persons.name = "Bobby McBobbyFace";

/*LEFT OUTER JOIN*/
SELECT students.first_name, students.last_name, student_projects.title
    FROM students
    LEFT OUTER JOIN student_projects /*the 'LEFT' tells SQL to keep ALL values from the 'FROM' tables, and OUTER tells us to keep all values even if no match from the 'JOIN' table*/
    ON students.id = student_projects.student_id;
    

    CREATE TABLE customers (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT,
    email TEXT);
    
INSERT INTO customers (name, email) VALUES ("Doctor Who", "doctorwho@timelords.com");
INSERT INTO customers (name, email) VALUES ("Harry Potter", "harry@potter.com");
INSERT INTO customers (name, email) VALUES ("Captain Awesome", "captain@awesome.com");

CREATE TABLE orders (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    customer_id INTEGER,
    item TEXT,
    price REAL);

INSERT INTO orders (customer_id, item, price)
    VALUES (1, "Sonic Screwdriver", 1000.00);
INSERT INTO orders (customer_id, item, price)
    VALUES (2, "High Quality Broomstick", 40.00);
INSERT INTO orders (customer_id, item, price)
    VALUES (1, "TARDIS", 1000000.00);

SELECT customers.name, customers.email, orders.item, orders.price
FROM customers
LEFT OUTER JOIN orders
ON customers.id = orders.customer_id;

SELECT customers.name, customers.email, orders.price
FROM customers
LEFT OUTER JOIN orders
ON customers.id = orders.customer_id
GROUP BY orders.id;

SELECT customers.name, customers.email, SUM(orders.price) AS "Total Value"
FROM customers
LEFT OUTER JOIN orders
ON customers.id = orders.customer_id
GROUP BY customers.name
ORDER BY SUM(orders.price) DESC;

/* self join */
SELECT students.first_name, students.last_name, buddies.email as buddy_email
    FROM students
    JOIN students buddies
    ON students.buddy_id = buddies.id;

 SELECT movies.id, movies.title, sequels.id AS sequel_id, sequels.title as sequel_title
FROM movies
LEFT OUTER JOIN movies sequels
ON movies.sequel_id = sequels.id

/*combining self joins and regular joins*/
SELECT a.title, b.title FROM project_pairs
    JOIN student_projects a
    ON project_pairs.project1_id = a.id
    JOIN student_projects b
    ON project_pairs.project2_id = b.id;

SELECT persons.fullname, hobbies.name
FROM persons
JOIN hobbies
ON persons.id = hobbies.person_id;


SELECT a.fullname, b.fullname
FROM friends
JOIN persons a
ON a.id = friends.person1_id
JOIN persons b
ON b.id = friends.person2_id;

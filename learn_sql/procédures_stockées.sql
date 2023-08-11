-- Active: 1688545552050@@127.0.0.1@3306@tuto

-- Procédure stockée
SELECT * FROM posts;

-- supprimer une procédure
DROP PROCEDURE getDistances;

DROP PROCEDURE getClosestCity;
-- créer une procédure
DELIMITER $

CREATE PROCEDURE getDistances ()
BEGIN
    SELECT 
        title, 
        ST_Distance_Sphere(
            location,
            (SELECT location FROM posts WHERE title = 'Montpellier')
        ) AS distance
        FROM posts
        HAVING distance IS NOT NULL;
END$

DELIMITER;

-- voir les procédures existantes
SHOW PROCEDURE STATUS LIKE 'getDistances';

-- utiliser la procédure
CALL getDistances();

-- Créer une procédure avec des paramètres
DELIMITER $

CREATE PROCEDURE getDistances (
    IN origin VARCHAR(255)
)
BEGIN
    SELECT 
        title, 
        ST_Distance_Sphere(
            location,
            (SELECT location FROM posts WHERE title = origin)
        ) AS distance
        FROM posts
        HAVING distance IS NOT NULL;
END$

DELIMITER;

-- utiliser la procédure en précisant le paramètre
CALL getDistances('Paris');


-- nouvelle procédure
DELIMITER $

CREATE PROCEDURE getClosestCity (
    IN origin VARCHAR(255),
    OUT closestCity VARCHAR(255)
)
BEGIN
    SELECT subquery.title INTO closestCity FROM(
        SELECT
            title, 
            ST_Distance_Sphere(
                location,
                (SELECT location FROM posts WHERE title = origin)
            ) AS distance
        FROM posts
        WHERE title != origin
        HAVING distance IS NOT NULL
        ORDER BY distance ASC
        LIMIT 1
    ) AS subquery;
END$

DELIMITER;

-- utiliser la procédure
CALL getClosestCity('Montpellier', @city);

SELECT @city;
-- Active: 1688545552050@@127.0.0.1@3306@tuto

-- Données spatiales
SELECT * FROM posts;

ALTER TABLE posts
ADD location POINT;

INSERT INTO posts (title, location)
VALUES 
    ('Perpignan', ST_GeomFromText('POINT(2.895600 42.698601)')),
    ('Montpellier', ST_GeomFromText('POINT(3.877200 43.611900)')),
    ('Paris', ST_GeomFromText('POINT(2.349014 48.864716)'));

-- Obtenir une distance entre 2 villes en cm
SELECT ST_Distance_Sphere(
    (SELECT location FROM posts WHERE title = 'Perpignan'),
    (SELECT location FROM posts WHERE title = 'Montpellier')
) AS distance;

-- Obtenir une distance entre 2 villes en km
SELECT CONCAT (ROUND (ST_Distance_Sphere(
            (SELECT location FROM posts WHERE title = 'Perpignan'),
            (SELECT location FROM posts WHERE title = 'Paris')
        ) / 1000), ' km') AS distance;

-- Geolocalisation pour connaître les villes à moins de 200 km par exemple
SELECT title FROM posts WHERE ST_Distance_Sphere(
    (SELECT location FROM posts WHERE title = 'Perpignan'),
    location
) < 200000


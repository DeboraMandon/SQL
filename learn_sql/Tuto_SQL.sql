-- SQLite

/*
-- Creation de table
CREATE TABLE recipes(
    Title VARCHAR(200),
    Content VARCHAR(50),
    Slug TEXT,
    Duration SMALLINT,
    Online BOLEAN,
    Created_at DATETIME);
*/
/*
--Insertion
INSERT INTO recipes(Title,
            Content,
            Slug,
            Duration,
            Online,
            Created_at
            )
VALUES ('Soupe',
        'Soupe',
        'Contenu de test',
        10,
        FALSE,
        1642696734);
*/
/*

-- Select
SELECT Title, Duration, Online
FROM recipes
WHERE Duration < 20 OR Online = TRUE


SELECT * 
FROM recipes
WHERE title LIKE '%alade%'
*/
/*
-- Opéation booléen
TRUE AND TRUE = TRUE
TRUE AND FALSE = FALSE
FALSE AND FALSE = FALSE

TRUE OR FALSE = TRUE
FALSE OR TRUE = TRUE
TRUE OR TRUE = TRUE
FALSE OR FALSE = FALSE
*/
/*

-- Delete
DELETE FROM recipes
WHERE title = 'Soupe2'
*/
/*

-- Update
UPDATE recipes 
SET Title = 'Soupe de légume' 
WHERE Title = 'Soupe'
*/
SELECT *
FROM recipes

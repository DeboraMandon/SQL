-- Active: 1688545552050@@127.0.0.1@3306@tuto

-- Données format JSON
SELECT * FROM posts;

ALTER TABLE posts
ADD author JSON;

DELETE FROM posts
WHERE id =5;

INSERT INTO posts(title, author) VALUES
    ('Titre de Jane', '{"age":30, "firstname": "Jane"}');

INSERT INTO posts (title) VALUES ('Titre sans author');

-- Faire une recherche dans des données JSON
SELECT title, author-> "$.age" FROM posts;

SELECT * FROM posts
WHERE author -> '$.age' <= 20;

SELECT author -> '$.age' FROM posts;

-- Pour modifier un JSON
UPDATE posts SET author = JSON_SET(author, '$.age', author-> '$.age' +2) WHERE id =10;

INSERT INTO posts (title, author) VALUES ('Titre sans author', '{"age":25, "firstname": "John\\" Doe"}');

-- pour enlever les quotes "" ou \" utiliser ->>
SELECT author ->> '$.firstname' FROM posts;


-- Active: 1688545552050@@127.0.0.1@3306@tuto

SELECT * FROM posts;

-- DATETIME
ALTER TABLE posts
ADD published_at DATETIME;

INSERT INTO posts (title, published_at)
VALUES 
    ('Hello world', '2023-07-05 12:00:00');

SELECT title, YEAR(published_at) FROM posts;

SELECT title, TIMEDIFF(NOW(), published_at) FROM posts;

SELECT title, published_at FROM posts
WHERE YEAR(published_at) = '2023';

SELECT title, published_at FROM posts
WHERE published_at <= NOW();


-- TIMESTAMP
ALTER TABLE posts
ADD created_at TIMESTAMP;

ALTER TABLE posts
DROP created_at;

SELECT * FROM posts;

UPDATE posts SET created_at = '2023-04-13 12:00:00';

SET time_zone = '+03:00:';

-- connapitre son fuseau horaire
SELECT @@global.time_zone, @@session.time_zone;

-- Possibilité d'utiliser des DEFAULTS
ALTER TABLE posts
DROP created_at;

ALTER TABLE posts
ADD created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
ADD updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;

SELECT * FROM posts;

UPDATE posts SET title = 'Hello'
WHERE id = 1;
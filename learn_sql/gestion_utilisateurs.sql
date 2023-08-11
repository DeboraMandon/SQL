-- Active: 1688545552050@@127.0.0.1@3306@tuto


CREATE TABLE users (
    id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255)
);

-- Gestion des utilisateurs
SELECT * FROM posts;

-- créer un utilisateur
CREATE USER 'readonly'@'%' IDENTIFIED BY '0000';

-- donner des permissions
GRANT SELECT ON tuto.posts TO 'readonly'@'%';

-- voir les permissions des utilisateurs
SHOW GRANTS FOR 'readonly'@'%';

SELECT * FROM mysql.user;

-- supprimer des permissions
REVOKE SELECT ON `tuto`.`posts` FROM `readonly`@`%`;

-- supprimer un utilisateur
DROP USER 'readonly'@'%';
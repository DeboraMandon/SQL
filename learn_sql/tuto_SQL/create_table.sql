-- SQLite

CREATE TABLE IF NOT EXISTS categories (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(255) NOT NULL,
    parent_id INTEGER, 
    FOREIGN KEY (parent_id) REFERENCES categories (id) ON DELETE CASCADE
);


DELETE FROM categories;

INSERT INTO categories
VALUES 
    (1, 'Mammifère', NULL),
    (2, 'Chien', 1),
    (3, 'Chat', 1),
    (4, 'Singe', 1),
    (5, 'Gorille', 4),
    (6, 'Chimpanzé', 4),
    (7, 'Shiba', 2),
    (8, 'Corgi', 2),
    (9, 'Labrador', 2),
    (10, 'Poisson', NULL),
    (11, 'Requin', 2),
    (12, 'Requin blanc', 11),
    (13, 'Grand requin blanc', 12),
    (14, 'Petit requin blanc', 12),
    (15, 'Requin marteau', 11),
    (16, 'Requin tigre', 11),
    (17, 'Poisson rouge', 10),
    (18, 'Poisson chat', 10);


CREATE TABLE IF NOT EXISTS sales (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    year INTEGER,
    country VARCHAR(255),
    product VARCHAR(255),
    profit INTEGER
);

INSERT INTO sales (year, country, product, profit)
VALUES
  (2000,'Finland','Computer'  ,  1500),
  (2000,'Finland','Phone'     ,   100),
  (2001,'Finland','Phone'     ,    10),
  (2000,'India'  ,'Calculator',    75),
  (2000,'India'  ,'Calculator',    75),
  (2000,'India'  ,'Computer'  ,  1200),
  (2000,'USA'    ,'Calculator',    75),
  (2000,'USA'    ,'Computer'  ,  1500),
  (2001,'USA'    ,'Calculator',    50),
  (2001,'USA'    ,'Computer'  ,  1500),
  (2001,'USA'    ,'Computer'  ,  1200),
  (2001,'USA'    ,'TV'        ,   150),
  (2001,'USA'    ,'TV'        ,   100);
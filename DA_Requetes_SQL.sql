-- SQLite


------- LA PROJECTION


-- afficher toutes les colonnes de la table albums
SELECT *
FROM albums


-- Afficher les colonnes AlbumId et ArtistId de la table albums
SELECT AlbumId, ArtistId
FROM albums


--  Afficher tous les ArtistId distincts de la table albums
SELECT DISTINCT ArtistId
FROM albums


-- Afficher le nom, le prénom et le poste des employés de la chinookcorp, contenus dans la table employees
SELECT LastName, Firstname, Title 
FROM employees;


------ LA SELECTION SIMPLE


-- Afficher les employés habitant à 'Calgary'
SELECT * 
FROM employees 
WHERE City = 'Calgary';


-- Afficher les employés habitants à 'Edmonton' ou à 'Lethbridge'
SELECT * 
FROM employees 
WHERE City = 'Edmonton' OR City = 'Lethbridge';


--  Afficher le nom, le prénom et le poste des employés possédant un supérieur hiérarchique
SELECT LastName, FirstName, Title 
FROM employees 
WHERE ReportsTo IS NOT NULL;


-- Afficher les employés dont l'identifiant est plus petit que 5 compris
SELECT * 
FROM employees 
WHERE EmployeeId <= 5;


-- Afficher les employés dont l'identifiant est entre 2 et 7 compris
SELECT * 
FROM employees
WHERE EmployeeId >= 2 AND EmployeeId <= 7


-- Afficher les employés nés avant le 10 mai 1973, faites attention au format de la date.
SELECT * 
FROM employees 
WHERE BirthDate <= '1973-05-10';


------- EXPRESSIONS REGULIERES


-- Afficher les données des titres commençant par P
SELECT * 
FROM tracks 
WHERE Name LIKE 'P%';


-- Afficher les données des titres de 3 caractères.    1	Gene Simmons, S. Coronel	248346	8229734	0.99
450	Beth	37	1	1	S. Penridge, Bob Ezrin, Peter Criss	166974	5360574	0.99
474	She	39	1	4	Billie Joe Armstrong -Words Green Day -Music
SELECT * 
FROM tracks 
WHERE Name Like '___';

--  Afficher les titres de moins de 5 caractères
SELECT * 
FROM tracks 
WHERE Name NOT LIKE '_____%';

-- Afficher les titres composés par 'Jimi Hendrix'
SELECT * 
FROM tracks 
WHERE Composer LIKE '%Jimi%' AND Composer LIKE '%Hendrix%';

-- Afficher les musiques issues d'une association d'artistes

SELECT Name, Composer 
FROM tracks 
WHERE (Composer LIKE '%/%' AND Composer NOT LIKE '__/__') OR Composer LIKE '%-%';


------- TRI DES DONNEES

-- Trier les titres de musique par ordre alphabétique, on se limitera aux 10 premiers
SELECT Name 
FROM tracks 
ORDER BY Name ASC LIMIT 10;

-- Afficher les titres d'AC/DC dans l'ordre alphabétique
SELECT Name, Composer 
FROM tracks 
WHERE Composer LIKE '%AC/DC%' 
ORDER BY Name;

-- Afficher les 5 titres les plus longs de la table tracks ainsi que leur durée.
SELECT Name, Milliseconds 
FROM tracks 
ORDER BY Milliseconds DESC LIMIT 5;

-- SQLite


--Créer une table Boissons(BoissonId, Nom, Contenance, Prix) en choisissant de manière adéquate la clé primaire. 
--Justifier la réponse.

CREATE TABLE Boissons (
   BoissonId INTEGER PRIMARY KEY,
   Nom TEXT,
   Contenance INTEGER,
   Prix REAL);

"""
La clé primaire est BoissonId car elle est unique pour chaque ligne de la table
"""

SELECT *
FROM Boissons;


--Ajouter les tuples (1, Coca, 33, 0.99) , (2, Perrier, 100, 2) , (3, Perrier, 33, 1), (4, Vittel, 150, 1.50) , 
--(5, Badoit, 50, 2) dans la table Boissons.

INSERT INTO Boissons
VALUES
   (1, 'Coca', 33, 0.99),
   (2, 'Perrier', 100, 2),
   (3, 'Perrier', 33, 1),
   (4, 'Vittel', 150, 1.50),
   (5, 'Badoit', 50, 2);


--Créer une table Factures(FactureId,BoissId,Heure). 
--Il faudra faire référence à une clé primaire de la table Boissons.

CREATE TABLE Factures (FactureId INTEGER PRIMARY KEY,
   BoissonId INTEGER,
   Heure DATETIME,
FOREIGN KEY (BoissonId) 
REFERENCES Boissons(BoissonId));

SELECT *
FROM Factures

-- Ajouter les tuples (1,1,7), (2,1,8) , (3,4,12) dans la table Factures.


INSERT INTO Factures
VALUES
   (1,1,7),
   (2,1,8) ,
   (3,4,12);


SELECT *
FROM Factures



--Peut-on supprimer la table Boissons ? Justifier la réponse.
"""
La table Factures dépend de la table Boissons au travers de sa clé primaire.
Pour pouvoir la supprimer il faudra d'abord supprimer la table Factures.
"""

-- Peut-on ajouter le tuple (1,Sprite,50,1) dans la table Boissons ? Justifier la réponse.
On ne peut pas ajouter le tuple (1,Sprite,50,1) en raison de la contrainte de clé primaire sur la colonne BoissonId.
Celle-ci doit être unique et 1 est déjà utilisé.


--Donner, en langage SQL, la requête permettant de savoir quelles boissons 
--du distributeur n'ont pas été vendues depuis sa mise en place, puis l'exécuter. 
--(On peut utiliser NOT IN pour vérifier qu'une colonne n'appartient pas à une table.)

SELECT BoissonId, Nom
FROM Boissons
WHERE BoissonId NOT IN (SELECT BoissonId FROM Factures);

--Donner, en langage SQL, la requête permettant de savoir la proportion des différentes boissons vendues dans 
--l'état actuel du distributeur, puis l'exécuter. 
--(On peut utiliser GROUP BY pour grouper les différentes boissons, le nombre de boissons présentes 
--dans la table Factures correspond au nombre de tuples ajoutés dans la question (e).)

SELECT Boissons.Nom, COUNT(*) AS NbVentes, (COUNT(*) * 100.0 / (SELECT COUNT(*) FROM Factures)) AS Proportion
FROM Factures
JOIN Boissons ON Factures.BoissonId = Boissons.BoissonId
GROUP BY Factures.BoissonId
ORDER BY Proportion DESC;

--Supprimer les deux tables.

DROP TABLE IF EXISTS Factures;

DROP TABLE IF EXISTS Boissons;
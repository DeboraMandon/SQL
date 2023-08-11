-- SQLite

-------- CREATION DE TABLES

-- créer la table parcours qui contiendra les différents parcours proposés par l'établissement, en les décrivant à l'aide d'un id et d'un name
CREATE TABLE parcours (
    id INTEGER NOT NULL, 
    name VARCHAR,
    PRIMARY KEY (id));

-- Créer une table students qui permettra d'identifier les étudiants au sein de l'université. Les attributs de cette table seront l'id de l'étudiant, son prénom firstname, son nom lastname, ainsi que l'identifiant parcours_id du parcours suivi.
CREATE TABLE students (
  id INTEGER NOT NULL, 
  firstname VARCHAR,
  lastname VARCHAR,
  parcours_id INTEGER,
  PRIMARY KEY (id), 
  FOREIGN KEY (parcours_id) REFERENCES parcours (id));


-------- AJOUT DE CONTRAINTES
-------- INSERTION DE LIGNES

-- Insérer les lignes correspondant aux parcours (1, "Data Engineering") et (2, "Data Science") dans la table parcours
INSERT INTO parcours 
VALUES 
    (1, "Data Engineering"), 
    (2, "Data Science");

-- De la même manière, ajouter à la table students les nouveaux étudiants 'Jean Dubois' en 'Data Engineering' et 'Martin Dupont' en 'Data Science'. Penser à utiliser les clés primaires et étrangères de la table.
INSERT INTO students 
VALUES 
    (1, "Jean", "Dubois", 1), 
    (2, "Martin", "Dupont", 2);

-- Vérifier que les lignes ont bien été ajoutées aux tables avec une requête
SELECT * 
FROM parcours;
'''
SELECT * 
FROM students;


-------- SUPPRESSION DE LIGNES


-- L'étudiant 'Jean Dubois' vient de se désinscrire de l'établissement. Supprimer cet étudiant de la table students
DELETE FROM students 
WHERE id=1;

-- Essayer de supprimer la ligne Data Science de la table parcours. Pourquoi n'est ce pas possible?
DELETE FROM parcours 
WHERE id=2;
#impossible de supprimer ce parcours car la table students fait référence à cette ligne de parcours par une clé étrangère


-------- MODIFICATION DE LIGNES


-- Le directeur a fait une erreur de frappe pour l'étudiant d'identifiant 2 dans la table students. Modifier son nom en 'Durand' à la place de 'Dupont'
UPDATE students
SET lastname = 'Durand' 
WHERE id = 2;

-- L'étudiant d'identifiant 2 s'appelle bien 'Dupont', mais son prénom est 'Marin' et non 'Martin'. Faire les modifications correspondantes.
UPDATE students
SET lastname = 'Dupont', firstname = 'Marin' 
WHERE id = 2;

-------- SUPPRESSION DE TABLES


-- Supprimer les tables students et ensuite parcours
DROP TABLE IF EXISTS students;
'''
DROP TABLE IF EXISTS parcours;


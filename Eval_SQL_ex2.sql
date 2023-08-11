-- sqlite

 Effectuer à l'aide de la commande suivante une première analyse de la base de données en déterminant les différentes tables, leurs attributs et les clés primaires associées

SELECT
   name,sql
FROM
   sqlite_schema
WHERE
   type ='table' AND
   name NOT LIKE 'sqlite_%';


Combien y a-t-il de titres par type ? (Utiliser l'attribut type de la table titles.)

SELECT type, COUNT(title_id) AS NbTitre
FROM titles
GROUP BY type;


Quels sont les titres les mieux notés dans la base de données ? 
On indiquera le nom (primary), la note, et le nombre de votes. 
Pour que la sélection soit représentative, il faudra filtrer pour les titres ayant un nombre de votants > 5000. 
On triera les résultats par ordre décroissant de note et de nombre de votes. 
(On limitera les résultats aux 10 premières lignes.)

SELECT primary_title, rating, votes
FROM ratings
JOIN titles ON ratings.title_id = titles.title_id
WHERE votes > 5000
ORDER BY rating DESC, votes DESC
LIMIT 10;


 Quelle est la note moyenne des titres par catégorie ? (On limitera les résultats aux 10 premières lignes.)

SELECT type, AVG(rating) AS NoteMoyenne
FROM titles
JOIN ratings ON titles.title_id = ratings.title_id
GROUP BY type
LIMIT 10;


Quelles sont les notes moyennes des titres associés aux différents directeurs/metteurs en scène/réalisateurs... ? 
(On limitera les résultats aux 10 premières lignes.)


SELECT
   p.name AS NomArtiste, AVG(r.rating) AS NoteMoyenne
FROM
   crew
JOIN people AS p ON crew.person_id = p.person_id
JOIN ratings AS r ON crew.title_id = r.title_id
WHERE crew.category = 'director'
GROUP BY p.name
LIMIT 10;


Quels sont les titres sur lesquels Quentin Tarantino a travaillé ? 
On précisera le nom (original) et la note du titre, et on classera ce résultat par ordre décroissant des notes moyennes.

SELECT t.original_title, AVG(r.rating) AS NoteMoyenne
FROM crew AS c
JOIN people AS p ON c.person_id = p.person_id
JOIN titles AS t ON c.title_id = t.title_id
JOIN ratings AS r ON c.title_id = r.title_id
WHERE p.name  LIKE '%Quentin%' AND p.name  LIKE '%Tarantino%'
GROUP BY t.title_id, t.original_title
ORDER BY NoteMoyenne DESC;


Quels sont les acteurs ou actrices ayant obtenu les meilleures notes, pour des contenus ayant plus de 5000 votes ? 
La variable category de la table crew détermine le métier de l'individu auquel le tuple est associé. 
(On limitera les résultats aux 10 premières lignes)

SELECT p.name AS actor_actress_name, AVG(r.rating) AS NoteMoyenne
FROM crew AS c
JOIN people AS p ON c.person_id = p.person_id
JOIN ratings AS r ON c.title_id = r.title_id
WHERE c.category IN ('actor', 'actress') AND r.votes > 5000
GROUP BY c.person_id, p.name
ORDER BY NoteMoyenne DESC
LIMIT 10;


Quelle est la note moyenne des contenus pour les actrices et les acteurs ? 
Regrouper ces deux informations dans un seul tuple.

SELECT
   AVG(CASE WHEN c.category = 'actor' THEN r.rating END) AS NoteMoyenneActeurs,
   AVG(CASE WHEN c.category = 'actress' THEN r.rating END) AS NoteMoyenneActrices
FROM crew AS c
JOIN ratings AS r
   ON c.title_id = r.title_id;




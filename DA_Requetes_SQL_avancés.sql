-- SQLite


------- JOINTURES

-- Utiliser le Widget afin de faire une jointure interne en utilisant la colonne GenreId, clé primaire de la table genres et clé étrangère de la table tracks
SELECT * 
FROM tracks 
JOIN genres ON tracks.GenreId = genres.GenreId;

-- En utilisant une projection et une jointure interne, afficher dans une seule table les colonnes tracks.Name, tracks.GenreId et genres.Name
SELECT tracks.Name, tracks.GenreId, genres.Name 
FROM tracks 
JOIN genres ON tracks.GenreId = genres.GenreId;

-- En utilisant une projection, une jointure interne et le mot-clé AS, afficher dans une seule table les colonnes renommées Titre, NumeroGenre et NomGenre
SELECT tracks.Name AS Titre, tracks.GenreId AS NumeroGenre, genres.Name AS NomGenre 
FROM tracks 
JOIN genres ON tracks.GenreId = genres.GenreId;

-- Afficher dans une même table le titre des albums de la table albums avec le nom de l'artiste associé qui est répertorié dans la table artists
SELECT albums.Title, artists.Name 
FROM albums 
JOIN artists ON artists.ArtistId = albums.ArtistId;

-- À l'aide d'une jointure à gauche, 
-- afficher les compositeurs pour les lignes de la table artists ayant exactement pour compositeur un artiste de la table tracks, ou None le cas échéant. 
-- On enlèvera les lignes où l'artiste de la table tracks n'est pas spécifié
SELECT tracks.Composer, tracks.Name AS Song, artists.Name 
FROM tracks 
LEFT JOIN artists ON tracks.Composer = artists.Name
WHERE tracks.Composer IS NOT NULL;

-- À l'aide d'une jointure à gauche, 
-- afficher les titres de tracks pour lesquels un artiste de artists a participé à la composition et None sinon. 
-- Attention, il y a parfois plusieurs artistes qui ont travaillé à la conception d'une même musique;
SELECT artists.Name, tracks.Composer, tracks.Name AS Song
FROM artists 
LEFT JOIN tracks ON tracks.Composer LIKE ('%' || artists.Name || '%');

-- En simulant une jointure à droite à l'aide d'une jointure à gauche, afficher les compositeurs pour les lignes de la table tracks ayant exactement pour compositeur un artiste de la table artists, ou None le cas échéant
SELECT tracks.Composer, tracks.Name AS Song, artists.Name 
FROM tracks 
LEFT JOIN artists ON tracks.Composer = artists.Name;

-- En simulant une jointure externe, récupérez une table présentant de manière unique tous les artistes présents dans les tables artists et tracks (avec les musiques correspondantes). 
-- On enlèvera les lignes où l'artiste de la table tracks n'est pas spécifié.
SELECT tracks.Composer, tracks.Name AS Song, artists.Name 
FROM artists 
LEFT JOIN tracks ON tracks.Composer = artists.Name
WHERE tracks.Composer IS NOT NULL
UNION
SELECT tracks.Composer, tracks.Name AS Song, artists.Name 
FROM tracks 
LEFT JOIN artists ON tracks.Composer = artists.Name
WHERE tracks.Composer IS NOT NULL;

-- À l'aide d'une jointure interne imbriquée sur les tables tracks, albums et artists, 
-- affichez dans une table les titres des musiques ainsi que l'album dont elles font partie et leur interprète.
SELECT tracks.Name AS 'Musique', a.Title AS 'Album', a.Name AS 'Artiste' 
FROM tracks 
JOIN (SELECT * 
    FROM albums 
    JOIN artists ON artists.ArtistId = albums.ArtistId) AS a
ON tracks.AlbumId = a.AlbumId



-------- LES FONCTIONS D'AGREGATIONS


-- Compter le nombre de musiques enregistrées dans la table tracks
SELECT COUNT(TrackId) 
FROM tracks;

-- Afficher la durée moyenne d'une musique de la table tracks, à l'aide de la colonne Milliseconds
SELECT AVG(Milliseconds) AS 'Durée Moyenne' 
FROM tracks;


-------- REGROUPEMENT

-- Afficher le nombre d'albums par artiste à l'aide de la table albums, et des mots-clés COUNT et GROUP BY
SELECT ArtistId, COUNT(AlbumId) AS Albums
FROM albums 
GROUP BY ArtistId;

-- Avec une jointure interne, remplacer la colonne ArtistId de la requête précédente par le nom des artistes à l'aide de la table artists, 
-- on affichera également le nombre d'albums par artiste
SELECT Name, Albums 
FROM artists 
JOIN (SELECT ArtistId,  COUNT(AlbumId) AS Albums 
    FROM albums 
    GROUP BY ArtistId) AS a 
ON artists.ArtistId = a.ArtistId;

-- Afficher la durée totale et le nombre de musiques de chaque album par artiste, 
-- on aura besoin des tables tracks, artists et albums, et donc d'une jointure imbriquée.
SELECT NomArtiste, NomAlbum, SUM(Milliseconds) AS DureeAlbum, COUNT(b.Name) AS NbMusiques 
FROM (SELECT tracks.Name, Milliseconds, a.Title AS NomAlbum, a.Name AS NomArtiste 
    FROM tracks 
    JOIN (SELECT * 
        FROM albums 
        JOIN artists ON albums.ArtistId = artists.ArtistId) AS a 
    ON tracks.AlbumId = a.AlbumId) AS b 
GROUP BY NomArtiste, NomAlbum;

-- Afficher le nombre de musiques de plus de 400 secondes par AlbumId en utilisant la table tracks
SELECT AlbumId, COUNT(AlbumId) AS MusiquesLongues 
FROM tracks 
WHERE Milliseconds > 400000 
GROUP BY AlbumId;

-- Afficher le nombre de musiques de plus de 400 secondes par nom d'album à l'aide d'une jointure interne entre les tables tracks et albums
SELECT Title, NbMusiquesLongues AS MusiquesLongues 
FROM albums 
JOIN (SELECT AlbumId, COUNT(Name) AS NbMusiquesLongues 
    FROM tracks 
    WHERE Milliseconds > 400000 
    GROUP BY AlbumId) AS a 
ON albums.AlbumId = a.AlbumId;

-- Afficher les albums qui ne sont pas des singles (i.e. qui possède au moins 2 musiques), par AlbumId en utilisant la table tracks
SELECT AlbumId, COUNT(TrackId) AS NbMusiques
FROM tracks
GROUP BY AlbumId
HAVING NbMusiques >= 2;

-- Afficher les albums qui ne sont pas des singles en utilisant une jointure interne entre les tables tracks et albums
SELECT Title AS NomAlbum, COUNT(tracks.AlbumId) AS NbMusiques
FROM tracks
JOIN albums ON tracks.AlbumId = albums.AlbumId
GROUP BY albums.AlbumId
HAVING NbMusiques >= 2;

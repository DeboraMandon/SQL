
-- INFO SUR L'ENCODAGE DES DONNEES
SHOW VARIABLES LIKE 'character_set_server'; --permet de connaître l'encodage utilisé par notre serveur

SELECT default_character_set_name FROM information_schema.`SCHEMATA` WHERE `SCHEMA_NAME` = 'tuto';


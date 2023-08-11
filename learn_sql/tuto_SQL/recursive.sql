-- SQLite

-- Requêtes récursives

WITH RECURSIVE temptable AS (
    SELECT id, name, parent_id FROM categories WHERE id = 14
    UNION ALL
    SELECT c.id, c.name, c.parent_id FROM categories c, temptable 
    WHERE c.id = temptable.parent_id
)
SELECT * FROM temptable;


WITH RECURSIVE children (id, name, parent_id, level, path) AS(
    SELECT id, name, parent_id, 0 AS level, "" AS path FROM categories WHERE id = 11
    UNION ALL
    SELECT 
        c.id, 
        c.name, 
        c.parent_id, 
        children.level +1 AS level,
        children.path || children.name || " > " AS path -- CONCAT sur MySQL
    FROM categories c, children
    WHERE c.parent_id = children.id
)
SELECT id, name, level, path FROM children;
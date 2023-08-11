-- SQLite

-- WINDOW FUNCTION

SELECT *
FROM sales;

SELECT SUM(profit)
FROM sales;


SELECT
    *,
    SUM(profit) OVER ()
FROM sales;

-- PARTITION
-- ROW_NUMBER
SELECT
    *,
    SUM(profit) OVER (PARTITION BY country),
    ROW_NUMBER() OVER (PARTITION BY country ORDER BY profit ASC)
FROM sales;

-- RANK
SELECT
    *,
    SUM(profit) OVER (PARTITION BY country),
    RANK() OVER (PARTITION BY country ORDER BY profit DESC)
FROM sales;

-- DENSE_RANK
SELECT
    *,
    SUM(profit) OVER (PARTITION BY country),
    DENSE_RANK() OVER (PARTITION BY country ORDER BY profit DESC)
FROM sales;

-- idem MAIS AVEC un WINDOW
SELECT
    *,
    SUM(profit) OVER w,
    DENSE_RANK() OVER w
FROM sales
WINDOW w AS (PARTITION BY country ORDER BY profit DESC);

-- faire une requête imbriquée pour filtrer sur la partition
SELECT * FROM (
    SELECT
        *,
        SUM(profit) OVER w AS total_country,
        ROW_NUMBER() OVER w AS row_number
    FROM sales
    WINDOW w AS (PARTITION BY country ORDER BY profit DESC)
) AS t
WHERE t.row_number < 4;
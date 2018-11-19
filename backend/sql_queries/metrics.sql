-- Generosity: how often a user refers people.

SELECT generosity.id, generosity.value, ROW_NUMBER () OVER (ORDER BY value DESC) AS rank, (1 - ROW_NUMBER () OVER (ORDER BY value DESC) / (
    SELECT COUNT(*)
    FROM person
)::decimal) * 100 AS percentile
FROM (
    SELECT person.id, COUNT(*) AS value
    FROM person, referrals
    WHERE person.id = referrals.sender
    GROUP BY person.id
    ORDER BY value DESC
) AS generosity;

-- Impact: how often people referred by a user get the offer.

-- Popularity: how often a user has been referred.

SELECT popularity.id, popularity.value, ROW_NUMBER () OVER (ORDER BY value DESC) AS rank, (1 - ROW_NUMBER () OVER (ORDER BY value DESC) / (
    SELECT COUNT(*)
    FROM person
)::decimal) * 100 AS percentile
FROM (
    SELECT person.id, COUNT(*) AS value
    FROM person, referrals
    WHERE person.id = referrals.recipient
    GROUP BY person.id
    ORDER BY value DESC
) AS popularity;

-- Success: how often a user gets the job after having been referred.

-- Factoid: finds the most interesting of the four metrics for a user. 
-- This uses user 18 as an example.

SELECT quality, ROUND(percentile) as percentile
FROM
(
    -- Generosity
    (SELECT 'generosity' AS quality, generosity AS percentile
    FROM 
        (SELECT id, (1 - ROW_NUMBER () OVER (ORDER BY value DESC) / (
                SELECT COUNT(*)
                FROM person
            )::decimal) * 100 AS generosity
        FROM (
            SELECT person.id, COUNT(*) AS value
            FROM person, referrals
            WHERE person.id = referrals.sender
            GROUP BY person.id
            ORDER BY value DESC
        ) AS g) AS t
    WHERE id = 19)
    UNION
    -- Popularity
    (SELECT 'popularity' AS quality, popularity AS percentile
    FROM 
        (SELECT id, (1 - ROW_NUMBER () OVER (ORDER BY value DESC) / (
                SELECT COUNT(*)
                FROM person
            )::decimal) * 100 AS popularity
        FROM (
            SELECT person.id, COUNT(*) AS value
            FROM person, referrals
            WHERE person.id = referrals.recipient
            GROUP BY person.id
            ORDER BY value DESC
        ) AS r) AS t
    WHERE id = 19)
) AS metrics
ORDER BY ABS(percentile - 50) DESC
LIMIT 1;
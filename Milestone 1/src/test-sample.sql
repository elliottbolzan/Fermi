-- Jacquard Index used for comparison.

SELECT Condition.name, 
    (SELECT COUNT(*) FROM 
        ((VALUES (1), (2), (3))
        INTERSECT
        (SELECT SymptomId
        FROM AssociatedWith
        WHERE DiseaseId = D.id)) AS X)::decimal
        /
      (SELECT COUNT(*) FROM 
        ((VALUES (1), (2), (3))
        UNION
        (SELECT SymptomId
        FROM AssociatedWith
        WHERE DiseaseId = D.id)) AS X)
        AS Rank
FROM Disease AS D, Condition
WHERE Condition.id = D.id
ORDER BY Rank DESC
LIMIT 5;

UPDATE Profile SET age = 21, gender = 'M' WHERE id = 3124;

SELECT DISTINCT C.Id
FROM Condition AS C
WHERE C.name = 'Cough'
AND C.Id IN (SELECT id FROM Symptom);
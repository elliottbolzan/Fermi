--6 people with same university as user
with view1 AS (SELECT university,person
				FROM education
				WHERE person = '1')
SELECT education.person
FROM education,view1
WHERE (education.university=view1.university AND education.person<>view1.person)
LIMIT 6;
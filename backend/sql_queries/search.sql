

--university filter
SELECT name
FROM Person, Education
WHERE Person.id = Education.person 
AND Education.university = 'Duke'

--company filter
SELECT name
FROM Person, Experience
WHERE Person.id = Experience.person
AND Experience.company = 'Facebook'


--name filter
SELECT name
FROM Person
WHERE name = 'ELLDOG'


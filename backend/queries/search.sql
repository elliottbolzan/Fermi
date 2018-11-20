

--university filter
SELECT Person.name
FROM Person, Education, University
WHERE Person.id = Education.person 
AND Education.university = University.id
AND University.name = 'Duke';

--company filter
SELECT Person.name
FROM Person, Experience, Company
WHERE Person.id = Experience.person
AND Experience.company = Company.id
AND Company.name = 'Facebook';


--name filter
SELECT name
FROM Person
WHERE name = 'ELLDOG';


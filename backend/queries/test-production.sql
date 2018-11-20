--add new referral
INSERT INTO Referrals VALUES ('50000000', '1', '2', '1', FALSE, TIMESTAMP '2011-05-16 15:36:38');

--update referral status
UPDATE Referrals
SET status=TRUE
WHERE id = '3';

INSERT INTO Person VALUES ('40000000', 'Thardawg', 'thardawg@gmail.com');


SELECT sender, Count(status) from Referrals WHERE
	status = true GROUP BY sender  LIMIT 10;

SELECT sender, Count(status) from Referrals GROUP BY sender LIMIT 10;

SELECT recipient, Count(status) from Referrals WHERE
	status = true GROUP BY recipient LIMIT 10;

SELECT recipient, Count(status) from Referrals GROUP BY recipient LIMIT 10;


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

--6 people with same university as user
with view1 AS (SELECT university,person
				FROM education
				WHERE person = '1')
SELECT education.person
FROM education,view1
WHERE (education.university=view1.university AND education.person<>view1.person)
LIMIT 6;

--update a user's company, education, experience, university

--add row to University table if university not already in it
INSERT INTO University (id, name)
SELECT '20000000', 'UNC'
WHERE NOT EXISTS (SELECT name FROM University WHERE name='UNC');

--add row to Company table if company not already in it
INSERT INTO Company (id, name)
SELECT '20000000', 'Apple'
WHERE NOT EXISTS (SELECT name FROM Company WHERE name='Apple');

--add a new education
INSERT INTO Education VALUES ('20000000', '20000000', '20000000', 'BA', TIMESTAMP '2011-05-16 15:36:38');

--update an existing education
UPDATE Education
SET university='111', degree_type='BS', startdate=TIMESTAMP '2011-05-16 15:36:38', enddate=TIMESTAMP '2016-07-23 00:00:00'
WHERE id = '1' and person='1';

--add a new job experience
INSERT INTO Experience VALUES ('20000000', '20000000', '12000000', 'software engineer', TIMESTAMP '2011-05-16 15:36:38');

--update an existing job experience
UPDATE Experience
SET company='1', position='Product Manager', startdate=TIMESTAMP '2011-05-16 15:36:38', enddate=TIMESTAMP '2016-07-23 00:00:00'
WHERE id = '1' and person='1';


SELECT Person.name, Education.university, Education.degree_type, Education.startdate, Education.enddate,
		Experience.company, Experience.position, Experience.startdate, Experience.enddate
FROM Person, Education, Experience
WHERE Person.id='1' AND Education.id='1' AND Experience.id='1';
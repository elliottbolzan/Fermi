SELECT Person.id, Person.name, Company.name, University.name, generosity.percentile, popularity.percentile, impact.percentile, success.percentile
FROM Person, Education, University, Experience, Company, generosity, popularity, impact, success, Referrals
WHERE Person.id = Education.person AND Education.university = University.id
AND Person.id = Experience.person AND Experience.company = Company.id
AND Person.id = generosity.id AND Person.id = popularity.id AND Person.id = impact.id AND Person.id = success.id
AND (Referrals.sender = Person.id OR Referrals.recipient = Person.id)
AND EXISTS (SELECT Company.name
				FROM Company, Experience
				WHERE Person.id = Experience.person
				AND Experience.company = Company.id
				AND Person.name = 'John Smith'
				AND Company.name = 'Facebook')
AND Person.name = 'John Smith'
AND EXISTS (SELECT University.name
				FROM University, Education
				WHERE Person.id = Education.person
				AND Education.university = University.id
				AND Person.name = 'John Smith'
				AND University.name = 'Duke University')
AND generosity.percentile >= 80
AND popularity.percentile <= 20
AND impact.percentile >= 90
AND success.percentile >= 60
ORDER BY Referrals.timestamp DESC;

-- tested with:

-- SELECT Person.id, Person.name, Company.name, University.name, generosity.percentile, popularity.percentile, impact.percentile, success.percentile
-- FROM Person, Education, University, Experience, Company, generosity, popularity, impact, success, Referrals
-- WHERE Person.id = Education.person AND Education.university = University.id
-- AND Person.id = Experience.person AND Experience.company = Company.id
-- AND Person.id = generosity.id AND Person.id = popularity.id AND Person.id = impact.id AND Person.id = success.id
-- AND (Referrals.sender = Person.id OR Referrals.recipient = Person.id)
-- AND EXISTS (SELECT Company.name
-- 				FROM Company, Experience
-- 				WHERE Person.id = Experience.person
-- 				AND Experience.company = Company.id
-- 				AND Person.name = 'Sanjuanita Devit'
-- 				AND Company.name = 'Airbnb')
-- AND Person.name = 'Sanjuanita Devit'
-- AND EXISTS (SELECT University.name
-- 				FROM University, Education
-- 				WHERE Person.id = Education.person
-- 				AND Education.university = University.id
-- 				AND Person.name = 'Sanjuanita Devit'
-- 				AND University.name = 'Wuhan University of Technology')
-- AND impact.percentile >= 60;
SELECT Person.id, Person.name, Company.name, University.name, qualities.generosity, qualities.popularity, qualities.impact, qualities.success, (
    SELECT timestamp
    FROM Referrals
    WHERE sender = Person.id OR recipient = Person.ID
    ORDER BY timestamp DESC
    LIMIT 1
)  AS activity
FROM Person, Education, University, Experience, Company, qualities, (
    SELECT timestamp
    FROM Referrals
    WHERE sender = p.id OR recipient = p.ID
    ORDER BY timestamp DESC
    LIMIT 1
) AS Activity
WHERE Person.id = Education.person AND Education.university = University.id
AND Person.id = Experience.person AND Experience.company = Company.id
AND Person.id = qualities.id
AND Person.name = '%s'
AND EXISTS (SELECT Company.name
				FROM Company, Experience
				WHERE Person.id = Experience.person
				AND Experience.company = Company.id
				AND Person.name = '%s'
				AND Company.name = '%s')
AND EXISTS (SELECT University.name
				FROM University, Education
				WHERE Person.id = Education.person
				AND Education.university = University.id
				AND Person.name = '%s'
				AND University.name = '%s')
%s
ORDER BY activity DESC;
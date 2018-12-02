SELECT 
	Person.id, 
	Person.name, 
	Bachelors.id,
	Bachelors.name,
	Bachelors.degree_type,
	Bachelors.startdate,
	Bachelors.enddate,
	Masters.id,
	Masters.name,
	Masters.degree_type,
	Masters.startdate,
	Masters.enddate,
	Doctorate.id,
	Doctorate.name,
	Doctorate.degree_type,
	Doctorate.startdate,
	Doctorate.enddate,
	Experience.id,
	Experience.name,
	Experience.position,
	Experience.startdate,
	Experience.enddate,
	Qualities.generosity, 
	Qualities.impact, 
	Qualities.popularity, 
	Qualities.success, 
	(
		SELECT timestamp
		FROM Referrals
		WHERE sender = Person.id OR recipient = Person.id
		ORDER BY timestamp DESC
		LIMIT 1
	)  AS activity
FROM 
	Person, 
	Qualities,
		(
			SELECT Education.person, University.name, Education.id, Education.degree_type, Education.startdate, Education.enddate
			FROM University, Education
			WHERE Education.degree_type = 'Bachelors'
			AND University.id = Education.university
			LIMIT 1
		)  AS Bachelors,
		(
			SELECT Education.person, University.name, Education.id, Education.degree_type, Education.startdate, Education.enddate
			FROM University, Education
			WHERE Education.degree_type = 'Masters'
			AND University.id = Education.university
			LIMIT 1
		)  AS Masters,
		(
			SELECT Education.person, University.name, Education.id, Education.degree_type, Education.startdate, Education.enddate
			FROM University, Education
			WHERE Education.degree_type = 'Doctorate'
			AND University.id = Education.university
			LIMIT 1
		)  AS Doctorate,
		(
			SELECT Experience.person, Company.name, Experience.id, Experience.position, Experience.startdate, Experience.enddate
			FROM Company, Experience
			WHERE Company.id = Experience.company
			LIMIT 1
		)  AS Experience
WHERE Qualities.id = Person.id
AND Person.name LIKE %s
AND EXISTS (SELECT Company.name
				FROM Company, Experience
				WHERE Person.id = Experience.person
				AND Experience.company = Company.id
				AND Person.name LIKE %s
				AND Company.name LIKE %s)
AND EXISTS (SELECT University.name
				FROM University, Education
				WHERE Person.id = Education.person
				AND Education.university = University.id
				AND Person.name LIKE %s
				AND University.name LIKE %s)
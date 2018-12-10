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
	Work.id,
	Work.name,
	Work.position,
	Work.startdate,
	Work.enddate,
	Qualities.generosity, 
	Qualities.impact, 
	Qualities.popularity, 
	Qualities.success, 
	Person.last_active
FROM 
	Person
	LEFT OUTER JOIN
	(
		SELECT Education.person, University.name, Education.id, Education.degree_type, Education.startdate, Education.enddate
		FROM University, Education
		WHERE Education.degree_type = 'Bachelors'
		AND University.id = Education.university
	)  AS Bachelors
	ON Bachelors.person = Person.id
	LEFT OUTER JOIN
	(
		SELECT Education.person, University.name, Education.id, Education.degree_type, Education.startdate, Education.enddate
		FROM University, Education
		WHERE Education.degree_type = 'Masters'
		AND University.id = Education.university
	)  AS Masters
	ON Masters.person = Person.id
	LEFT OUTER JOIN
	(
		SELECT Education.person, University.name, Education.id, Education.degree_type, Education.startdate, Education.enddate
		FROM University, Education
		WHERE Education.degree_type = 'Doctorate'
		AND University.id = Education.university
	)  AS Doctorate
	ON Doctorate.person = Person.id
	LEFT OUTER JOIN
	(
		SELECT Experience.person, Company.name, Experience.id, Experience.position, Experience.startdate, Experience.enddate
		FROM Company, Experience
		WHERE Company.id = Experience.company
	)  AS Work
	ON Work.person = Person.id
	LEFT OUTER JOIN
	Qualities
	ON Qualities.id = Person.id

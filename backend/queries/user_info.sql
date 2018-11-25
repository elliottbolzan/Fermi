SELECT Person.name, Education.university, Education.degree_type, Education.startdate, Education.enddate,
		Experience.company, Experience.position, Experience.startdate, Experience.enddate
FROM Person, Education, Experience
WHERE Person.id='1' AND Education.id='1' AND Experience.id='1';
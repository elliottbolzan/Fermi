SELECT
	Person.id, 
	Person.name,
	Qualities.generosity, 
	Qualities.impact, 
	Qualities.popularity, 
	Qualities.success, 
	Person.last_active
FROM 
	Person
	LEFT OUTER JOIN
	Qualities
	ON Qualities.id = Person.id

SELECT Experience.id, Experience.person, Company.name, Experience.position, Experience.startdate, Experience.enddate
FROM Experience, Company
WHERE Experience.company = Company.id
AND Experience.person = %s;

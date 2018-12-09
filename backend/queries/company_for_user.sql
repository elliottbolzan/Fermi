SELECT Company.id
FROM Company, Experience
WHERE Company.id = Experience.company
AND Experience.person = %s;
SELECT Education.id, Education.person, University.name, Education.degree_type, Education.startdate, Education.enddate
FROM Education, University
WHERE Education.university = University.id
AND Education.person = %s;

SELECT DISTINCT  Education.university, Education.degree_type,Education.startdate, Education.enddate FROM Person, Education, Experience WHERE Person.id= %s AND Education.person=%s

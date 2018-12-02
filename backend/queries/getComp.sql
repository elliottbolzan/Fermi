SELECT DISTINCT Experience.company, Experience.position, Experience.startdate, Experience.enddate FROM Person, Experience WHERE Person.id= %s AND  Experience.person =  %s

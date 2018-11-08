from PersonDAO import PersonDAO

p = PersonDAO()
list1 = p.selectFromPerson()
for person in list1:
	print(person.id, person.name, person.email)

class EducationDTO():

    def __init__(self, id, person, university, degree_type, startdate, enddate):
        self.id = id
        self.person = person
        self.university = university
        self.degree_type = degree_type
        self.startdate = startdate
        self.enddate = enddate

    def serialize(self): 
        return {
            'id': self.id,
            'university': self.university,
            'degree_type': self.degree_type,
            'startdate': self.startdate,
            'enddate': self.enddate
        }	
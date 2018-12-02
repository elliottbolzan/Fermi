class ExperienceDTO():

    def __init__(self, id, person, company, position, startdate, enddate):
        self.id = id
        self.person = person
        self.company = company
        self.position = position
        self.startdate = startdate
        self.enddate = enddate

    def serialize(self): 
        return {
            'id': self.id,
            'company': self.company,
            'position': self.position,
            'startdate': self.startdate,
            'enddate': self.enddate
        }	
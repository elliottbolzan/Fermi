class QualitiesDTO():

    def __init__(self, identifier, generosity, impact, popularity, success):
        self.identifier = int(identifier)
        self.generosity = int(generosity)
        self.impact = int(impact)
        self.popularity = int(popularity)
        self.success = int(success)

    def serialize(self): 
        return {
            'generosity': self.generosity,
            'impact': self.impact,
            'popularity': self.popularity,
            'success': self.success
        }	
import psycopg2
from PersonDTO import PersonDTO
from EducationDTO import EducationDTO
from ExperienceDTO import ExperienceDTO
from QualitiesDTO import QualitiesDTO
from Connection import Connection

class PersonDAO():
        
    def createPerson(self, identifier, name):
        person = self.getPerson(identifier)
        if not person:
            values = (identifier, name)
            sql = self.queryFromFile("create_user.sql")
            conn = None
            try:
                conn = Connection()
                conn.cur.execute(sql, values)
                conn.commit()
                conn.close()
                person = self.getPerson(identifier)
            except (Exception, psycopg2.DatabaseError) as error:
                print(error)
                Person = None
            finally: 
                if conn is not None:
                    conn.close()
        return person
    
    def filter(self, parameters):
        qualities = ""
        for quality in parameters["qualities"]:
           qualities += "AND qualities." + quality["name"].lower() + " >= " + str(quality["percentile"]) + "\n"
        sql = self.queryFromFile("filter_start.sql") + qualities + self.queryFromFile("filter_end.sql")
        name, company, university = "%" + parameters["name"] + "%", "%" + parameters["company"] + "%", "%" + parameters["university"] + "%"
        values = (name, name, company, name, university)
        conn = None
        people = []
        try:
            conn = Connection()
            conn.cur.execute(sql, values)
            rows = conn.cur.fetchall()
            for row in rows:
                identifier, name = row[0], row[1]
                education = [EducationDTO(row[2], identifier, *row[3:7]), EducationDTO(row[7], identifier, *row[8:12]), EducationDTO(row[12], identifier, *row[13:17])]
                experience = [ExperienceDTO(identifier, *row[17:22])]
                qualities = QualitiesDTO(identifier, *row[22:26])
                lastActive = row[26]
                person = PersonDTO(identifier, name, education, experience, qualities, lastActive)
                people.append(person)
            conn.close()
            return people
        except (Exception, psycopg2.DatabaseError) as error:
            print(error)
        finally: 
            if conn is not None:
                conn.close()
        return people

    def getPerson(self, identifier):
        sql = self.queryFromFile("get_user.sql")
        values = (identifier, )
        conn = None
        try:
            conn = Connection()
            conn.cur.execute(sql, values)
            result = conn.cur.fetchone()
            if result is not None:
                identifier, name = result
                education, experience, qualities, lastActive = self.getEducation(identifier), self.getExperience(identifier), self.getQualities(identifier), self.getLastActive(identifier)
                return PersonDTO(identifier, name, education, experience, qualities, lastActive)
        except (Exception, psycopg2.DatabaseError) as error:
            print(error) 
        finally:
            if conn is not None:
                conn.close()
        return None

    def getEducation(self, identifier):   
        sql = self.queryFromFile("education.sql")
        values = (identifier, )
        result = []
        try:
            conn = Connection()
            conn.cur.execute(sql, values)
            rows = conn.cur.fetchall()
            for row in rows:
                print(row)
                result.append(EducationDTO(*row))
        except (Exception, psycopg2.DatabaseError) as error:
            print(error) 
        finally:
            if conn is not None:
                conn.close()
        return result

    def getExperience(self, identifier):   
        sql = self.queryFromFile("experience.sql")
        values = (identifier, )
        result = []
        try:
            conn = Connection()
            conn.cur.execute(sql, values)
            rows = conn.cur.fetchall()
            for row in rows:
                result.append(ExperienceDTO(*row))
        except (Exception, psycopg2.DatabaseError) as error:
            print(error) 
        finally:
            if conn is not None:
                conn.close()
        return result
    
    def getQualities(self, identifier):
        sql = self.queryFromFile("qualities.sql")
        values = (identifier, )
        qualities = None
        try:
            conn = Connection()
            conn.cur.execute(sql, values)
            row = conn.cur.fetchone()
            if row is not None:
                qualities = QualitiesDTO(*row)
        except (Exception, psycopg2.DatabaseError) as error:
            print(error) 
        finally:
            if conn is not None:
                conn.close()
        return qualities

    def getLastActive(self, identifier):
        sql = self.queryFromFile("last_active.sql")
        values = (identifier, identifier)
        lastActive = None
        try:
            conn = Connection()
            conn.cur.execute(sql, values)
            row = conn.cur.fetchone()
            if row is not None:
                lastActive = row[0]
        except (Exception, psycopg2.DatabaseError) as error:
            print(error) 
        finally:
            if conn is not None:
                conn.close()
        return lastActive

    def queryFromFile(self, filename):
        fd = open("queries/" + filename, "r")
        sql = fd.read()
        fd.close()  
        return sql
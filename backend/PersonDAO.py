import psycopg2
from PersonDTO import PersonDTO
from EducationDTO import EducationDTO
from ExperienceDTO import ExperienceDTO
from QualityDTO import QualityDTO
from Connection import Connection

class PersonDAO():

    def createPerson(self, identifier, name, token):
        person = self.getPerson(identifier)
        if person:
            # Update token.
            values = (token, identifier)
            sql = self.queryFromFile("token/update.sql")
            conn = None
            try:
                conn = Connection()
                conn.cur.execute(sql, values)
                conn.commit()
                conn.close()
            except (Exception, psycopg2.DatabaseError) as error:
                print(error)
            finally: 
                if conn is not None:
                    conn.close()
        else:
            values = (identifier, name, token)
            sql = self.queryFromFile("create_user.sql")
            conn = None
            try:
                conn = Connection()
                conn.cur.execute(sql, values)
                conn.commit()
                conn.close()
            except (Exception, psycopg2.DatabaseError) as error:
                print(error)
            finally: 
                if conn is not None:
                    conn.close()
        person = self.getPerson(identifier)
        return person
    
    def filter(self, parameters):
        name = "%" + parameters["name"] + "%" if parameters["name"] else None
        company = "%" + parameters["company"] + "%" if parameters["company"] else None
        university = "%" + parameters["university"] + "%" if parameters["university"] else None
        values = []
        constraints = 0
        sql = self.queryFromFile("filter/base.sql")
        if name:
            sql, constraints = self.appendToSQL(sql, self.queryFromFile("filter/person.sql"), constraints)
            values.append(name)
        if company:
            sql, constraints = self.appendToSQL(sql, self.queryFromFile("filter/work.sql"), constraints)
            values.append(company)
        if university:
            sql, constraints = self.appendToSQL(sql, self.queryFromFile("filter/education.sql"), constraints)
            values.extend((university, university, university))
        for quality in parameters["qualities"]:
            addition = "Qualities." + quality["name"].lower() + " >= " + str(quality["percentile"])
            sql, constraints = self.appendToSQL(sql, addition, constraints)
        sql += self.queryFromFile("filter/order.sql")
        values = tuple(values)
        conn = None
        people = []
        try:
            conn = Connection()
            conn.cur.execute(sql, values)
            rows = conn.cur.fetchall()
            for row in rows:
                identifier, name = row[0], row[1]
                undergraduate = EducationDTO(row[2], identifier, *row[3:7]) if row [2] else None
                masters = EducationDTO(row[7], identifier, *row[8:12]) if row[7] else None
                doctorate = EducationDTO(row[12], identifier, *row[13:17]) if row[12] else None
                education = [x for x in [undergraduate, masters, doctorate] if x]
                experience = [ExperienceDTO(identifier, *row[17:22])]
                qualities = [QualityDTO("generosity", row[22]), QualityDTO("impact", row[23]), QualityDTO("popularity", row[24]), QualityDTO("success", row[25])]
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
        qualities = []
        try:
            conn = Connection()
            conn.cur.execute(sql, values)
            row = conn.cur.fetchone()
            if row is not None:
                qualities = [QualityDTO("generosity", row[0]), QualityDTO("impact", row[1]), QualityDTO("popularity", row[2]), QualityDTO("success", row[3])]
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
    
    def appendToSQL(self, sql, additional, constraints):
        if constraints == 0:
            sql += "WHERE "
        else:
            sql += "AND "
        sql += additional + "\n"
        return (sql, constraints + 1)
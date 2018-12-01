# -*- coding: utf-8 -*-
"""
Spyder Editor

This is a temporary script file.
"""

import psycopg2
from PersonDTO import PersonDTO
from Connection import Connection


class PersonDAO():
    
    def selectOnePerson(self, id):
        sql = "SELECT id, name FROM person WHERE id = %s" 
        conn = None
        try:
            conn = Connection()
            conn.cur.execute(sql, (id,))
            row = conn.cur.fetchone()
            Person = PersonDTO(row[0], row[1])
        except (Exception, psycopg2.DatabaseError) as error:
            print(error) 
        finally:
            if conn is not None:
                conn.close()
        if Person:
            return Person
        
    def insertToPerson(self, PersonDTO):
        #sql = "SELECT * FROM person LIMIT 10;"
        Person = self.selectOnePerson(PersonDTO.id)
        if Person: 
            return Person
        else:
            userValues = (PersonDTO.id, PersonDTO.name)
            sql = "INSERT INTO person (id, name) VALUES(%s)"
            conn = None
            try:
                conn = Connection()
                conn.cur.execute(sql, userValues)
                conn.commit()
                conn.close()
            except (Exception, psycopg2.DatabaseError) as error:
                print(error)
                Person = None
            finally: 
                if conn is not None:
                    conn.close()
        Person = self.selectOnePerson(PersonDTO.id)
        return Person
    
    def filter(self, params):
        
        fd = open('sql_queries/filter.sql', 'r')
        sql = fd.read()
        fd.close()        
    
        qualities = ""
        for quality in params["qualities"]:
           qualities += "AND quality." + quality["name"].lower() + " >= " + str(quality["percentile"]) + "\n"
        
        print(params)
        
        name, company, university = params["name"], params["company"], params["university"]
        
        values = (name, name, company, name, university, qualities)
        
        conn = None
        try:
            conn = Connection()
            conn.cur.execute(sql, values)
            conn.commit()
            conn.close()
        except (Exception, psycopg2.DatabaseError) as error:
            print(error)
            Person = None
        finally: 
            if conn is not None:
                conn.close()

        
   
        
    
            

    #tester code, works
    def selectFromPerson(self):
        sql = "SELECT * FROM person LIMIT 10;"
        #PersonDTOList = []
        conn = None
        try:
            conn = Connection()
            conn.query(sql)
            PersonDTOList = conn.getRows(PersonDTO)
            #cur.close()
        except (Exception, psycopg2.DatabaseError) as error:
            print(error) #ask Elliott how to deal with errors later
        finally:
            if conn is not None:
                conn.close()
        if PersonDTOList:
            return PersonDTOList

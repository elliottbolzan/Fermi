# -*- coding: utf-8 -*-
"""
Spyder Editor

This is a temporary script file.
"""

import psycopg2
from PersonDTO import PersonDTO


class PersonDAO():
    
    def insertToPerson(self, PersonDTO):
        sql = "INSERT INTO person (id, name, email) VALUES (" + userValues + ");"
        userValues = "'" + PersonDTO.id + "', '" + PersonDTO.name + "', '" + PersonDTO.email + "'"
        conn = None
        try:
            conn=psycopg2.connect(dbname="fermi")
            cur = conn.cursor()
            cur.execute(sql)
            conn.commit()
            cur.close()
        except (Exception, psycopg2.DatabaseError) as error:
                print(error)
        finally: 
            if conn is not None:
                conn.close()

    def selectFromPerson(self):
        sql = "SELECT * FROM person ORDER BY RANDOM() LIMIT 10;"
        PersonDTOList = []
        conn = None
        try:
            conn=psycopg2.connect(dbname="fermi")
            cur = conn.cursor()
            cur.execute(sql)
            row = cur.fetchone()
            
            while row is not None:
                #print(row)
                row = cur.fetchone()
                myPerson = PersonDTO(row[0], row[1], row[2])
                PersonDTOList.append(myPerson)
            cur.close()
        except (Exception, psycopg2.DatabaseError) as error:
            print(error)
        finally:
            if conn is not None:
                conn.close()
        if PersonDTOList:
            return PersonDTOList



                
                
        

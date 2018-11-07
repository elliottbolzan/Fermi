# -*- coding: utf-8 -*-
"""
Spyder Editor

This is a temporary script file.
"""

import psycopg2


class UserDAO():
    #def __init__(self):

    def insertToUser(self, UserDTO):
        sql = "INSERT INTO user (user_id, name, email) VALUES (" + userValues + ");"
        userValues = "'" + UserDTO.user_id + "', '" + UserDTO.name + "', '" + UserDTO.email + "'"
        conn = None
        try:
            conn=psycopg2.connect("dbname='template1' user='dbuser' password='mypass'")
            cur = conn.cursor()
            cur.execute(sql)
            conn.commit()
            cur.close()
        except:
            print("I am unable to connect to the database and execute")
        finally: 
            if conn is not None:
                conn.close()
                
                
        
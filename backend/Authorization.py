import psycopg2
from Connection import Connection

class Authorization():

    def authorized(self, headers):
        identifier, token = headers["id"] if "id" in headers else None, headers["Authorization"] if "Authorization" in headers else None
        if identifier is None or token is None:
            return False
        values = (identifier, token)
        sql = self.queryFromFile("token/check.sql")
        conn = None
        try:
            conn = Connection()
            conn.cur.execute(sql, values)
            conn.commit()
            row = conn.cur.fetchone()
            conn.close()
            if row:
                return True
            conn.close()
        except (Exception, psycopg2.DatabaseError) as error:
            print(error)
        finally: 
            if conn is not None:
                conn.close()
        return False

    def queryFromFile(self, filename):
        fd = open("queries/" + filename, "r")
        sql = fd.read()
        fd.close()  
        return sql
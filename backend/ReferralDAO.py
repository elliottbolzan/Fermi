import psycopg2
from ReferralDTO import ReferralDTO
from Connection import Connection

class ReferralDAO():

    def createReferral(self, referral):
        values = (referral.sender, referral.recipient, referral.company, referral.status, referral.timestamp)
        sql = self.queryFromFile("create_referral.sql")
        conn = None
        try:
            conn = Connection()
            conn.cur.execute(sql, values)
            conn.commit()
            referral.identifier = conn.cur.fetchone()[0]
            conn.close()
        except (Exception, psycopg2.DatabaseError) as error:
            print(error)
            Referral = None
        finally: 
            if conn is not None:
                conn.close()
        return referral
    
    def updateReferral(self, referral):
        print(referral.serialize())
        values = (referral.status, referral.timestamp, referral.identifier)
        sql = self.queryFromFile("update_referral.sql")
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
        return referral

    def getReferral(self, identifier):
        sql = self.queryFromFile("get_referral.sql")
        values = (identifier, )
        result = []
        try:
            conn = Connection()
            conn.cur.execute(sql, values)
            rows = conn.cur.fetchall()
            for row in rows:
                result.append(ReferralDTO(*row))
        except (Exception, psycopg2.DatabaseError) as error:
            print(error) 
        finally:
            if conn is not None:
                conn.close()
        return result

    def queryFromFile(self, filename):
        fd = open("queries/" + filename, "r")
        sql = fd.read()
        fd.close()  
        return sql
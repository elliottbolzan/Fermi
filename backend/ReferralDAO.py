import psycopg2
from ReferralDTO import ReferralDTO
from Connection import Connection

class ReferralDAO():

    def createReferral(self, referral):
        if referral.sender == referral.recipient:
            return None
        values = (referral.sender, referral.recipient, referral.sender, referral.status, referral.timestamp)
        sql = self.queryFromFile("create_referral.sql")
        conn = None
        try:
            conn = Connection()
            conn.cur.execute(sql, values)
            conn.commit()
            referral.identifier, referral.company = conn.cur.fetchone()
            conn.close()
        except (Exception, psycopg2.DatabaseError) as error:
            print(error)
            Referral = None
        finally: 
            if conn is not None:
                conn.close()
        return referral
    
    def updateReferral(self, referral):
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

    def queryFromFile(self, filename):
        fd = open("queries/" + filename, "r")
        sql = fd.read()
        fd.close()  
        return sql
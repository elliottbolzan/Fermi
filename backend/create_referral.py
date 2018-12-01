def selectOneReferral(self, id):
    sql = "SELECT id FROM referrals WHERE id = %s"
    conn = None
        try:
            conn = Connection()
            conn.cur.execute(sql, (id,))
            row = conn.cur.fetchone()
            Referral = ReferralDTO(row[0], row[1])
        except (Exception, psycopg2.DatabaseError) as error:
            print(error) 
        finally:
            if conn is not None:
                conn.close()
        if Referral:
            return Referral

def createReferral():
    Referral = self.selectOneReferral(ReferralDTO.id)
    if Referral:
        return Referral
    else:
        referralValues = (ReferralDTO.id, ReferralDTO.sender, ReferralDTO.recipient, ReferralDTO.company, ReferralDTO.status, ReferralDTO.timestamp)
        sql = "INSTERT INTO Referrals(id, sender, recipient, company, status, timestamp) VALUES(%s)"
        conn = None
        try:
            conn = Connection()
            conn.cur.execute(sql, referralValues)
            conn.commit()
            conn.close()
        except (Exception, psycopg2.DatabaseError) as error:
            print(error)
            Referral = None
        finally: 
            if conn is not None:
                conn.close()
    Referral = self.selectOneReferral(ReferralDTO.id)
    return Referral
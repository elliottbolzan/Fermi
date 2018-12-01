
    def updateReferral(self, ReferralDTO):
            #sql = "SELECT * FROM person LIMIT 10;"

            Referral = self.selectOneReferral(ReferralDTO.id)

            if Referral: 
                referralValues = (referralDTO.status)
                sql = "UPDATE Referrals SET (status) = referralValues(%s) WHERE id = ReferralDTO.id"
                conn = None
                try:
                    conn = Connection()
                    conn.cur.execute(sql, referralValues)
                    conn.commit()
                    conn.closer()
                except (Exception, psycopg2.DatabaseError) as error:
                    print(error)
                    Referral = None
                finally:
                    if conn is not None:
                        conn.close()
            else:
                return Referral
                
            Referral = self.selectOneReferral(ReferralDTO.id)
            return Referral


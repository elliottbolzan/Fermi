
import psycopg2

class Connection():
    def __init__(self, db="fermi"):
        self.conn = psycopg2.connect(database=db)
        self.cur = self.conn.cursor()
    
    def query(self, query):
        self.cur.execute(query)
        
    def getRows(self, DTOList, DTO):
        DTOList = []
        row = self.cur.fetchone()
        while row is not None:
            print(row)
            row = self.cur.fetchone()
            obj = DTO(row[0], row[1])
            DTOList.append(obj)  
        return DTOList
        
    def commit(self):
        self.conn.commit()
    
    def close(self):
        self.cur.close()
        self.conn.close()



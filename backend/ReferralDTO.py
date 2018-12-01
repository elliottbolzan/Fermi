import datetime

class ReferralsDTO():
    def __init__(self, id, sender, recipient, company, status):
        self.id = id
        self.sender = sender
        self.recipient = recipient
        self.company = company
        self.status = status
        st = datetime.datetime.fromtimestamp(ts).strftime('%Y-%m-%d %H:%M:%S')
        self.timestamp = st
    
    def serialize(self):
        return
            {
            'id': self.id,
            'sender': self.sender,
            'recipient': self.recipient,
            'company': self.company,
            'status': self.status,
            'timestamp': self.timestamp
        }

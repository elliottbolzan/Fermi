class ReferralsDTO():
    def __init__(self, id, sender, recipient, company, status, timestamp):
        self.id = id
        self.sender = sender
        self.recipient = recipient
        self.company = company
        self.status = status
        self.timestamp = timestamp
    
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

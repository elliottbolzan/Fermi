import datetime
import time

class ReferralDTO():
    def __init__(self, identifier, sender, recipient, company, status, timestamp = -1):
        self.identifier = identifier
        self.sender = sender
        self.recipient = recipient
        self.company = company
        self.status = status
        self.timestamp = timestamp
        if self.timestamp == -1:
            self.timestamp = self.currentTime()

    @staticmethod
    def currentTime():
        return datetime.datetime.fromtimestamp(time.time()).strftime('%Y-%m-%d %H:%M:%S')
    
    def serialize(self):
        return {
            'id': self.identifier,
            'sender': self.sender,
            'recipient': self.recipient,
            'company': self.company,
            'status': self.status,
            'timestamp': self.timestamp
        }
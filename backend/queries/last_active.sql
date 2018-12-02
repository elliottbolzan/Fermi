SELECT timestamp
FROM Referrals
WHERE sender = %s OR recipient = %s
ORDER BY timestamp DESC
LIMIT 1;
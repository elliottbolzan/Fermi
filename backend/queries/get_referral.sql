SELECT *
FROM Referrals
WHERE sender = %s OR recipient = %s;
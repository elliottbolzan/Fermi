--add new referral
INSERT INTO Referrals VALUES ('30000000', '1', '2', '1', 'requested', TIMESTAMP '2011-05-16 15:36:38');

--update referral status when granted
UPDATE Referrals
SET status='granted'
WHERE id = '3';

--update referral status when offered
UPDATE Referrals
SET status='offered'
WHERE id = '3';

--update referral status when denied
UPDATE Referrals
SET status='denied'
WHERE id = '3';

--update referral status when rejected
UPDATE Referrals
SET status='rejected'
WHERE id = '3';
--add new referral
INSERT INTO Referrals VALUES ('30000000', '1', '2', '1', FALSE, TIMESTAMP '2011-05-16 15:36:38');

--update referral status
UPDATE Referrals
SET status=TRUE
WHERE id = '3';
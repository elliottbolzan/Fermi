--add new referral
INSERT INTO Referrals VALUES ('10000000', '10000000', '10000000', '10000000', FALSE, TIMESTAMP '2011-05-16 15:36:38');

--update referral status
UPDATE Referrals
SET status=TRUE
WHERE id = '10000000';

SELECT sender, Count(status) from Referrals WHERE
	status = true GROUP BY sender  LIMIT 10;

SELECT sender, Count(status) from Referrals GROUP BY sender LIMIT 10;

SELECT recipient, Count(status) from Referrals WHERE
	status = true GROUP BY recipient LIMIT 10;

SELECT recipient, Count(status) from Referrals GROUP BY recipient LIMIT 10;

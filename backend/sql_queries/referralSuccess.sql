
SELECT from, Count(status) from Referrals WHERE
	status = true GROUP BY from

SELECT from, Count(status) from Referrals GROUP BY from

SELECT to, Count(status) from Referrals WHERE
	status = true GROUP BY to

SELECT to, Count(status) from Referrals GROUP BY to

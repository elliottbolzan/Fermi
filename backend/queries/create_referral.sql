INSERT INTO Referrals AS r VALUES(DEFAULT, %s, %s, %s, %s, %s) RETURNING id, (
    SELECT name
    FROM Company
    WHERE id = r.company
);
INSERT INTO Referrals AS r VALUES(DEFAULT, %s, %s, (
    SELECT Company.id
    FROM Company, Experience
    WHERE Company.id = Experience.company
    AND Experience.person = %s
), %s, %s) RETURNING id, (
    SELECT name
    FROM Company
    WHERE id = r.company
);
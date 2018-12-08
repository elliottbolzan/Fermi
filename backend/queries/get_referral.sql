SELECT 
    r.id, (
    SELECT name
    FROM Person AS p
    WHERE p.id = r.sender
    ),
    (
        SELECT name
        FROM Person AS p
        WHERE p.id = r.recipient
    ),
    (
        SELECT name
        FROM Company AS c
        WHERE c.id = r.company
    ),
    r.status,
    r.timestamp
FROM Referrals AS r
WHERE sender = %s OR recipient = %s;
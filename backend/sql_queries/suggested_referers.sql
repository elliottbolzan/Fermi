SELECT EE.user_id
FROM educational_experience AS EE
WHERE EE.university_name = (SELECT university_name
						FROM educational_experience
						WHERE user_id = '1')
LIMIT 6;
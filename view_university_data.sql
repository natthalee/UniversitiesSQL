-- create view
CREATE VIEW university_data AS

SELECT 
	u.university_name,
	(
		SELECT 
			COUNT(s2.id) 
		FROM 
			Students s2 
		WHERE 
			s2.university_id = u.id
	) AS students,

	(
		SELECT 
			COUNT(l2.id) 
		FROM 
			Lecturers l2 
		WHERE 
			l2.university_id = u.id
	) AS lecturers,

	(
		(
			SELECT 
				COUNT(s2.id)
			FROM 
				Students s2
			WHERE 
				u.id = s2.university_id
				AND s2.gender = 'M'
		) +
		(
			SELECT 
				COUNT(l2.id)
			FROM 
				Lecturers l2
			WHERE 
				u.id = l2.university_id
				AND l2.gender = 'M'
		) 
	) AS male,

	(
		(
			SELECT 
				COUNT(s2.id)
			FROM 
				Students s2
			WHERE 
				u.id = s2.university_id
				AND s2.gender = 'F'
		) +
		(
			SELECT 
				COUNT(l2.id)
			FROM 
				Lecturers l2
			WHERE 
				u.id = l2.university_id
				AND l2.gender = 'F'
		) 
	) AS female,

	(
		SELECT 
			COUNT(ll2.id) 
		FROM 
			Lectures ll2 
		WHERE 
			u.id = ll2.university_id
	) AS lectures,

	(
		SELECT 
			COUNT(r2.id)
		FROM 
			RegistratiONs r2
		JOIN Students AS s2 
			ON r2.student_id = s2.id
		WHERE 
			u.id = s2.university_id
	) AS registrations,

	(
		SELECT 
			COUNT(g2.id)
		FROM 
			Grades g2
		JOIN Registrations AS r2 
			ON g2.registration_id = r2.id
		JOIN Students AS s2 
			ON s2.id = r2.student_id
		WHERE 
			u.id = s2.university_id
	) AS grades

FROM Universities u;

-- display view
GO
SELECT * FROM university_data;
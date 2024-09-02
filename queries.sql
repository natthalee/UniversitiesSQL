-- QUERY 1 STUDENT WITH TOP AVERAGE --
/*	top 1 student each year and major
	avg is 4.0 or higher */

WITH StudentAvg AS (
	SELECT
		CONCAT_WS(' ', s.name, s.last_name) AS student,
		s.year,
		m.major_name,
		CAST(AVG(g.grade) AS DECIMAL(3, 2)) AS avg_grade
	FROM
	    Students s
	RIGHT JOIN Registrations AS r
	    ON s.id = r.student_id
	RIGHT JOIN Grades AS g
	    ON r.id = g.registration_id
	LEFT JOIN Majors AS m
	    ON s.major_id = m.id
	WHERE
	    s.student_status = 'Active'
	GROUP BY
		s.name, 
		s.last_name, 
		s.year, 
		m.major_name
),

MaxAvgYearMajor AS (
	SELECT
		year,
		major_name,
		MAX(avg_grade) as max_avg_grade
	FROM
	    StudentAvg
	GROUP BY
		year,
		major_name
)

SELECT
	sa.student,
	sa.year,
	sa.major_name,
	sa.avg_grade
FROM
    StudentAvg sa
JOIN MaxAvgYearMajor AS ma
	ON sa.year = ma.year
	AND sa.major_name = ma.major_name
	AND sa.avg_grade = ma.max_avg_grade
WHERE
    sa.avg_grade >= 4.0
ORDER BY
	sa.major_name,
	sa.year;



-- QUERY 2 SHARED LECTURES --
-- find students and lecturers who are registered for all of the lecturer's classes
SELECT
	concat_ws(' ', s.name, s.last_name) AS student_name,
	concat_ws(' ', l.name, l.last_name) AS lecturer_name,
	COUNT(ll.lecture_name) AS count_students_lectures
FROM
    Students s
RIGHT JOIN Registrations AS r
    ON s.id = r.student_id
LEFT JOIN Lectures AS ll
    ON r.lecture_id = ll.id
LEFT JOIN Lecturers AS l
    ON ll.lecturer_id = l.id
WHERE
    s.student_status = 'Active'
GROUP BY
	s.name,
	s.last_name,
	l.name,
	l.last_name
HAVING
	COUNT(ll.lecture_name) = (
		SELECT
		    COUNT(ll2.lecture_name)
		FROM
		    Lecturers l2
		RIGHT JOIN Lectures ll2
		    ON l2.id = ll2.lecturer_id
		WHERE
		    l2.name = l.name
		    AND l2.last_name = l.last_name
		GROUP BY
			l2.name,
			l2.last_name
	)
ORDER BY
    count_students_lectures DESC;
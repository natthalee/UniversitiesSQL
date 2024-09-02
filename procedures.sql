-- PROCEDURE 1 DELETE INACTIVE STUDENTS DATA --
/*	1) find students without grades or registrations
	2) delete their registrations
	3) change student_status to 'Inactive'*/
CREATE PROCEDURE DeleteInactiveStudentsData
AS
	BEGIN
	    -- delete registrations for students without grades
		DELETE
		    r
		FROM
		    Registrations r
		INNER JOIN Students AS s
		    ON r.student_id = s.id
		LEFT JOIN Grades AS g
		    ON r.id = g.registration_id
		WHERE
		    g.id IS NULL;

        -- Set student_status to Inactive
		UPDATE
		    s
		SET
		    s.student_status = 'Inactive'
		FROM
		    Students AS s
		LEFT JOIN Registrations AS r
	        ON s.id = r.student_id
		LEFT JOIN Grades AS g
		    ON r.id = g.registration_id
        WHERE
            r.id IS NULL
            OR g.id IS NULL;
	END;
GO

-- run
EXEC DeleteInactiveStudentsData
GO



-- PROCEDURE 2 ADD NEW LECTURER --
-- add new lecturer
CREATE PROCEDURE AddNewLecturer
	@Name VARCHAR(255),
	@LastName VARCHAR(255),
	@Gender CHAR(1),
	@Birthdate DATE,
	@UniversityId INT
AS
	BEGIN
		INSERT INTO Lecturers (name, last_name, gender, birthdate, university_id)
			VALUES (@Name, @LastName, @Gender, @Birthdate, @UniversityId);
	END;
GO

--example
EXEC AddNewLecturer 
    @Name = 'Ana',
    @LastName = 'Smith',
    @Gender = 'F',
    @Birthdate = '1975-05-15',
    @UniversityId = 2;
GO


-- PROCEDURE 3 SHOW GRADES REPORT --
-- show student's grade report
-- report contains avg grades from each lecture
CREATE PROCEDURE ShowGradesReport
	@StudentId INT

AS
	BEGIN
		SELECT DISTINCT
			s.id, 
			l.lecture_name, 
			(
				SELECT
				    AVG(g2.grade)
				FROM
				    Grades g2
				JOIN Registrations AS r2
				    ON r2.id = g2.registration_id
				JOIN Lectures AS l2
				    ON r2.lecture_id = l2.id
				WHERE
				    l2.lecture_name = l.lecture_name
			) as avg_grade

		FROM Students s

		JOIN Registrations AS r
		     ON s.id = r.student_id
		JOIN Lectures AS l
		     ON r.lecture_id = l.id
		JOIN Grades g
		     ON r.id = g.registration_id
		WHERE
		    s.id = @StudentId
		ORDER BY
		    s.id;
	END;
GO

-- example
EXEC ShowGradesReport 
	@StudentId = 13;
GO

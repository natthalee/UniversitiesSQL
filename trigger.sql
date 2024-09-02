-- create error messages
EXEC sp_addmessage
	@msgnum = 50001, 
	@severity = 16,
	@msgtext = 'Student can sign up for a maximum number of 7 lectures.'
GO

EXEC sp_addmessage
	@msgnum = 50002, 
	@severity = 16,
	@msgtext = 'It is not allowed to register a student with an Inactive status for a lecture'
GO


-- create trigger
CREATE TRIGGER check_registrations_number
ON Registrations
FOR INSERT
AS
BEGIN
	DECLARE @StudentId INT
	DECLARE @StudentStatus VARCHAR(255)

	SELECT 
		@StudentId = student_id 
	FROM 
		inserted

	SELECT 
		@StudentStatus = s.student_status 
	FROM 
		Students s
	JOIN inserted i 
		ON i.student_id = s.id

	IF(SELECT count(*) FROM Registrations WHERE student_id = @StudentId) >= 7
	BEGIN
		RAISERROR(50001, 16, 1)
		ROLLBACK
	END

	IF(@StudentStatus = 'Inactive')
	BEGIN
		RAISERROR(50002, 16, 1)
		ROLLBACK
	END	
END
GO


-- use trigger to test lectures limit
GO
DECLARE @StudentId INT

SELECT TOP 1
	@StudentId = student_id
FROM
	Registrations
GROUP BY
	student_id
ORDER BY
	count(*) DESC;

INSERT INTO Registrations (student_id, lecture_id, registration_date)
    VALUES (@StudentId, 1, getdate());


-- use trigger to test for inactive student
GO
DECLARE @StudentId INT;

SELECT TOP 1
    @StudentId = id
FROM
    Students
WHERE
    student_status = 'Inactive';

INSERT INTO Registrations (student_id, lecture_id, registration_date)
    VALUES (@StudentId, 1, getdate());


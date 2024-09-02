-- Creating database
CREATE DATABASE UniversitiesSQL
GO

-- Defining to use database
USE UniversitiesSQL
GO

-- Creating tables
CREATE TABLE Universities (
    id INT IDENTITY(1,1) PRIMARY KEY,
    university_name VARCHAR(255) NOT NULL,
    city VARCHAR(255) NOT NULL,
    country VARCHAR(255) NOT NULL,
    foundation_date DATE NOT NULL
);

CREATE TABLE Majors (
    id INT IDENTITY(1,1) PRIMARY KEY,
    major_name VARCHAR(255) NOT NULL
);

CREATE TABLE Lecturers (
    id INT IDENTITY(1,1) PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
	gender CHAR(1) NOT NULL,
    birthdate DATE NOT NULL,
    university_id INT NOT NULL,
    FOREIGN KEY (university_id) REFERENCES Universities(id)
);

CREATE TABLE Lectures (
    id INT IDENTITY(1,1) PRIMARY KEY,
    lecture_name VARCHAR(255) NOT NULL,
    lecturer_id INT NOT NULL,
    major_id INT NOT NULL,
    university_id INT NOT NULL,
    FOREIGN KEY (lecturer_id) REFERENCES Lecturers(id),
    FOREIGN KEY (major_id) REFERENCES Majors(id),
    FOREIGN KEY (university_id) REFERENCES Universities(id)
);

CREATE TABLE Students (
    id INT IDENTITY(1,1) PRIMARY KEY,
	student_status varchar(255) DEFAULT 'Active',
    name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    gender CHAR(1) NOT NULL,
    birthdate DATE NOT NULL,
    university_id INT NOT NULL,
    major_id INT NOT NULL,
    year INT NOT NULL,
    FOREIGN KEY (major_id) REFERENCES Majors(id),
    FOREIGN KEY (university_id) REFERENCES Universities(id)
);

CREATE TABLE Registrations (
    id INT IDENTITY(1,1) PRIMARY KEY,
    student_id INT NOT NULL,
    lecture_id INT NOT NULL,
    registration_date DATE NOT NULL,
    FOREIGN KEY (student_id) REFERENCES Students(id),
    FOREIGN KEY (lecture_id) REFERENCES Lectures(id)
);

CREATE TABLE Grades (
    id INT IDENTITY(1,1) PRIMARY KEY,
    registration_id INT NOT NULL,
    grade DECIMAL(2, 1) NOT NULL,
    date DATE NOT NULL,
    FOREIGN KEY (registration_id) REFERENCES Registrations(id)
);


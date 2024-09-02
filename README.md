# UniversitiesSQL
UniversitiesSQL is a relational database designed to manage and analyze information related to universities, students and grades.

## Getting Started

### 1. Load the database
* Open your SQL environment (recommended SQL Server Management Studio).
* Run the 'ddl.sql' file to create the database and tables.

### 2. Insert data
* Run the 'dml.sql' file to insert data into tables.

### 3. Run other files
* It's recommended to run 'DeleteInactiveStudentsData' procedure from 'procedures.sql' file before executing 'trigger.sql' file.
* You can run other files in any order.

## Content

### Files
* **`ddl.sql`**: 
  - **Description**: Contains Data Definition Language (DDL) statements to create the database. It defines tables such as: Universities, Students, Majors, Lecturers, Lectures, Registrations, Grades, including primary and foreign key constraints.

* **`dml.sql`**:
  - **Description**: Contains Data Manipulation Language (DML) statements to insert data into the database.

* **`queries.sql`**:
  - **Description**: Includes two SQL queries.
  - **Top 1 Student Each Year and Major**:
    - Identifies the top-performing student for each year and major, provided their average grade is 4.0 or higher.
  - **Students Registered for All of a Lecturer's Classes**:
    - Finds students who are registered for every class offered by a specific lecturer.


* **`view_universities_data.sql`**:
  - **Description**: Contains SQL view that provides a summary of university data, including number of students, lecturers, lectures, registrations, and grades.

* **`procedures.sql`**:
  - **Description**: Includes procedures for: deleting inactive students data, adding new lecturers, generating grade reports for students.
  - **DeleteInactiveStudentsData**:
    -  Deletes registrations for students without any grades or registrations and changes their `student_status` to 'Inactive'.
  - **AddNewLecturer**:
    - Adds a new lecturer to the database.
  - **ShowGradesReport**
    - Generates a grade report for a specific student, including average grades for each lecture.

* **`trigger.sql`**:
  - **Description**: Contains SQL trigger which is used to ensure that students do not exceed the lecture registrations limit and that only active students can be registered for lectures.



### Database diagram
![drawSQL-image-export-2024-08-29](https://github.com/user-attachments/assets/7f0fddba-95e5-4f4b-bf1e-cc05b35951fc)

## Tools used
* **Table design:** Designed tables and relationship manually.
* **Data generation:** Data generated using [Mockaroo](https://www.mockaroo.com/) and ChatGPT
* **Database diagram:** Created using [DrawSQL](https://drawsql.app/)


Task 1: Create a table named Employee Details

CREATE TABLE Employee_Details (
    EmployeeID SERIAL PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Email VARCHAR(100) NOT NULL UNIQUE,
    PhoneNumber VARCHAR(15),
    HireDate DATE NOT NULL,
    Salary DECIMAL(10, 2) NOT NULL,
    DepartmentID INT,
    IsActive BOOLEAN NOT NULL,
    JobTitle VARCHAR(100) NOT NULL
);


Task 2: Insert data into the Employee_Details Table

INSERT INTO Employee_Details (FirstName, LastName, Email, PhoneNumber, HireDate, Salary, DepartmentID, IsActive, JobTitle)
VALUES 
('John', 'Doe', 'john.doe@example.com', '9876543210', '2020-01-01', 60000.00, 1, TRUE, 'Software Engineer'),
('Jane', 'Smith', 'jane.smith@example.com', '9887654321', '2019-05-15', 55000.00, 2, TRUE, 'HR Manager'),
('Alex', 'Johnson', 'alex.johnson@example.com', '9901234567', '2021-02-20', 70000.00, 3, FALSE, 'Financial Analyst'),
('Emily', 'Davis', 'emily.davis@example.com', '9912345678', '2022-04-30', 45000.00, 1, TRUE, 'QA Engineer'),
('Michael', 'Brown', 'michael.brown@example.com', '9923456789', '2023-08-10', 80000.00, 4, TRUE, 'Project Manager');



Task 3: Insert Data from a CSV File into the SQL Table

For inserting data from a CSV file, use the `COPY` command or a similar import method in PostgreSQL:

COPY Employee_Details(FirstName, LastName, Email, PhoneNumber, HireDate, Salary, DepartmentID, IsActive, JobTitle)
'C:/SQL_task1/Employee_Details.csv' delimiter ',' csv header;


Task 4: Update the Employee_Details Table
UPDATE Employee_Details
SET DepartmentID = 0
WHERE IsActive = FALSE;


Task 5: Salary Increment for Specific Employees
UPDATE Employee_Details
SET Salary = Salary * 1.08
WHERE IsActive = FALSE
  AND DepartmentID = 0
  AND JobTitle IN ('HR Manager', 'Financial Analyst', 'Business Analyst', 'Data Analyst');


Task 6: Query to Find Employees with Custom Column Names
SELECT FirstName AS Name, LastName AS Surname
FROM Employee_Details
WHERE Salary BETWEEN 30000 AND 50000;


Task 7: Query to Find Employees Whose FirstName Starts with 'A'
SELECT *
FROM Employee_Details
WHERE FirstName LIKE 'A%';


Task 8: Delete Rows with EmployeeID from 1 to 5
DELETE FROM Employee_Details
WHERE EmployeeID BETWEEN 1 AND 5;

Task 9: Rename Table and Columns

ALTER TABLE Employee_Details RENAME TO employee_database;

ALTER TABLE employee_database RENAME COLUMN FirstName TO Name;
ALTER TABLE employee_database RENAME COLUMN LastName TO Surname;



Task 10: Add State Column and Update Data in PostgreSQL

1. Add the State column:
ALTER TABLE employee_database
ADD COLUMN State VARCHAR NOT NULL;

2. Update the State column:
UPDATE employee_database
SET State = CASE
    WHEN IsActive = TRUE THEN 'India'
    ELSE 'USA'
END;

This will set the `State` to `'India'` for active employees (`IsActive = TRUE`) and `'USA'` for inactive employees (`IsActive = FALSE`).



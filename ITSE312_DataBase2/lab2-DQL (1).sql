
USE ITDatabase;
GO

--==============  Basic SELECT ===================================
-- List all students
SELECT * 
	FROM Students;

-- Filtered single attribute
SELECT Id AS [الرقم الدراسي],
       [Name] AS [Student Name] 	   
	FROM Students
	WHERE Semester = 1;

-- Filtered more attributes used (using AS is optional)
SELECT Id AS [Student No],[Name] [Student Name] 	   
	FROM Students
	WHERE Semester = 1 AND Gender = 'M'

-- Querying duplication
SELECT DepartmentId AS [Department No]       
	FROM Students;

-- Eliminate duplication
SELECT DISTINCT DepartmentId AS [Department No]       
	FROM Students;

SELECT DISTINCT Municipality  FROM Students


--=========== Date Functions ===============================
-- Birth on month
SELECT Id, Name, BirthDate       
	FROM Students
	WHERE MONTH(Birthdate) = 9;

-- Birth on year
SELECT Id, Name, BirthDate       
	FROM Students
	WHERE YEAR(Birthdate) = 2004;

-- Birth on month and not male
SELECT Id, Name, BirthDate       
	FROM Students
	WHERE MONTH(Birthdate) = 9 AND NOT Gender ='M'

-- Calculate Age
SELECT Id ,Name, ROUND(DATEDIFF(day, BirthDate, GETDATE()) / 365.0,1) AS Age 
	FROM Students
	WHERE Municipality = 'AbuSaleem' AND Gender = 'F'
			

SELECT Id, Name, BirthDate, ROUND(DATEDIFF(day, BirthDate, GETDATE()) / 365.0,1) AS Age
	FROM Students
	WHERE Gender = 'M'

SELECT Id, Name, BirthDate, DATEDIFF(month, BirthDate, GETDATE()) / 12.0 AS Age
	FROM Students

SELECT Id, Name, BirthDate, DATEDIFF(year, BirthDate, GETDATE()) AS Age
	FROM Students

--===============================================================
-- using  NOT

SELECT Id, Name 
	FROM Students
	WHERE Gender = 'M' AND Enrolled = 0

SELECT Id, Name 
	FROM Students
	WHERE Gender = 'M' AND NOT Enrolled = 1


-- IN (value1,value2,vlaue3) 
SELECT Id, Name, Municipality        
	FROM Students
	WHERE Municipality IN ('AinZarah','TripoliCenter');

-- IN (value1,value2,vlaue3)
SELECT Id, Name, BirthDate        
	FROM Students
	WHERE MONTH(BirthDate) NOT IN (2,3,12);


--=============================================================
-- BETWEEN start AND end  - included

SELECT Id, Name, BirthDate        
	FROM Students
	WHERE MONTH(BirthDate) BETWEEN 3 AND 8;

-- BETWEEN start AND end  - included
SELECT Id, StudentId, Mark        
	FROM Semesters
	WHERE Mark BETWEEN 95 AND 100;


--============================================================
-- LIKE '%_'

SELECT Id, Name, Municipality        
	FROM Students
	WHERE Name Like 'A%';


SELECT Id, Name, Municipality        
	FROM Students
	WHERE Name Like '_a%';

-- LIKE '%_'
SELECT Id, Name, Municipality        
	FROM Students
	WHERE Name Like '%l';

--==========================================================

-- GROUP BY - COUNT(), SUM(), AVG(), MAX(), MIN()

-- Student count by municipality
SELECT Municipality, COUNT(Id) StudentsCount
	FROM Students
	GROUP BY Municipality;


-- Count of female by municpality 
SELECT Municipality, COUNT(*) FemaleCount
	FROM Students
	WHERE Gender = 'F'
	GROUP BY Municipality;

-- males and femails count
SELECT Gender,COUNT(Gender)
	FROM Students
	GROUP BY Gender;

-- courses average
SELECT CourseId, ROUND(AVG(Mark),2) Average     
  FROM Semesters
  GROUP BY CourseId

--SELECT CourseId, FORMAT(ROUND(AVG(Mark),2),'0.######') Average     
--  FROM Semesters
--  GROUP BY CourseId


-- Municipality with more than 1 female
SELECT [Municipality], COUNT(Gender) Females
	FROM Students
	WHERE Gender ='F'
	GROUP BY Municipality, Gender HAVING COUNT(Gender) > 1 ;

-- List min and max marks by course
SELECT CourseId, MAX(Mark) MaxMark, MIN(Mark) MinMark
	FROM Semesters
	WHERE IsSuspended <> 1
	GROUP BY CourseId


--==========================================================
-- ORDER BY , Id or name

SELECT Id, Name, Semester, Municipality
	FROM Students
	WHERE Gender = 'M' AND Semester = 2
	ORDER BY Name

SELECT Id, Name, Semester, Municipality
	FROM Students
	WHERE Semester = 2
	ORDER BY Municipality


SELECT Municipality, COUNT(*) AS Cnt
FROM Students
GROUP BY Municipality ORDER BY Cnt DESC


-- Sort by Municipality reversed
SELECT Id, Name, Semester, Municipality
	FROM Students
	ORDER BY Municipality DESC


-- Two levels sort
SELECT Municipality,Name,BirthDate 
FROM Students		
ORDER BY Municipality, BirthDate


-- Female count by municipality desc
SELECT Municipality, COUNT(*) FemaleCount
	FROM Students
	WHERE Gender = 'F'
	GROUP BY Municipality
	ORDER BY FemaleCount DESC

---========================  Joins  =============================

SELECT * FROM [dbo].[Students] stu, [dbo].[Semesters] sem 
	WHERE stu.Id = sem.StudentId

-- Inner join
SELECT * FROM [dbo].[Students] stu 
    INNER JOIN [dbo].[Semesters] sem 
	ON stu.Id = sem.StudentId

SELECT stu.Id, stu.Name, sem.CourseId, sem.Mark 
   FROM [dbo].[Students] stu 
       INNER JOIN [dbo].[Semesters] sem 
	   ON stu.Id = sem.StudentId

-- Left outer join 
SELECT stu.Id, stu.Name, sem.CourseId, sem.Mark 
   FROM [dbo].[Students] stu 
       LEFT OUTER JOIN [dbo].[Semesters] sem 
	   ON stu.Id = sem.StudentId
   WHERE Name LIKE 'A%'

-- Right outer join
SELECT sem.CourseId, sem.Mark,cou.Id,cou.Title 
   FROM [dbo].[Semesters] sem
       RIGHT OUTER JOIN [dbo].[Courses] cou 
	   ON sem.CourseId = cou.Id

-- ===== Full Outer join

SELECT stu.Id, stu.Name, sem.CourseId, sem.Mark 
   FROM [dbo].[Students] stu 
       FULL OUTER JOIN [dbo].[Semesters] sem 
	   ON stu.Id = sem.StudentId

-- ===== Cross join

SELECT stu.Id, stu.Name, sem.CourseId, sem.Mark 
   FROM [dbo].[Students] stu 
       CROSS JOIN [dbo].[Semesters] sem 



--=============== Sub queries

-- As an expression in select
-- List the student with thier highest marks
SELECT Id,Name,
		(SELECT MAX(Mark)  FROM dbo.Semesters sem 
		    WHERE stu.id = sem.StudentId) Maxmark    
  FROM dbo.Students stu

-- As a table in FROM
-- The max mark by semeter type ordered by maxmark
SELECT SemesterType,Maxmark
  FROM (SELECT SemesterType, MAX(Mark) Maxmark  FROM dbo.Semesters GROUP BY SemesterType) sem
  ORDER BY Maxmark DESC

SELECT MAX(Avgmark) Maxavg
  FROM (SELECT StudentId, AVG(Mark) Avgmark   
          FROM dbo.Semesters GROUP BY StudentId) sem

-- subquery in where

SELECT DISTINCT StudentId
  FROM dbo.Semesters
  WHERE Mark > 
   (
      SELECT AVG(Mark) FROM dbo.Semesters
   ) 

-- information about student with marks above the average
SELECT stu.Id,stu.Name
  FROM dbo.Students stu 
  WHERE Id in 
  (
	SELECT DISTINCT StudentId
	FROM dbo.Semesters
		WHERE Mark > 
		(
		  SELECT AVG(Mark) FROM dbo.Semesters
		) 
	)

-- joining subquery
-- List courses whose marks are greater than or equal to the maximum mark of any classfication  

SELECT DISTINCT CourseId
	FROM [dbo].[Semesters] sem
	WHERE sem.Mark >= ANY (
		SELECT MAX(sem.Mark)      
			FROM [dbo].[Semesters] sem
			INNER JOIN [dbo].[Courses] cou
			ON sem.CourseId = cou.Id		
			GROUP BY cou.Classification)  
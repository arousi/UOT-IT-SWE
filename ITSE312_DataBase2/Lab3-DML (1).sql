
USE [ITDatabase];
GO

INSERT INTO [dbo].[Departments]
		([Title],[PhoneNo])
	VALUES
		('General Department',	'0211158672'),
		('Software Engineering','0213458978'),
		('Networking',			'0212348478'),
		('Web Technologies',	'0213515878'),
		('Information Systems',	'0211158322');


CREATE TABLE [dbo].[OtherDep] (
	Id TINYINT ,
	Title NVARCHAR(50),
	PhoneNo CHAR(10)
);
GO

-------------- Insert Into Select --------------------

-- other columns will be null
INSERT INTO [dbo].[OtherDep] (Title)	
	SELECT Title	
	FROM [dbo].[Departments]  

-- Select all columns
INSERT INTO [dbo].[OtherDep] 	
	SELECT * FROM [dbo].[Departments] -- TOP can be used	 

	
----------------- Select into ------------------------
-- New table created and all columns selected 
SELECT *INTO [dbo].[AinZarahStudents]
FROM [dbo].[Students]WHERE Municipality = 'AinZarah';

-- Some columns selected
SELECT Name,BirthDate,GenderINTO [dbo].[PersonalData]
FROM [dbo].[Students]WHERE Semester = 1;

--------------------- Update -------------------------

-- add old columns too
ALTER TABLE [dbo].[Departments] 
	ADD Status NVARCHAR(10) NOT NULL DEFAULT N'NOT ACTIVE';

-- from now on
ALTER TABLE [dbo].[Departments] 
	ADD Status NVARCHAR(10) DEFAULT N'NOT ACTIVE';

UPDATE [dbo].[Departments]
	SET Status = N'Active' 
	WHERE Id = 1;

---------------------- Delete -------------------------
-- Conditional delete
DELETE FROM [dbo].[AinZarahStudents] 
	WHERE Gender = 'M';  -- then comment out 

-- Delete All (be aware)
DELETE FROM [dbo].[Instructors]; 

--------------------------------------------------------


--------------------- Transactions ---------------------

-------------------- Auto Commit  Transaction --------------
DELETE FROM [dbo].[Students]
    WHERE Id = '09223365';  
COMMIT;

INSERT INTO [dbo].[Students]
		(Id,[Name], [PhoneNo], [Semester],[Gender],
		[BirthDate],[Municipality],[DepartmentId],Enrolled)
     VALUES
		('09223365','Zaher Fouad Aljosh',	'+218912123482',2,'F','09-01-2003','TripoliCenter',4,1);



------------------- Implicit Transaction ----------------------
SET IMPLICIT_TRANSACTIONS ON

INSERT INTO [dbo].[Students]
		(Id,[Name], [PhoneNo], [Semester],[Gender],
		[BirthDate],[Municipality],[DepartmentId],Enrolled)
     VALUES
		('09224365','Zaher Fouad Aljosh',	'+218912123482',2,'F','09-01-2003','TripoliCenter',4,1);

SELECT * FROM [dbo].[Students]

ROLLBACK TRANSACTION

--COMMIT TRANSACTION   -- comment the current and start new one automatically

--INSERT INTO [dbo].[Students]
--		(Id,[Name], [PhoneNo], [Semester],[Gender],
--		[BirthDate],[Municipality],[DepartmentId],Enrolled)
--     VALUES
--		('09123365','Zaher Fouad Aljosh',	'+218912123482',2,'F','09-01-2003','TripoliCenter',4,1);

--ROLLBACK TRANSACTION   -- will be rolled back

SET IMPLICIT_TRANSACTIONS OFF



--------------------- Explicit Transaction ---------------
BEGIN TRANSACTION;  
DELETE FROM [dbo].[Students]
    WHERE Id = '09223365'  ;  
ROLLBACK;
--COMMIT; 

--------- 
BEGIN TRAN AddStudent  
     INSERT INTO [dbo].[Students]		
	 	(Id,[Name], [PhoneNo], [Semester],[Gender],
		[BirthDate],[Municipality],[DepartmentId],Enrolled)
     VALUES
		('09223365','Zaher Fouad Aljosh',	'+218912123482',2,'F','09-01-2003','TripoliCenter',4,1);  
ROLLBACK TRAN AddStudent;  
  
INSERT INTO [dbo].[Students]	
		(Id,[Name], [PhoneNo], [Semester],[Gender],
		[BirthDate],[Municipality],[DepartmentId],Enrolled)
     VALUES
		('09223323','Mohamed Ahemd',	'+218912123482',2,'F','09-01-2003','TripoliCenter',4,1);  
SELECT * FROM [dbo].[Students];  

---- i

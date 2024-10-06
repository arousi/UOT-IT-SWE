
-- Create new database 
CREATE DATABASE ITDatabase;
GO

-- Make it current database
USE ITDatabase;
GO

-- You can delete it !
--DROP Database ITDatabase;
--GO

USE master;
GO

--CREATE DATABASE ITDatabase;
--GO

--USE ITDatabase;
--GO

-- Create new Schema
CREATE SCHEMA test;
GO


-- Create new table 
CREATE TABLE [dbo].[Departments] (
	Id TINYINT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	Title NVARCHAR(50),
	PhoneNo CHAR(10)
);
GO

-- Display table information
EXEC sp_help Departments;
EXEC sp_help Courses;


-- Delete table from the database !
--DROP TABLE IF EXISTS Departments;
--GO

-- If you delete it? recreate it!
CREATE TABLE [dbo].[Departments] (
	Id TINYINT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	Title NVARCHAR(50),
	PhoneNo CHAR(10)
);
GO

-- Fill table with data
INSERT INTO [dbo].[Departments]
		([Title],[PhoneNo])
	VALUES
		('General Department',	'0211158672'),
		('Software Engineering','0213458978'),
		('Networking',			'0212348478'),
		('Web Technologies',	'0213515878'),
		('Information Systems',	'0211158322');
GO

-- ?         
CREATE TABLE Courses (
	Id CHAR(7) NOT NULL PRIMARY KEY,
	Title NVARCHAR(50),
	Credits TINYINT,
	[Classification] VARCHAR(5), -- 'UNI','ELECT','FACTG','FACTS','DEPTS'
	Prerequist VARCHAR(23), -- comma delimeted courseids
	DepartmentId TINYINT CONSTRAINT FK_1 FOREIGN KEY  REFERENCES Departments(Id)
);
GO
-- ?
INSERT INTO [dbo].[Courses]
    ([Id],[Title],[Credits],[Classification],Prerequist,[DepartmentId])
VALUES    
	('ITAR111','Arabic Language I',			2,'UNI',NULL,1),
	('ITEL111','English Language  I',		2,'UNI',NULL,1),
	('ITAR121','Arabic Language II',		2,'UNI','ITAR111',1),
	('ITEL121','English Language  II',		2,'UNI','ITEL111',1),
	('ITMM111','Mathematics I',				3,'FACTG',NULL,1),
	('ITMM121','Mathematics II',			3,'FACTG','ITMM111',1),
	('ITPH111','Physics',					3,'FACTG',NULL,1),
	('ITST111','Fundamentals of statistics',3,'FACTG',NULL,1),
	('ITGS219','Numerical Methods',			3,'FACTG','ITMM121,ITGS122',1),
	('ITGS113','Problem Solving Techniques',3,'FACTS',NULL,1),
	('ITGS122','Introduction to Programming',3,'FACTS','ITGS113',1),
	('ITGS124','System Analysis and Design',3,'FACTS','ITGS113',1),
	('ITNT311','Data Communicationg',		3,'FACTS','ITGS111',1),
	('ITGS213','Intro to Software Engineerin',3,'FACTS','ITGS113',1),
	('ITGS223','Computer Architecture',		3,'FACTS','ITGS126',1),		
	('ITGS302','Operating Systems',			3,'DEPTS','ITGS223',3),
	('ITGS303','IT Project Management',		3,'DEPTS','ITGS213',3),
	('ITNT411','Distributed System',		3,'DEPTS','ITGS302,ITNT311',3),
	('ITSE321','Software Construction',		3,'FACTS','ITGS213, ITGS217',2),		
	('ITSE322','Modern Programming Language',3,'DEPTS','ITGS211',2),
	('ITSE411','Software Design',			3,'DEPTS','ITSE321',2),
	('ITSE412','Advanced Internet programming',3,'DEPTS','ITGS226',2);
GO


--?
CREATE TABLE Students (
	Id CHAR(10),
	Name NVARCHAR(100),
	PhoneNo CHAR(13),
	Semester TINYINT CHECK(Semester > 0),
	Gender CHAR(1) CONSTRAINT Male_Female_Only CHECK(Gender = 'M' OR Gender = 'F'), 
	BirthDate Date NOT NULL,
	Enrolled BIT NOT NULL DEFAULT 1, 
	Municipality NVARCHAR(20), 
	CreatedOn DateTime2 DEFAULT GETDATE(),
	CreatedBy NVARCHAR(20) DEFAULT CURRENT_USER,
	DepartmentId TINYINT	
	CONSTRAINT Stu_Dep 
	FOREIGN KEY  REFERENCES Departments(Id),
	CONSTRAINT Stu_Pry_key PRIMARY KEY(Id)
);
GO

--?
INSERT INTO [dbo].[Students]
		(Id,[Name], [PhoneNo], [Semester],[Gender],
		[BirthDate],[Municipality],[DepartmentId],Enrolled)
     VALUES
		('09223381','Zahra Fouad Aljosh',	'+218912123482',2,'F','09-01-2003','TripoliCenter',4,1),
        ('09223333','Ahmed Othman kalaf',	'+218927653482',2,'M','09-10-2003','AinZarah',2,0),
		('09223334','Samir Alhadi Qabaj',	'+218927653411',3,'M','09-25-2004','AbuSaleem',2,1),
		('09223338','Fatim Hussni Mahmood',	'+218913764882',4,'F','03-05-2003','HaiAlandalus',1,1),
		('09223363','Ali Ahmed Salem',		'+218927653482',1,'M','09-05-2003','Tajora',3,1),
		('09223373','Alfirjani Adel Muftah','+218927653482',1,'M','09-12-2003','Janzoor',3,0),
		('09225582','Sumia Adel Rajab',		'+218912123482',2,'F','12-30-2003','TripoliCenter',4,1),
		('09243282','UmKulthom Ahmed Kamel','+218923178482',2,'F','05-09-2003','AinZarah',4,1),
		('09223082','Salem Ahmed Najem',	'+218917296482',2,'M','11-01-2003','AinZarah',4,1),
		('09223312','Sabria Altaher Omar',	'+218922465442',1,'F','08-06-2002','AbuSaleem',3,1),
		('09223382','Asma Altaher Omar',	'+218922465482',2,'F','08-06-2003','AbuSaleem',4,0);
GO

--?
CREATE TABLE Instructors (
	Id INT IDENTITY(1,1) PRIMARY KEY,
	Name NVARCHAR(100),
	PhoneNo CHAR(13),	
	Gender CHAR(1) CHECK(Gender = 'M' OR Gender = 'F'), 		
	DepartmentId TINYINT	
	CONSTRAINT Inst_Dep 
	FOREIGN KEY  REFERENCES Departments(Id),	
);
GO

-- ?
INSERT INTO [dbo].[Instructors]
		([Name], [PhoneNo], [Gender],[DepartmentId])
     VALUES
		('Amal Fouad Kamel','+218916783482','F',4),
        ('Usama Othman Alhatab','+218927612382','M',2),
		('Ahmed Alhadi Qabaj','+218927653411','M',2),
		('Alzahra Hussni Omer','+218922224882','F',1),
		('Salem Ahmed Salem','+218929876482','M',3),
		('Adel Fathi Muftah','+218927644442','M',3),
		('Butaina Adel Ramadan','+218912765412','F',4)		
GO

-- ?
CREATE TABLE Semesters (
	Id int NOT NULL IDENTITY(1,1) PRIMARY KEY,
	SemesterType CHAR(6),	
	StudentId CHAR(10) CONSTRAINT Stu_Sem FOREIGN KEY REFERENCES Students(Id),		
	CourseId  CHAR(7) CONSTRAINT Cou_Sem FOREIGN KEY REFERENCES Courses(Id),
	Mark DECIMAL(5,2),
	IsSuspended BIT DEFAULT 0,
	TeachedBy INT CONSTRAINT Cou_Sem_Teach FOREIGN KEY REFERENCES Instructors(Id),
	EnrollmentOn DATE DEFAULT GETDATE()	
);
Go

-- ?
INSERT INTO [dbo].[Semesters]
           ([SemesterType], [StudentId], [CourseId],IsSuspended, [Mark],EnrollmentOn,TeachedBy)
     VALUES
-- 09223333
		('Spring','09223333','ITAR111',0,90.5,'2018-03-29',1),
		('Spring','09223333','ITEL111',0,80.5,'2018-03-29',2),
		('Spring','09223333','ITGS113',0,99,'2018-03-29',4),
		('Spring','09223333','ITGS122',0,90.5,'2018-03-29',5),
		('Fall','09223333','ITGS124',0,90.5,'2018-09-29',1),
		('Fall','09223333','ITGS213',0,70.5,'2018-09-29',2),
		('Fall','09223333','ITGS219',0,40,'2018-09-29',4),
		('Fall','09223333','ITGS223',0,20.5,'2018-09-29',5),
		('Spring','09223333','ITGS302',0,80.5,'2019-03-29',1),
		('Spring','09223333','ITNT311',0,20.5,'2019-03-29',2),
		('Spring','09223333','ITNT411',0,49,'2019-03-29',4),
-- 09223338  
		('Spring','09223338','ITAR111',0,99.5,'2018-03-29',1),
		('Spring','09223338','ITEL111',0,98.5,'2018-03-29',2),
		('Spring','09223338','ITGS113',0,99,'2018-03-29',4),
		('Spring','09223338','ITGS122',0,92.5,'2018-03-29',5),
		('Fall','09223338','ITGS124',0,90.5,'2018-09-29',1),
		('Fall','09223338','ITGS213',0,95,'2018-09-29',2),
		('Fall','09223338','ITGS219',0,30,'2018-09-29',4),
		('Fall','09223338','ITGS223',0,22.5,'2018-09-29',5),
		('Spring','09223338','ITGS302',0,80.5,'2019-03-29',1),
		('Spring','09223338','ITNT311',0,50.5,'2019-03-29',2),
		('Spring','09223338','ITNT411',0,30,'2019-03-29',4),		
-- 09223381  
		('Spring','09223381','ITAR111',0,99.5,'2018-03-29',1),
		('Spring','09223381','ITEL111',0,90,'2018-03-29',2),
		('Spring','09223381','ITGS113',0,99,'2018-03-29',4),
		('Spring','09223381','ITGS122',0,92.5,'2018-03-29',5),
		('Fall','09223381','ITGS124',0,90.5,'2018-09-29',1),
		('Fall','09223381','ITGS213',0,95,'2018-09-29',2),
		('Fall','09223381','ITGS219',0,80,'2018-09-29',4),
		('Fall','09223381','ITGS223',0,85,'2018-09-29',5),
		('Spring','09223381','ITGS302',0,80.5,'2019-03-29',1),
		('Spring','09223381','ITNT311',0,90.5,'2019-03-29',2),
		('Spring','09223381','ITNT411',0,94,'2019-03-29',4);          
GO


--------------------------------------------------------
----------------   Manipulation  -----------------------
--------------------------------------------------------

-- Add new column called IsEnabled
ALTER TABLE Departments ADD IsEnabled BIT NULL;

--change the type of the column
ALTER TABLE Departments ALTER COLUMN IsEnabled int;

-- Add new prerequist column
--ALTER TABLE CoursesADD Prerequisite NVARCHAR(7) NULL

-- Drop more than one column
--ALTER TABLE CoursesDROP COLUMN Credits, Prerequisite;

-- Add check for credit to be greater than 0
ALTER TABLE Courses WITH NOCHECK
ADD CONSTRAINT credit_check CHECK (Credits > 0);

-- Add default value
ALTER TABLE Departments ADD CONSTRAINT enabled_true DEFAULT 1 FOR IsEnabled;

-- Can't delete tables with foreign key relation 
DROP TABLE IF EXISTS Departments;

----------- Manipulating Structure ----------

ALTER TABLE table_name ADD column_name datatype;

ALTER TABLE table_name DROP COLUMN column_name;

ALTER TABLE table_name ALTER COLUMN column_name datatype;

ALTER TABLE table_name ADD CONSTRAINT constraint_name;

ALTER TABLE table_name DROP CONSTRAINT constraint_name;

DROP TABLE IF EXISTS table_name;



-- أكتب القادح الذي يقوم بتسجيل عمليات الإضافة على 
-- جدول coursesemester 
-- بحيث يخزن اسم المستخدم ووقت العمليةورقم المقرر
-- ورقم الطالب ونوع العملية في ملف Logging

USE SQLServerLabs
GO

--============ Logging Operations ============
CREATE TABLE Logging
(   Username nvarchar(50) NOT NULL,
    Operationtime DATETIME NOT NULL,
    StudentId CHAR(10) NOT NULL,
    CourseId NCHAR(7) NOT NULL,
    OperationType nvarchar(30) NOT NULL);
   
         
-- Log the enrollement operation 
CREATE TRIGGER dbo.LogEnrollment ON [dbo].[Semesters] 
AFTER INSERT AS
BEGIN  
  SET NOCOUNT ON;  
  INSERT INTO dbo.Logging
         (Username, Operationtime, StudentId, CourseId,OperationType)
  SELECT SYSTEM_USER,GETDATE(),inserted.StudentID,inserted.CourseID,N'اضافة'  
  FROM inserted      
END
GO

--DROP TRIGGER IF EXISTS dbo.LogEnrollment;  

-- Enroll student 
INSERT INTO [dbo].[Semesters]
           ([SemesterType], [StudentId], [CourseId],IsSuspended, [Mark],EnrollmentOn,TeachedBy)
     VALUES
		('Spring','09223333','ITAR111',0,90.5,'2018-03-29',1);

SELECT * FROM Logging

-- Disable and enroll another student 
DISABLE TRIGGER dbo.LogEnrollment ON [dbo].[Semesters] ;

INSERT INTO [dbo].[Semesters]
           ([SemesterType], [StudentId], [CourseId],IsSuspended, [Mark],EnrollmentOn,TeachedBy)
     VALUES
		('Spring','09223333','ITAR111',0,90.5,'2018-03-29',1);

SELECT * FROM Logging



-- DELETE FROM dbo.CourseSemester


--============== Student Credit Monitor operation ====  
-- Add new Column to store the allowed credit

-- أكتب القادح DecreaseCredit الذي يقوم بخصم ساعات المادة المنزلة  
--من رصيد الطالب على الجدول coursesemester 

ALTER TABLE dbo.Student 
  ADD Credit int  

-- Fill with data
Update dbo.Student 
  SET Credit = 15



-- Decrease the student allowed credit
CREATE TRIGGER DecreaseCredit ON dbo.CourseSemester 
AFTER INSERT AS
BEGIN  
  SET NOCOUNT ON;
  
  DECLARE @Credit int;
  
  SELECT @Credit = c.Credit 
  FROM dbo.Course c, inserted i
  WHERE c.CourseID = i.CourseID;
  
  UPDATE s
  SET Credit = Credit - @Credit
  FROM dbo.Student s, inserted as i
  ON s.StudentID = i.[StudentID];
  
END


-- Enroll Student to a course 
--(No limit to what can student enroll to)
INSERT INTO dbo.CourseSemester 
       (CourseID,StudentID,EnrollDate,Semester,MidExam,FinalExam)
VALUES ('IT102',2393,GETDATE(),1,0,0)


ALTER TRIGGER DecreaseCredit ON dbo.CourseSemester 
AFTER INSERT AS
BEGIN  
  SET NOCOUNT ON;
  
  DECLARE @Credit int;
  
  SELECT @Credit = c.Credit 
  FROM dbo.Course c, inserted i
  WHERE c.CourseID = i.CourseID;
  
  UPDATE s
  SET Credit = Credit - @Credit
  FROM dbo.Student s INNER JOIN inserted as i
  ON s.StudentID = i.[StudentID];
  
END

-- Now add new row
INSERT INTO dbo.CourseSemester 
       (CourseID,StudentID,EnrollDate,Semester,MidExam,FinalExam)
VALUES ('IT102',2393,GETDATE(),1,0,0)

--What about student limited credit?

-- Check for correct conditions
ALTER TRIGGER DecreaseCredit ON dbo.CourseSemester 
AFTER INSERT AS
BEGIN  
  SET NOCOUNT ON;
  
  DECLARE @cCredit int, @sCredit int;
  
  SELECT @cCredit = c.Credit 
  FROM dbo.Course c, inserted i
  WHERE c.CourseID = i.CourseID;
  
  SELECT @sCredit = s.Credit 
  FROM dbo.Student s, inserted i
  WHERE s.StudentID = i.StudentID;
  
  IF((@sCredit - @cCredit) > 0)  
	UPDATE s
	SET Credit = Credit - @cCredit
	FROM dbo.Student s INNER JOIN inserted as i
	ON s.StudentID = i.[StudentID];
  ELSE
    BEGIN    
      RAISERROR('Insufficient student credit ',14,2);
      ROLLBACK TRANSACTION;
    END  
END

-- Now add new row
INSERT INTO dbo.CourseSemester 
       (CourseID,StudentID,EnrollDate,Semester,MidExam,FinalExam)
VALUES ('IT202',2393,GETDATE(),1,0,0)



--CREATE TABLE Loggg
--(   Username nvarchar(50) NOT NULL)
--CREATE  TRIGGER Decrease ON dbo.Loggg 
--AFTER INSERT AS
--BEGIN  
--  SET NOCOUNT ON;
  END

----------------------------- Procedural Language ------------------------

--default assignment
declare @hello as nvarchar(200)=N'السلام عليكم';
select 'Your message is =', @hello;

-- assignment using set
declare @age as int;
set @age = 45;
select 'Your age is =',@age

-- assignment using select (non ANSI)
declare @mark as decimal(5,2);
select @mark = 50.53822345;
select 'Your mark is =', @mark;

-- display using print
declare @now as datetime2 = getdate();
print  @now;

-- problem with using print
declare @dob as datetime2 = '2000-02-11 21:28:08';
print   'your dob is = ' + @dob;
--print    @dob;


------------------------ Converting  ------------------------------
-- implicit conversion

declare @string VARCHAR(10);
set @string = 1;
select @string + ' is a string.'

declare @notastring INT;
set @notastring = '1';
select @notastring + '1'

--- raise error can not be implicitly converted 
declare @intstring INT;
set @intstring = '1';
print 'Your number is =' + @intstring 
--print 'your number is = ' + cast (20.21 as varchar(10))

-- cast can truncate and round
SELECT  CAST(10.6496 AS INT) as trunc1,
        CAST(-10.6496 AS INT) as trunc2,
        CAST(10.6496 AS NUMERIC) as round1,
        CAST(-10.6496 AS NUMERIC) as round2;

---------------  IF ELSE -----
IF DATENAME(weekday, GETDATE()) IN (N'Saturday', N'Sunday')
       SELECT 'Weekend';
ELSE 
       SELECT 'Weekday';

--- boolean exp. can be selet result ----------------
IF (SELECT COUNT(*) FROM [dbo].[Students] WHERE Enrolled = 1) > 5  
	PRINT 'There are more than 5 Students enrolled.'  
ELSE 
	PRINT 'There are 5 or less students enrolled.' ;  

------------------ case
SELECT Id,Name,
	CASE 
		WHEN Enrolled = 0 THEN N'Not Enrolled'
		WHEN Enrolled = 1 THEN N'Enrolled'
		ELSE N'Unknown' 
	END AS [Status]
FROM [dbo].[Students]


--------------------  stored proc -----------------------------
create proc What_DB_is_this
as
select DB_NAME() as ThisDB;
--exec
exec What_DB_is_this


create proc What_DB_is_that @ID int
as
select DB_NAME(@ID) as ThatDB;
-- exec
exec What_DB_is_that 2

------------------------------
----- non paramertized proc
create proc dbo.getStudentSemesters09223333  
as
select [Id],[SemesterType],[StudentId],[CourseId],
       [Mark],[IsSuspended],[TeachedBy],[EnrollmentOn]
  from [ITDatabase].[dbo].[Semesters]
  where StudentId = '09223333' 
go
-- exec
exec dbo.getStudentSemesters09223333

----- paramertized proc
create proc dbo.getStudentSemesters
	@StudentId char(10)  
as
select [Id],[SemesterType],[StudentId],[CourseId],
       [Mark],[IsSuspended],[TeachedBy],[EnrollmentOn]
  from [ITDatabase].[dbo].[Semesters]
  where StudentId = @StudentId 
go
-- exec
exec dbo.getStudentSemesters '09223338'

-------- non data proc
create proc dbo.MathTutor
	@m1 smallint,
	@m2 smallint,
	@result smallint output
as
	set @result = @m1 * @m2;
go
-- exec
declare @answer smallint;
exec MathTutor 5,6, @answer output;
select 'The result is: ', @answer;


---------------- Exception handling ------------------

CREATE PROCEDURE usp_GetErrorInfo  
AS  
SELECT  
    ERROR_NUMBER() AS ErrorNumber  
    ,ERROR_SEVERITY() AS ErrorSeverity  
    ,ERROR_STATE() AS ErrorState  
    ,ERROR_PROCEDURE() AS ErrorProcedure  
    ,ERROR_LINE() AS ErrorLine  
    ,ERROR_MESSAGE() AS ErrorMessage;  
GO  
 
---exec
BEGIN TRY      
    SELECT 1/0; -- Generate divide-by-zero error. 
END TRY  
BEGIN CATCH  
    -- Execute error retrieval routine.  
    EXECUTE usp_GetErrorInfo;  
END CATCH;
----------------------------

create table dbo.TableNoKey (ColA int, ColB int)
create table dbo.TableWithKey (ColA int primary key, ColB int)
go

create proc dbo.AddData @a int, @b int
as
  begin try
    insert dbo.TableNoKey values (@a, @b);
    insert dbo.TableWithKey values (@a, @b);
  end try
  begin catch
      select ERROR_NUMBER() ErrorNumber, ERROR_MESSAGE() [Message];
  end catch
GO

--exec
exec dbo.AddData 1, 1
exec dbo.AddData 2, 2
exec dbo.AddData 1, 3 --violates the primary key

SELECT TOP (1000) [ColA],[ColB] FROM [ITDatabase].[dbo].[TableNoKey]
SELECT TOP (1000) [ColA],[ColB] FROM [ITDatabase].[dbo].[TableWithKey]


---------------- with transaction handling ----------------------
 
alter  proc dbo.AddData @a int, @b int
as
  begin try
    begin tran
    insert dbo.TableNoKey values (@a, @b)
    insert dbo.TableWithKey values (@a, @b)
    commit tran
  end try
  begin catch
	  rollback tran
      select ERROR_NUMBER() ErrorNumber, ERROR_MESSAGE() [Message]
  end catch
go


exec dbo.AddData 1, 1  -- will not exec duplicate and within same trans





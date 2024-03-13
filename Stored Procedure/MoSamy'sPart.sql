use Examination_System
--Instructor Stuff
create proc selectInstructors 
as
select * from Instructor 
go
alter proc UpdateInstructors @Id int , @Name varchar(20),@Ins_Degree varchar(20) ,@Salary int as 
begin
	if @id=null or ISNUMERIC(@Id)=0
	begin
	select 'Invalid ID'
	return;
	end
	if @Name=null or ISNUMERIC(@Name)=1
	begin
	select 'invalid Name'
	return
	end
	declare @Original_Ins_Name varchar(20);
	declare @Original_Ins_Degree varchar(20);
	declare	@Original_Ins_Salary int
	select @Original_Ins_Name=Ins_Name , @Original_Ins_Degree=Ins_Degree,@Original_Ins_Salary=Ins_Salary from Instructor where Ins_Id=@Id
update Instructor set Ins_Id=@Id,Ins_Name=coalesce (@Name,@Original_Ins_Name),Ins_Degree=coalesce (@Ins_Degree,@Original_Ins_Degree) , Ins_Salary=coalesce(@Salary,@Original_Ins_Salary)
end
go
create proc DeleteInstructor @Id int 
as 
begin
		if @Id=null OR ISNUMERIC(@Id)=0
		begin
		select 'invalid Id'
		return;
		end
		if not exists (select 1 from Instructor where Ins_Id=@Id)
		begin
		select 'Id wasn''t found'
		return;
		end
	delete from Instructor where Ins_Id=@Id
end
go
create proc InserteInstructors @Id int , @Name varchar(20),@Ins_Degree varchar(20) ,@Salary int = 2500 as 
begin
	if @id=null or ISNUMERIC(@Id)=0
	begin
	select 'Invalid ID'
	return;
	end
	if @Name=null or ISNUMERIC(@Name)=1
	begin
	select 'invalid Name'
	return
	end
	if exists (select 1 from Instructor where Ins_Id=@Id)
	begin
	select 'Instructor Id already exists'
	return ;
	end
insert into Instructor (ins_id,ins_name,ins_degree,ins_salary)  values (@Id,@Name,@Ins_Degree,@Salary) 
end
go
-- Course Stuff
create proc SelectCourses as
begin 
select * from Course 
end
go
alter proc InsertCourse @Crs_name varchar(50),@Crs_id int , @Topic_id int as
begin
	if @Crs_name=null or ISNUMERIC(@Crs_name)=1
	begin
	select 'invalid Course Name'
	return;
	end
	if @Crs_id=null or ISNUMERIC(@Crs_id)=0
	begin
	select 'invalid course Id' 
	return;
	end
	if exists (select 1 from course where Crs_Id=@Crs_id)
	begin
	select 'Course Id already exists'
	return;
	end
	if not exists (select 1 from Topic where Topic_Id=@Topic_id )
	begin
	select 'Topic Dosn''t exist'
	return ;
	end
	insert into Course (Crs_Name,Crs_Id,Topic_Id) values (@Crs_name,@Crs_id,@Topic_id)
end
go
create proc UpdateCourse @Crs_name varchar(50),@Crs_id int , @Topic_id int as
begin
	if @Crs_name=null or ISNUMERIC(@Crs_name)=1
	begin
	select 'invalid Course Name'
	return;
	end
	if @Crs_id=null or ISNUMERIC(@Crs_id)=0
	begin
	select 'invalid course Id' 
	return;
	end
	if exists (select 1 from course where Crs_Id=@Crs_id)
	begin
	select 'Course already exists'
	return;
	end
	if not exists (select 1 from Topic where Topic_Id=@Topic_id )
	begin
	select 'Topic Dosn''t exist'
	return ;
	end
	DECLARE @Original_Crs_Name varchar(50);
    DECLARE @Original_Topic_Id int;


    SELECT @Original_Crs_Name = Crs_Name,
           @Original_Topic_Id = Topic_Id
    FROM Course
    WHERE Crs_Id = @Crs_id;
	update Course  set Crs_Name=coalesce(@Crs_name,@Original_Crs_Name),Crs_Id=@Crs_id,Topic_Id=coalesce (@Topic_id,@Original_Topic_Id) where Crs_Id=@Crs_id
end
go
create proc DeleteCourse @crs_Id int as
begin
	if @crs_Id=null or ISNUMERIC(@crs_Id)=0
	begin
	select 'invalid Course Id'
	return ;
	end
	if not exists (select 1 from Course where Crs_Id=@crs_Id)
	begin
	select 'Course wasn''t found '
	return;
	end
	delete from Course where Crs_Id=@crs_Id;
end
go
-- Course-Instructor stuff
create proc SelectInstructorCourse as select * from crs_ins
go
create proc InsertInstructorCourse  @ins_id int,@crs_id int as 
begin
	if @ins_id is null or ISNUMERIC(@ins_id)=0
	begin
		select 'Invalid Instructor ID'
		return;
	end
	if @crs_id is null or ISNUMERIC(@crs_id)=0
	begin
		select 'Invalid Course ID'
		return;
	end
	if exists (select 1 from crs_ins where Crs_Id=@crs_id and Ins_Id=@ins_id)
	begin
	select 'field already exists'
	return
	end
insert into crs_ins values (@crs_id,@ins_id)
end
go
create proc DeleteInstructorCourse  @ins_id int,@crs_id int as 
begin
	if @ins_id is null or ISNUMERIC(@ins_id)=0
	begin
		select 'Invalid Instructor ID'
		return;
	end
	if @crs_id is null or ISNUMERIC(@crs_id)=0
	begin
		select 'Invalid Course ID'
		return;
	end
	if  not exists (select 1 from crs_ins where Crs_Id=@crs_id and Ins_Id=@ins_id)
	begin
	select 'field not found'
	return
	end
delete from crs_ins where Crs_Id=@crs_id and Ins_Id=@ins_id
end
go
-- Exam-Answers stuff 
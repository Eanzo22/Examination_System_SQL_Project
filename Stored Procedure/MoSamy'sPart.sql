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
	if @id is null or ISNUMERIC(@Id)=0
	begin
	select 'Invalid ID'
	return;
	end
	if @Name is null or ISNUMERIC(@Name)=1
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
create proc SelectExam_Questions as
select * from Exam_Questions
go
-- Exam-Answers stuff 
Create proc exam_Answers @std_name varchar(50) , @exam_id int , @answer1 varchar(20),@answer2 varchar(20),@answer3 varchar(20),@answer4 varchar(20)
,@answer5 varchar(20),@answer6 varchar(20),@answer7 varchar(20),@answer8 varchar(20),@answer9 varchar(20),@answer10 varchar(20) as 
begin try 
declare @std_id int =(select Std_Id from Student where replace( Std_Name,' ','')=replace (@std_name,' ',''))
	if @std_id=null or ISNUMERIC(@std_id)=0
	begin
	select 'student dosen''t exist'
	return;
	end
	if @exam_id=null or ISNUMERIC(@exam_id)=0
	begin
	select 'Invalid exam ID'
	return;
	end

declare @std_Answers table (std_answer varchar(50)) 
insert into @std_Answers values (@answer1),(@answer2),(@answer3),(@answer4),(@answer5),(@answer6),(@answer7),(@answer8),(@answer9),(@answer10)
	
	declare @NoOfQuestions int = (select count(*) from Exam_Questions where Exam_Id=@exam_id)
	declare @counter int=0
	declare answers_cursor cursor 
	for select std_answer from @std_Answers
	
	open answers_cursor
	declare @current_answer varchar(50)
	fetch next from answers_cursor into @current_answer
	while @@FETCH_STATUS=0 and @counter<@NoOfQuestions
	begin
	insert into Exam_Que_Std (Std_Id,Ex_Id,Que_Id,std_Answer) select @std_id,eq.Exam_Id,eq.Question_Id,@current_answer 
	from Exam_Questions eq where eq.Exam_Id=@exam_id
	set @counter=@counter+1
	fetch next from answers_cursor into @current_answer
	end
	close answers_cursor
	deallocate answers_cursor
end try
begin catch
select 'Error in submitting exam answers'
end catch
go
--exam Correction
create proc Exam_Correction @Exam_Id int,@Std_Name varchar(50) as 
begin try
	declare @std_id int =(select Std_Id from Student where replace( Std_Name,' ','')=replace (@std_name,' ',''))
	if @std_id is null 
	begin
	select 'student dosen''t exist' as [status]
	return;
	end
	if @exam_id is null or ISNUMERIC(@exam_id)=0
	begin
	select 'Invalid exam ID' as [status]
	return;
	end
	declare  exam_correction cursor 
	for select eqs.std_Answer,q.Correct_Ans ,q.Que_Grade ,eqs.Que_Id from Exam_Que_Std eqs join Question q on eqs.Que_Id=q.Que_Id where Ex_Id=@Exam_Id and Std_Id=@std_id
	
	open exam_correction
	declare @student_answer varchar(100)
	declare @Correct_answer varchar(100)
	declare @Question_Grade int
	declare @Student_Final_Grade int =0
	declare @Question_Id int
	fetch next from exam_correction into @student_answer ,@Correct_Answer ,@Question_Grade,@Question_Id
	while @@FETCH_STATUS=0
	begin
		if @student_answer=@Correct_Answer
		begin
		update Exam_Que_Std set std_Grade=@Question_Grade where Que_Id=@Question_Id and Std_Id=@std_id and Ex_Id=@Exam_Id
		set @Student_Final_Grade=@Student_Final_Grade+@Question_Grade;
		end
		else
		begin
		update Exam_Que_Std set std_Grade=0 where Que_Id=@Question_Id and Std_Id=@std_id and Ex_Id=@Exam_Id
		end

	fetch next from exam_correction into @student_answer ,@Correct_Answer ,@Question_Grade,@Question_Id
	end
close exam_correction
deallocate exam_correction
	declare @max_Grades  decimal (5,2)=(select SUM(q.Que_Grade) from Question q join Exam_Questions eq on q.Que_Id=eq.Question_Id where eq.Exam_Id=@Exam_Id)
	declare @percentage decimal(5,2)=(@Student_Final_Grade/@max_Grades)*100
	select 'Exam corrected successfully ' as [Status]
	select @percentage as Total_Grade_Percentage
end try
begin catch
if @@TRANCOUNT>0
	rollback transaction;
select 'Error in exam Correction' as [status]
end catch


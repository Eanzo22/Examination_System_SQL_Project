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


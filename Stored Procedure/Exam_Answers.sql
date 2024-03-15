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

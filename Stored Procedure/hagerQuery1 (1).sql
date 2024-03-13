-------------------------------hager & shymaa----------------------------------
alter proc Exam_generation @courseID int ,@NoOfMCQ int ,@NoOfTF int,@Duration int,@ExamID int
as
insert into Exam (ex_Id ,Ex_Duration)
values (@ExamID,@Duration)

--MCQ
declare @i int=0
CREATE TABLE #SelectedQuestions (QuestionId INT)      --temporary table
  while @i<@NoOfMCQ
	  begin
	  set @i = @i + 1
	   declare @QID int
	   select top 1 @QID =  Que_Id
		from Question
		where Crs_Id=@courseID and Que_Type='MCQ'AND Que_Id NOT IN (SELECT QuestionId FROM #SelectedQuestions)
		ORDER BY NEWID();

		--insert into Exam_Que_Std (Que_Id,Ex_Id)
		--values (@QID,@ExamID)

		 select Que_Title,string_agg(Que_Choices ,' | ' )
		 from Question as Q inner join Question_Choices as QC on  Q.Que_Id=QC.Que_Id 
		 where Q.Que_Id=@QID
		 group by Que_Title
		 INSERT INTO #SelectedQuestions (QuestionId) VALUES (@QID)

	 end
	 --TF
	 ------------------
	   declare @j int=0
	   while @j<@NoOfTF
	  begin
	  set @j = @j + 1
	   declare @QueID int
	   select top 1 @QueID =  Que_Id
		from Question
		where Crs_Id=@courseID and Que_Type='TF'AND Que_Id NOT IN (SELECT QuestionId FROM #SelectedQuestions)
		ORDER BY NEWID();

		--insert into Exam_Que_Std (Que_Id,Ex_Id)
		--values (@QID,@ExamID)

		 select Que_Title,string_agg(Que_Choices ,' | ' )
		 from Question as Q inner join Question_Choices as QC on  Q.Que_Id=QC.Que_Id 
		 where Q.Que_Id=@QueID
		 group by Que_Title
		 INSERT INTO #SelectedQuestions (QuestionId) VALUES (@QueID)
	 end
	  DROP TABLE #SelectedQuestions



--calling 
Exam_generation 1,3,4,30,1


---------------------------------------------------------------------------------------------
--topic
--select
create proc selectTopic 
as 
  select*from Topic


  --calling
  selectTopic 


-------------------------------
--insert
create proc insertTopic @topicID int, @topicName varchar(30)
as
  insert into Topic (Topic_Id,Topic_name)
  values(@topicID,@topicName)


  --calling
  insertTopic 2,entityFrameWork
 


 -----------------------------
 --update
 create proc updateTopic @topicID int,@topicName varchar(30)
 as 
   update Topic
   set Topic_name=@topicName
   where Topic_Id=@topicID

--calling
updateTopic 1,delegate

--------------------------------------
--delete
create proc deleteTopic @topicID int
as
 delete from Topic 
 where Topic_Id=@topicID

 --calling
 deleteTopic 2






-----------------------------------------------------------
--question
--select
create proc selectquestion 
as 
  select*from Question


  --calling
  selectquestion 

 ----------------------------

 --insert
create proc insertQuestion @QID int, @CorrectAns varchar(100),@Qgrade int,@QType varchar(50),
@courseID int,@QTitle varchar(200)
as
  insert into Question (Correct_Ans, Que_Grade,Que_Type,Que_Id,Crs_Id,Que_Title)
  values(@CorrectAns,@Qgrade,@QType,@QID,@courseID,@QTitle)

-----------------------------
 --update
 create proc updateQuestion @QID int, @CorrectAns varchar(100),@Qgrade int,@QType varchar(50),
@courseID int,@QTitle varchar(200)
 as 
   update Question
   set Correct_Ans=@CorrectAns,Que_Grade=@Qgrade,Que_Type=@QType,Crs_Id=@courseID,@QTitle=@QTitle
   where Que_Id=@QID


--------------------------------------
--delete
create proc deleteQuestion @QID int
as
 delete from Question 
 where Que_Id=@QID

  



--------------------------------------------------------------
--question_choices
--select
create proc selectquestionChoices 
as 
  select*from Question_Choices


  --calling
  selectquestionChoices

----------------------------

 --insert
create proc insertQuestionChoices @QID int, @QChoice varchar(200)
as
  insert into Question_Choices (Que_Choices,Que_Id)
  values(@QChoice,@QID)

-----------------------------
 --update
 create proc updateQuestionChoices @QID int, @QChoice varchar(200)
 as 
   update Question_Choices
   set Que_Choices=@QChoice
   where Que_Id=@QID

--------------------------------------
--delete
create proc deleteQuestionChoices @QID int
as
 delete from Question_Choices 
 where Que_Id=@QID
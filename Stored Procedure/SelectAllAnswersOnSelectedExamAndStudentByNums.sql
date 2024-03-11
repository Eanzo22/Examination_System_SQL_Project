create procedure SelectAllAnswersOnSelectedExamAndStudentByNums @std_id int, @ex_id int
with encryption
as
BEGIN try
select exs.Que_Id, exs.std_Answer from Exam_Que_Std exs
inner join Exam ex
on 
exs.Ex_Id=ex.Ex_Id
inner join
Student std
on
exs.Std_Id = std.Std_Id
where std.Std_Id = @std_id and ex.Ex_Id=@ex_id
END TRY
BEGIN CATCH
SELECT('Error In Selected .... ')
END CATCH



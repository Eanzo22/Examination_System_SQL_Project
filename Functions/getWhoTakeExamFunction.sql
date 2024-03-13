USE [Examination_System]
create function [dbo].[GetWhoTakeExam]
(
	@ExamId int
)
returns table
as
return (
select exam.Ex_Id as [Exam Id], Student.* 
from Exam
inner join Exam_Que_Std exd
on exam.Ex_Id = exd.Ex_Id
inner join Student 
on
student.Std_Id = exd.Std_Id
where Exam.Ex_Id=@ExamId
)

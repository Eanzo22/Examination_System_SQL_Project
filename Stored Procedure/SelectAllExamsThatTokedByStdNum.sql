create procedure SelectAllExamsThatTokedByStdNum @std_id int
with encryption
as
BEGIN try
select * from Exam ex
inner join Exam_Que_Std exs
on exs.Ex_Id = ex.Ex_Id
inner join Student st
on
exs.Std_Id = st.Std_Id
where st.Std_Id = @std_id
END TRY
BEGIN CATCH
SELECT('Error In Selected .... ')
END CATCH



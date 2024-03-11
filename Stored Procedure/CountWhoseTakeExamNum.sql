create procedure CountWhoseTakeExamNum @ex_id int
with encryption
as
BEGIN try
select COUNT(*) from Student st
inner join Exam_Que_Std exs
on exs.Std_Id=st.Std_Id
inner join Exam ex
on exs.Ex_Id = ex.Ex_Id
where ex.Ex_Id = @ex_id
END TRY
BEGIN CATCH
SELECT('Error In Selected .... ')
END CATCH



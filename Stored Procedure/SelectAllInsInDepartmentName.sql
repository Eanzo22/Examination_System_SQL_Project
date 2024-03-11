create procedure SelectAllInsInDepartmentName @dpt_name varchar(50)
with encryption
as
BEGIN try
select *
from Instructor
inner join Works_on as w
on 
Instructor.Ins_Id = w.Ins_Id
inner join Department d
on
d.Dept_id=w.Dept_id
where d.Dept_Name = @dpt_name
END TRY
BEGIN CATCH
SELECT('Error In Selected .... ')
END CATCH




alter procedure CountInstrauctorInDeptNum @dpt_id int
with encryption
as
BEGIN try
select COUNT(*) as NumberOfIns
from Instructor
inner join Works_on as w
on 
Instructor.Ins_Id = w.Ins_Id
inner join Department d
on
d.Dept_id=w.Dept_id
where d.Dept_id = @dpt_id
END TRY
BEGIN CATCH
SELECT('Error In Selected .... ')
END CATCH




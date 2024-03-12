
------------------------------------Reem (Student - Department - std-cts)----------------------------------
----------------------------------------------1- Student---------------------------------------------------
/*select*/
create proc Select_std
as
select * 
from Student
/*insert*/
create proc Insert_stud @id int, @name varchar(20), @address varchar(50), @age int, @depId int
as 
insert into Student (Std_Id,Std_Name,Std_Address,Std_Age,Dept_id)
values (@id,@name,@address,@age,@depId);

/*update*/
create proc Update_std @id int , @newName varchar (20) , @newAddress varchar(20) , @newAge int , @newDepid int
as
update Student
set
Std_Id = @id,
Std_Name = @newName,
Std_Address = @newAddress,
Std_Age = @newAge,
Dept_id = @newDepid
where Std_Id = @id

/*delete*/
create proc Delete_std @id int
as
delete from Student
where Std_Id = @id
----------------------------------------------2- Department---------------------------------------------------
/*select*/
create proc Select_Dep
as
select *
from Department
/*insert*/
create proc Insert_Dep @DeptId int, @ManagerDate DATE, @DeptDesc varchar(50), @DeptName varchar (20), @MangarId int
as
insert into Department (Dept_id ,Manager_HireDate,Dept_Desc,Dept_Name ,Manager_Id)
values (@DeptId ,@ManagerDate, @DeptDesc , @DeptName , @MangarId);
/*update*/
create proc Update_Dep @DeptId int, @newManagerDate DATE, @newDeptDesc varchar(50), @newDeptName varchar (20), @newMangarId int
as
update Department
set
Dept_id = @DeptId,
Manager_HireDate = @newManagerDate,
Dept_Desc = @newDeptDesc,
Dept_Name = @newDeptName,
Manager_Id = @newMangarId
where Dept_id = @DeptId

/*delete*/
create proc Delete_Department @DepId int
as
begin
    BEGIN TRANSACTION

	delete from Works_on where Works_on.Dept_id = @DepId
	delete from Student where Student.Dept_id = @DepId
	delete from Department where Department.Dept_id = @DepId

	COMMIT TRANSACTION

end
----------------------------------------------2- Crs-Std ---------------------------------------------------

/*select*/
create proc SelectCrs_Std
as
select*
from crs_std

/*insert*/
create proc InsertCrs_Std @stId int ,@crsId int
as
insert into crs_std (Std_Id,Crs_Id)
values(@stId,@crsId);

/*delete*/
create proc DeleteCrs_Std @stId int, @crsId int
as
delete from crs_std where Std_Id = @stId and Crs_Id = @crsId
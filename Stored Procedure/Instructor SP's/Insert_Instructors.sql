create proc InserteInstructors @Id int , @Name varchar(20),@Ins_Degree varchar(20) ,@Salary int = 2500 as 
begin
	if @id is null or ISNUMERIC(@Id)=0
	begin
	select 'Invalid ID'
	return;
	end
	if @Name is null or ISNUMERIC(@Name)=1
	begin
	select 'invalid Name'
	return
	end
	if exists (select 1 from Instructor where Ins_Id=@Id)
	begin
	select 'Instructor Id already exists'
	return ;
	end
insert into Instructor (ins_id,ins_name,ins_degree,ins_salary)  values (@Id,@Name,@Ins_Degree,@Salary) 
end
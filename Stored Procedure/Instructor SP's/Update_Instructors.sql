alter proc UpdateInstructors @Id int , @Name varchar(20),@Ins_Degree varchar(20) ,@Salary int as 
begin
	if @id=null or ISNUMERIC(@Id)=0
	begin
	select 'Invalid ID'
	return;
	end
	if @Name=null or ISNUMERIC(@Name)=1
	begin
	select 'invalid Name'
	return
	end
	declare @Original_Ins_Name varchar(20);
	declare @Original_Ins_Degree varchar(20);
	declare	@Original_Ins_Salary int
	select @Original_Ins_Name=Ins_Name , @Original_Ins_Degree=Ins_Degree,@Original_Ins_Salary=Ins_Salary from Instructor where Ins_Id=@Id
update Instructor set Ins_Id=@Id,Ins_Name=coalesce (@Name,@Original_Ins_Name),Ins_Degree=coalesce (@Ins_Degree,@Original_Ins_Degree) , Ins_Salary=coalesce(@Salary,@Original_Ins_Salary)
end
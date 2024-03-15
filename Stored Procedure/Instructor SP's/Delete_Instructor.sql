create proc DeleteInstructor @Id int 
as 
begin
		if @Id=null OR ISNUMERIC(@Id)=0
		begin
		select 'invalid Id'
		return;
		end
		if not exists (select 1 from Instructor where Ins_Id=@Id)
		begin
		select 'Id wasn''t found'
		return;
		end
	delete from Instructor where Ins_Id=@Id
end
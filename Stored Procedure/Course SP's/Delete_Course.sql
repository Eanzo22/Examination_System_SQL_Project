create proc DeleteCourse @crs_Id int as
begin
	if @crs_Id is null or ISNUMERIC(@crs_Id)=0
	begin
	select 'invalid Course Id'
	return ;
	end
	if not exists (select 1 from Course where Crs_Id=@crs_Id)
	begin
	select 'Course wasn''t found '
	return;
	end
	delete from Course where Crs_Id=@crs_Id;
end

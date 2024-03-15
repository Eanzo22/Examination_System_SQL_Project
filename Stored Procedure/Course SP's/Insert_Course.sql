create proc InsertCourse @Crs_name varchar(50),@Crs_id int , @Topic_id int as
begin
	if @Crs_name=null or ISNUMERIC(@Crs_name)=1
	begin
	select 'invalid Course Name'
	return;
	end
	if @Crs_id=null or ISNUMERIC(@Crs_id)=0
	begin
	select 'invalid course Id' 
	return;
	end
	if exists (select 1 from course where Crs_Id=@Crs_id)
	begin
	select 'Course Id already exists'
	return;
	end
	if not exists (select 1 from Topic where Topic_Id=@Topic_id )
	begin
	select 'Topic Dosn''t exist'
	return ;
	end
	insert into Course (Crs_Name,Crs_Id,Topic_Id) values (@Crs_name,@Crs_id,@Topic_id)
end
create proc UpdateCourse @Crs_name varchar(50),@Crs_id int , @Topic_id int as
begin
	if @Crs_name is null or ISNUMERIC(@Crs_name)=1
	begin
	select 'invalid Course Name'
	return;
	end
	if @Crs_id is null or ISNUMERIC(@Crs_id)=0
	begin
	select 'invalid course Id' 
	return;
	end
	if exists (select 1 from course where Crs_Id=@Crs_id)
	begin
	select 'Course already exists'
	return;
	end
	if not exists (select 1 from Topic where Topic_Id=@Topic_id )
	begin
	select 'Topic Dosn''t exist'
	return ;
	end
	DECLARE @Original_Crs_Name varchar(50);
    DECLARE @Original_Topic_Id int;


    SELECT @Original_Crs_Name = Crs_Name,
           @Original_Topic_Id = Topic_Id
    FROM Course
    WHERE Crs_Id = @Crs_id;
	update Course  set Crs_Name=coalesce(@Crs_name,@Original_Crs_Name),Crs_Id=@Crs_id,Topic_Id=coalesce (@Topic_id,@Original_Topic_Id) where Crs_Id=@Crs_id
end
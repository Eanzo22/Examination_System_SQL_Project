create proc InsertInstructorCourse  @ins_id int,@crs_id int as 
begin
	if @ins_id is null or ISNUMERIC(@ins_id)=0
	begin
		select 'Invalid Instructor ID'
		return;
	end
	if @crs_id is null or ISNUMERIC(@crs_id)=0
	begin
		select 'Invalid Course ID'
		return;
	end
	if exists (select 1 from crs_ins where Crs_Id=@crs_id and Ins_Id=@ins_id)
	begin
	select 'field already exists'
	return
	end
insert into crs_ins values (@crs_id,@ins_id)
end
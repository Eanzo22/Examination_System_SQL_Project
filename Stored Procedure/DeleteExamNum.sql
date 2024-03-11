CREATE PROCEDURE DeleteExamNum  @ex_id int
with encryption
AS
	BEGIN try
		DELETE from Exam
		where exam.ex_id = @ex_id
		SELECT CONCAT('All Quesion number for ',@ex_id,' Was Deleted Successfully')
	END TRY
	BEGIN CATCH
    	SELECT('Error Deleteing .... ')
    END CATCH



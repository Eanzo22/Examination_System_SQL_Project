CREATE PROCEDURE DeleteTkenExamNum  @ex_id int
with encryption
AS
	BEGIN try
		DELETE ES
		FROM Exam_Que_Std AS ES
		INNER JOIN Exam AS E ON ES.Ex_id = E.Ex_id
		WHERE E.Ex_id = @ex_id ;
		SELECT CONCAT('All TokenExam number for ',@ex_id,' Was Deleted Successfully')
	END TRY
	BEGIN CATCH
    	SELECT('error deleteing .... ')
    END CATCH



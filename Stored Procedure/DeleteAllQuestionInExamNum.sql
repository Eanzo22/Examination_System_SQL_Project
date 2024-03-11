CREATE PROCEDURE DeleteAllQuestionInExamNum  @ex_id int
with encryption
AS
	BEGIN try
		DELETE que
		FROM Quesion AS que
		INNER JOIN Exam AS E ON que.Ex_id = E.Ex_id
		WHERE E.Ex_id = @ex_id ;
		SELECT CONCAT('All Quesion number for ',@ex_id,' Was Deleted Successfully')
	END TRY
	BEGIN CATCH
    	SELECT('Error Deleteing .... ')
    END CATCH




﻿/*
Stored Procedure SelectParentResponseOptionsByQuestionId		
--------------------------------------------------------------------------------------
Script By                     : Newton Mitro
Created At                    : 25 January 2022
Script Altered By             : NEWTON MITRO
Altered At                    : 25 January 2022
Script Description            : This procedure will get Select Parent Response Options By Question Id.
--------------------------------------------------------------------------------------
*/
CREATE PROCEDURE dbo.SelectParentResponsibilityOptions (
    @KhanaId BIGINT
    , @ParentResponsibilityQuestionId BIGINT
    , @ReturnResult VARCHAR(255) = NULL OUTPUT
    , @AccessedBy BIGINT = NULL -- Id of user who is accessing this stored procedure. 
    )
AS
BEGIN
    BEGIN TRANSACTION;

    SAVE TRANSACTION MySavePoint;-- Create a save point

    BEGIN TRY
        --Start Main Block
        DECLARE @RowCount AS INT;

        SET @RowCount = 0;

        SELECT *
        FROM ParentResponsibilityOptions
        WHERE ParentResponsibilityQuestionId = @ParentResponsibilityQuestionId  ORDER BY OptionText ASC;

        SET @RowCount = @RowCount + @@ROWCOUNT

        SELECT ParentsResponsibilityToChilds.*
        , Members.MemberName AS AnswerGivenByName
        FROM ParentsResponsibilityToChilds
        LEFT JOIN dbo.Members
        ON ParentsResponsibilityToChilds.AnswerGivenById = Members.MemberId
        WHERE ParentsResponsibilityToChilds.KhanaId = @KhanaId
            AND ParentResponsibilityQuestionId = @ParentResponsibilityQuestionId  ORDER BY ParentsResponsibilityToChildId DESC;

        SET @RowCount = @RowCount + @@ROWCOUNT

        --End Main Block
        IF @RowCount > 0
            SET @ReturnResult = 'Success'
        ELSE
            SET @ReturnResult = 'Records not found.'

        COMMIT TRANSACTION
    END TRY

    BEGIN CATCH
        SET @ReturnResult = 'Transaction roll back.'

        ROLLBACK TRANSACTION MySavePoint;-- Rollback to MySavePoint
    END CATCH
END;

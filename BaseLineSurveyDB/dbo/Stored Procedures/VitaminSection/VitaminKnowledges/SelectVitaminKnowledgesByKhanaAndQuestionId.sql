﻿/*
Stored Procedure SelectVitaminKnowledgesByKhanaAndQuestionId		
--------------------------------------------------------------------------------------
Script By                     : Newton Mitro
Created At                    : 31 January 2022
Script Altered By             : Newton Mitro
Altered At                    : 31 January 2022
Script Description            : This procedure will Select Vitamin Knowledges By Khana And QuestionId
--------------------------------------------------------------------------------------
*/
CREATE PROCEDURE dbo.SelectVitaminKnowledgesByKhanaAndQuestionId (
    @KhanaId BIGINT
    , @QuestionId BIGINT
    , @ReturnResult VARCHAR(255) = NULL OUTPUT -- Return success or failed reason.
    )
AS
BEGIN
    BEGIN TRANSACTION;

    SAVE TRANSACTION MySavePoint;-- Create a save point

    BEGIN TRY
        --Start Main Block
        SELECT *
        FROM VitaminKnowledges
        WHERE KhanaId = @KhanaId
            AND QuestionId = @QuestionId;

        --End Main Block
        IF @@ROWCOUNT > 0
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

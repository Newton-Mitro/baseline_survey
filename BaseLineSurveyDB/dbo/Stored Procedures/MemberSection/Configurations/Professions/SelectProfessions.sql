﻿/*
Stored Procedure SelectProfessions		
--------------------------------------------------------------------------------------
Script By                     : Newton Mitro
Created At                    : 25 January 2022
Script Altered By             : NEWTON MITRO
Altered At                    : 25 January 2022
Script Description            : This procedure will Select Professions
--------------------------------------------------------------------------------------
*/
CREATE PROCEDURE dbo.SelectProfessions (@ReturnResult VARCHAR(255) = NULL OUTPUT)
AS
BEGIN
    BEGIN TRANSACTION;

    SAVE TRANSACTION MySavePoint;-- Create a save point

    BEGIN TRY
        --Start Main Block
        SELECT *
        FROM Professions ORDER BY ProfessionName ASC;

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

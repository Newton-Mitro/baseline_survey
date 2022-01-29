﻿/*
Stored Procedure SelectParisesByUpazilaId		
--------------------------------------------------------------------------------------
Script By                     : REZA E RABBI
Created At                    : 24 January 2022
Script Altered By             : NEWTON MITRO
Altered At                    : 24 January 2022
Script Description            : This procedure will get Parises By Upazila Id.
--------------------------------------------------------------------------------------
*/
CREATE PROCEDURE dbo.SelectParishesByUpazilaId (
    @UpazilaID BIGINT
    , @ReturnResult VARCHAR(255) = NULL OUTPUT
    , @AccessedBy BIGINT = NULL -- Id of user who is accessing this stored procedure. 
    )
AS
BEGIN
    BEGIN TRANSACTION;

    SAVE TRANSACTION MySavePoint;-- Create a save point

    BEGIN TRY
        --Start Main Block
        SELECT *
        FROM Parishes
        WHERE UpazilaId = @UpazilaID

        --End Main Block
        IF @@ROWCOUNT > 0
            SET @ReturnResult = 'Success'
        ELSE
            SET @ReturnResult = 'Records not found.'

        COMMIT TRANSACTION
    END TRY

    BEGIN CATCH
        IF @@TRANCOUNT > 0
        BEGIN
            SET @ReturnResult = 'Failed'

            ROLLBACK TRANSACTION MySavePoint;-- Rollback to MySavePoint
        END
    END CATCH
END;

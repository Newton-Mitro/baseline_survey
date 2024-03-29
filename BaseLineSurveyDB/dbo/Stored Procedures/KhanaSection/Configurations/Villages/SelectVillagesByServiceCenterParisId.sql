﻿/*
Stored Procedure SelectVillagesByServiceCenterParisId		
--------------------------------------------------------------------------------------
Script By                     : Newton Mitro
Created At                    : 25 January 2022
Script Altered By             : NEWTON MITRO
Altered At                    : 25 January 2022
Script Description            : This procedure will Select Villages By ServiceCenterParisId
--------------------------------------------------------------------------------------
*/
CREATE PROCEDURE dbo.SelectVillagesByParishesServicentersId (
    @ParishesServiceCentersId BIGINT
    , @ReturnResult VARCHAR(255) = NULL OUTPUT
    , @AccessedBy BIGINT = NULL -- Id of user who is accessing this stored procedure. 
    )
AS
BEGIN
    BEGIN TRANSACTION;

    SAVE TRANSACTION MySavePoint;-- Create a save point

    BEGIN TRY
        --Start Main Block
        SELECT ParishServiceCenterVillages.ParishesServiceCentersId
            , Villages.*
        FROM ParishServiceCenterVillages
        LEFT JOIN Villages
            ON ParishServiceCenterVillages.VillageId = Villages.VillageId
        WHERE ParishServiceCenterVillages.ParishesServiceCentersId = @ParishesServiceCentersId;

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

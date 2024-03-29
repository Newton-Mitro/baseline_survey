﻿/*
Stored Procedure SelectServiceCentersByParisId		
--------------------------------------------------------------------------------------
Script By                     : Newton Mitro
Created At                    : 25 January 2022
Script Altered By             : NEWTON MITRO
Altered At                    : 25 January 2022
Script Description            : This procedure will Select Service Centers By Paris Id
--------------------------------------------------------------------------------------
*/
CREATE PROCEDURE dbo.SelectServiceCentersByParisId (
    @ParishId BIGINT
    , @ReturnResult VARCHAR(255) = NULL OUTPUT
    , @AccessedBy BIGINT = NULL -- Id of user who is accessing this stored procedure. 
    )
AS
BEGIN
    BEGIN TRANSACTION;

    SAVE TRANSACTION MySavePoint;-- Create a save point

    BEGIN TRY
        --Start Main Block
        SELECT [ParishesServiceCenters].[ParishesServiceCentersId]
            , ServiceCenters.*
        FROM [ParishesServiceCenters]
        LEFT JOIN ServiceCenters
            ON [ParishesServiceCenters].ServiceCenterId = ServiceCenters.ServiceCenterId
        WHERE [ParishesServiceCenters].ParishId = @ParishId ORDER BY ServiceCenterName ASC;

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

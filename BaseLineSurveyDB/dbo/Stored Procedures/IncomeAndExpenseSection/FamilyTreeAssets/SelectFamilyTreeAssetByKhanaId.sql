﻿/*
Stored Procedure SelectFamilyTreeAssetByKhanaId	
--------------------------------------------------------------------------------------
Script By                     : Newton Mitro
Created At                    : 02 February 2022
Script Altered By             : Newton Mitro
Altered At                    : 02 February 2022
Script Description            : This procedure will Select Family Tree Asset By Khana Id
--------------------------------------------------------------------------------------
*/
CREATE PROCEDURE dbo.SelectFamilyTreeAssetByKhanaId (
    @KhanaId BIGINT
    , @ReturnResult VARCHAR(255) = NULL OUTPUT
    )
AS
BEGIN
    BEGIN TRANSACTION;

    SAVE TRANSACTION MySavePoint;-- Create a save point

    BEGIN TRY
        --Start Main Block
        SELECT FamilyTreeAssets.*
            , Trees.TreeName
            , InformationStatuses.InformationStatusName
        FROM dbo.FamilyTreeAssets
        LEFT JOIN Trees
            ON FamilyTreeAssets.TreeId = Trees.TreeId
        LEFT JOIN dbo.InformationStatuses
            ON FamilyTreeAssets.InformationStatusCode = InformationStatuses.InformationStatusCode
        WHERE KhanaId = @KhanaId ORDER BY FamilyTreeAssetId DESC;

        --End Main Block
        IF @@ROWCOUNT > 0
            SET @ReturnResult = 'Success'
        ELSE
            SET @ReturnResult = 'Recors not found.'

        COMMIT TRANSACTION
    END TRY

    BEGIN CATCH
        SET @ReturnResult = 'Transaction roll back.'

        ROLLBACK TRANSACTION MySavePoint;-- Rollback to MySavePoint
    END CATCH
END;

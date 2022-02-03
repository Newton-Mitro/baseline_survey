﻿/*
Stored Procedure InsertFamilyIncome	
--------------------------------------------------------------------------------------
Script By                     : Newton Mitro
Created At                    : 02 February 2022
Script Altered By             : Newton Mitro
Altered At                    : 02 February 2022
Script Description            : This procedure will Insert Family Income
--------------------------------------------------------------------------------------
*/
CREATE PROCEDURE dbo.InsertFamilyIncome (
    @KhanaId BIGINT
    , @IncomeSourceId BIGINT
    , @AnnualIncomeAmount MONEY
    , @InformationStatusCode BIGINT = 1
    , @ReturnResult VARCHAR(255) = NULL OUTPUT
    , @ScopeId BIGINT = NULL OUTPUT
    , @AccessedBy BIGINT = NULL -- Id of user who is accessing this stored procedure. 
    )
AS
BEGIN
    BEGIN TRANSACTION;

    SAVE TRANSACTION MySavePoint;-- Create a save point

    BEGIN TRY
        --Start Main Block
        INSERT INTO dbo.FamilyIncomes(
            KhanaId
            , IncomeSourceId
            , InformationStatusCode
            , AnnualIncomeAmount
            , CreatedAt
            , CreatedBy
            , UpdatedAt
            , UpdatedBy
            )
        VALUES (
            @KhanaId
            , @IncomeSourceId
            , @InformationStatusCode
            , @AnnualIncomeAmount
            , GETDATE()
            , @AccessedBy
            , GETDATE()
            , @AccessedBy
            )

        SET @ScopeId = SCOPE_IDENTITY();

        --End Main Block
        IF @@ROWCOUNT > 0
            SET @ReturnResult = 'Success'
        ELSE
            SET @ReturnResult = 'Unable to insert.'

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
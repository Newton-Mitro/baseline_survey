﻿/*
Stored Procedure InsertFamilyMemberDefaulterReason	
--------------------------------------------------------------------------------------
Script By                     : Newton Mitro
Created At                    : 26 February 2022
Script Altered By             : Newton Mitro
Altered At                    : 26 February 2022
Script Description            : This procedure will Insert Family Member Defaulter Reason
--------------------------------------------------------------------------------------
*/
CREATE PROCEDURE dbo.InsertFamilyMemberDefaulterReason (
    @TT_FamilyMemberDefaulderReasons TT_FamilyMemberDefaulderReasons READONLY
    , @ReturnResult VARCHAR(255) = NULL OUTPUT
    )
AS
BEGIN
    BEGIN TRANSACTION;

    SAVE TRANSACTION MySavePoint;-- Create a save point
    BEGIN TRY
        --Start Main Block
        DECLARE @FamilyMemberDefaulderReasonId BIGINT
            , @KhanaId BIGINT
            , @DefaulderReasonId BIGINT
            , @CreatedBy BIGINT
            , @UpdatedBy BIGINT
            , @CreatedAt DATETIME2
            , @UpdatedAt DATETIME2
            , @RowCount INT;

        SET @RowCount = 0;

        DECLARE CURSOR_PRODUCT CURSOR
        FOR
        SELECT FamilyMemberDefaulderReasonId
            , KhanaId
            , DefaulderReasonId
            , CreatedBy
            , UpdatedBy
            , CreatedAt
            , UpdatedAt
        FROM @TT_FamilyMemberDefaulderReasons;

        OPEN CURSOR_PRODUCT;

        FETCH NEXT
        FROM CURSOR_PRODUCT
        INTO @FamilyMemberDefaulderReasonId
            , @KhanaId
            , @DefaulderReasonId
            , @CreatedBy
            , @UpdatedBy
            , @CreatedAt
            , @UpdatedAt;

        DELETE
        FROM dbo.FamilyMemberDefaulderReasons
        WHERE KhanaId = @KhanaId;

        WHILE @@FETCH_STATUS = 0
        BEGIN
            INSERT INTO dbo.FamilyMemberDefaulderReasons(
                KhanaId
                , DefaulderReasonId
                , CreatedBy
                , UpdatedBy
                , CreatedAt
                , UpdatedAt
                )
            VALUES (
                @KhanaId
                , @DefaulderReasonId
                , @CreatedBy
                , @UpdatedBy
                , GETDATE()
                , GETDATE()
                )

            SET @RowCount = @RowCount + 1;

            FETCH NEXT
            FROM CURSOR_PRODUCT
            INTO @FamilyMemberDefaulderReasonId
            , @KhanaId
            , @DefaulderReasonId
            , @CreatedBy
            , @UpdatedBy
            , @CreatedAt
            , @UpdatedAt;
        END;

        CLOSE CURSOR_PRODUCT;

        DEALLOCATE CURSOR_PRODUCT;

        IF @RowCount > 0
            SET @ReturnResult = 'Success'
        ELSE
            SET @ReturnResult = 'Faield to insert or delete.'

        --End Main Block
        COMMIT TRANSACTION
    END TRY

    BEGIN CATCH
        SET @ReturnResult = 'Transaction roll back.'

        ROLLBACK TRANSACTION MySavePoint;-- Rollback to MySavePoint
    END CATCH
END;

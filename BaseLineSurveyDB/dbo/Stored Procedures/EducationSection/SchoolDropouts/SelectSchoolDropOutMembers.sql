﻿/*
Stored Procedure SelectSchoolDropOutMembers		
--------------------------------------------------------------------------------------
Script By                     : Newton Mitro
Created At                    : 08 February 2022
Script Altered By             : Newton Mitro
Altered At                    : 08 February 2022
Script Description            : This procedure will Select School Drop Out Members
--------------------------------------------------------------------------------------
*/
CREATE PROCEDURE dbo.SelectSchoolDropOutMembers (
    @KhanaId BIGINT
    , @ReturnResult VARCHAR(255) = NULL OUTPUT
    )
AS
BEGIN
    BEGIN TRANSACTION;

    SAVE TRANSACTION MySavePoint;-- Create a save point

    BEGIN TRY
        --Start Main Block
        SELECT *
        FROM dbo.View_Members
        WHERE KhanaId = @KhanaId
            AND dbo.GetAgeFromDateOfBirth(DateOfBirth) >= 6
            AND dbo.GetAgeFromDateOfBirth(DateOfBirth) <= 18
            AND EducationalStatusCode > 5
            AND CurrentlyStudying = 0  ORDER BY MemberName ASC;

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

﻿/*
Stored Procedure SelectMemberSleepingPlacesByKhanaId	
--------------------------------------------------------------------------------------
Script By                     : Newton Mitro
Created At                    : 15 February 2022
Script Altered By             : Newton Mitro
Altered At                    : 15 February 2022
Script Description            : This procedure will Select Member Sleeping Places By KhanaId
--------------------------------------------------------------------------------------
*/
CREATE PROCEDURE dbo.SelectMembersWhoHasRiskProfessionByKhanaId (
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
        INNER JOIN dbo.Professions AS FirstProfessions
            ON FirstProfessions.ProfessionCode = View_Members.FirstProfessionCode
        INNER JOIN dbo.Professions AS SecondProfessions
            ON SecondProfessions.ProfessionCode = View_Members.SecondProfessionCode
        WHERE View_Members.KhanaId = @KhanaId
            AND dbo.GetAgeFromDateOfBirth(View_Members.DateOfBirth) >= 6
            AND dbo.GetAgeFromDateOfBirth(View_Members.DateOfBirth) <= 18 
            AND (FirstProfessions.IsRiskedProfession = 1
            OR SecondProfessions.IsRiskedProfession = 1) ORDER BY MemberName ASC;

        IF @@ROWCOUNT > 0
            SET @ReturnResult = 'Success'
        ELSE
            SET @ReturnResult = 'No entry found.'

        --End Main Block
        COMMIT TRANSACTION
    END TRY

    BEGIN CATCH
        SET @ReturnResult = 'Transaction roll back.'

        ROLLBACK TRANSACTION MySavePoint;-- Rollback to MySavePoint
    END CATCH
END;

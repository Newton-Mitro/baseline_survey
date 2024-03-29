﻿/*
Stored Procedure SelectKhanasByUserId		
--------------------------------------------------------------------------------------
Script By                     : REZA E RABBI
Created At                    : 25 January 2022
Script Altered By             : REZA E RABBI
Altered At                    : 25 January 2022
Script Description            : This procedure will Select Khanas By User Id.
--------------------------------------------------------------------------------------
*/
CREATE PROCEDURE dbo.SelectKhanasByUserId (
    @UserId BIGINT
    , @ReturnResult VARCHAR(255) = NULL OUTPUT
    , @AccessedBy BIGINT = NULL -- Id of user who is accessing this stored procedure. 
    )
AS
BEGIN
    BEGIN TRANSACTION;

    SAVE TRANSACTION MySavePoint;-- Create a save point

    BEGIN TRY
        --Start Main Block
        DECLARE @RoleId AS BIGINT;

        SELECT @RoleId = RoleId
        FROM dbo.Users
        WHERE UserId = @UserId;

        IF (@RoleId = 1)
        BEGIN
            SELECT Members.MemberName, View_Khanas.*
            FROM View_Khanas 
            LEFT JOIN dbo.Members
                ON View_Khanas.KhanaId = Members.KhanaId AND Members.RelationWithFamilyHeadId = 1 ORDER BY View_Khanas.KhanaId DESC;
        END
        ELSE IF (@RoleId = 2)
        BEGIN
            SELECT Members.MemberName, View_Khanas.*
            FROM dbo.View_Khanas
            INNER JOIN dbo.Users
                ON Users.UserId = View_Khanas.CreatedBy
            INNER JOIN dbo.UsersSupervisors
                ON UsersSupervisors.UserId = Users.UserId
            LEFT JOIN dbo.Members
                ON View_Khanas.KhanaId = Members.KhanaId AND Members.RelationWithFamilyHeadId = 1 
            WHERE UsersSupervisors.SupervisorId = @UserId;
        END
        ELSE
        BEGIN
            SELECT Members.MemberName, View_Khanas.*
            FROM View_Khanas
            LEFT JOIN dbo.Members
                ON View_Khanas.KhanaId = Members.KhanaId AND Members.RelationWithFamilyHeadId = 1
            WHERE View_Khanas.CreatedBy = @UserId ORDER BY View_Khanas.KhanaId DESC;
        END

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

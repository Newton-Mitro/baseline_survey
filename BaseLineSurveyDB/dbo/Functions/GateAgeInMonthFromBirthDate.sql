﻿CREATE FUNCTION dbo.GateAgeInMonthFromBirthDate (@DateOfBirth DATETIME2)
RETURNS INT
AS
BEGIN
    RETURN CAST((DATEDIFF(M, @DateOfBirth, GETDATE()) % 12) AS VARCHAR)
END


﻿/*
Table Name Districts		
--------------------------------------------------------------------------------------
Script By                     : Reza-E-Rabbi
Created At                    : 17 January 2022
Script Altered By             : Reza-E-Rabbi
Altered At                    : 17 January 2022
Script Description            : This procedure will create Districts table.
--------------------------------------------------------------------------------------
*/
CREATE TABLE dbo.Districts (
    DistrictId BIGINT NOT NULL PRIMARY KEY IDENTITY
    , DistrictName NVARCHAR(250) NOT NULL
    , CreatedBy BIGINT NULL
    , UpdatedBy BIGINT NULL
    , CreatedAt DATETIME2 NULL
    , UpdatedAt DATETIME2 NULL
    )

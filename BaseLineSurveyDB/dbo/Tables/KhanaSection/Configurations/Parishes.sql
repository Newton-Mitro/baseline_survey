﻿/*
Table Name Parishes		
--------------------------------------------------------------------------------------
Script By                     : Reza-E-Rabbi
Created At                    : 17 January 2022
Script Altered By             : Reza-E-Rabbi
Altered At                    : 17 January 2022
Script Description            : This procedure will create Parishes table.
--------------------------------------------------------------------------------------
*/
CREATE TABLE dbo.Parishes (
    ParishId BIGINT NOT NULL PRIMARY KEY IDENTITY
    , UpazilaId BIGINT NOT NULL
    , ParishName NVARCHAR(250) NOT NULL
    , CreatedBy BIGINT NULL
    , UpdatedBy BIGINT NULL
    , CreatedAt DATETIME2 NULL
    , UpdatedAt DATETIME2 NULL
    , CONSTRAINT FK_Parises_Upazilas FOREIGN KEY (UpazilaId) REFERENCES Upazilas(UpazilaId)
    )

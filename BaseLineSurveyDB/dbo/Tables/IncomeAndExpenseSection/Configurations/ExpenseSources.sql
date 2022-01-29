﻿/*
Table Name ExpenseSources		
--------------------------------------------------------------------------------------
Script By                     : Reza-E-Rabbi
Created At                    : 17 January 2022
Script Altered By             : Reza-E-Rabbi
Altered At                    : 17 January 2022
Script Description            : This procedure will create Expense Sources table.
--------------------------------------------------------------------------------------
*/
CREATE TABLE dbo.ExpenseSources (
    ExpenseSourcesId BIGINT NOT NULL PRIMARY KEY IDENTITY
    , SourceName NVARCHAR(250) NULL
    , CreatedBy BIGINT NULL
    , UpdatedBy BIGINT NULL
    , CreatedAt DATETIME2 NULL
    , UpdatedAt DATETIME2 NULL
    )

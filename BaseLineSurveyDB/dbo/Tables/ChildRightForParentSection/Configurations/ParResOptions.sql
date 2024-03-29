﻿/*
Table Name ParResponseOptions		
--------------------------------------------------------------------------------------
Script By                     : Reza-E-Rabbi
Created At                    : 17 January 2022
Script Altered By             : Reza-E-Rabbi
Altered At                    : 17 January 2022
Script Description            : This procedure will create ParResponse Options table.
--------------------------------------------------------------------------------------
*/
CREATE TABLE dbo.ParResponseOptions (
    PerResponseOptionId BIGINT NOT NULL PRIMARY KEY IDENTITY(1, 1)
    , QuestionText NVARCHAR(250) NULL
    , ParResQuestionId BIGINT NOT NULL
    , CreatedBy BIGINT NULL
    , UpdatedBy BIGINT NULL
    , CreatedAt DATETIME2 NULL
    , UpdatedAt DATETIME2 NULL
    , CONSTRAINT FK_PerResponseOptions_ParResQuestion FOREIGN KEY (ParResQuestionId) REFERENCES ParResponseQuestions(ParResQuestionId)
    )

﻿CREATE TABLE dbo.Roles (
    RoleId BIGINT NOT NULL PRIMARY KEY IDENTITY
    , RoleName NVARCHAR(250) NOT NULL
    , CreatedBy BIGINT NULL
    , UpdatedBy BIGINT NULL
    , CreatedAt DATETIME2 NULL
    , UpdatedAt DATETIME2 NULL
    )

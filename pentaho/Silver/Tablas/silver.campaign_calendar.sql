USE [base_esteban];
GO

SET ANSI_NULLS ON;
GO
SET QUOTED_IDENTIFIER ON;
GO

CREATE TABLE [silver].[campaign_calendar]
(
    [campaign_id]   varchar(20) NOT NULL,
    [campaign_name] varchar(100) NULL,
    [campaign_type] varchar(30) NULL,
    [start_date]    date NOT NULL,
    [end_date]      date NOT NULL,
    CONSTRAINT [PK_silver_campaign_calendar] PRIMARY KEY ([campaign_id])
);
GO

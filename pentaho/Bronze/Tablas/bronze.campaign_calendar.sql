USE [base_esteban]
GO

/****** Object:  Table [bronze].[campaign_calendar]    Script Date: 27/11/2026 20:51:43 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [bronze].[campaign_calendar](
	[campaign_id] [varchar](20) NULL,
	[campaign_name] [varchar](100) NULL,
	[campaign_type] [varchar](30) NULL,
	[start_date] [date] NULL,
	[end_date] [date] NULL
) ON [PRIMARY]
GO



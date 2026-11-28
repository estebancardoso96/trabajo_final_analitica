USE [base_esteban]
GO

/****** Object:  Table [bronze].[budget_2018]    Script Date: 27/11/2026 20:51:47 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [bronze].[budget_2018](
	[version] [varchar](10) NULL,
	[region] [varchar](50) NULL,
	[category] [varchar](100) NULL,
	[jan] [decimal](12, 3) NULL,
	[feb] [decimal](12, 3) NULL,
	[mar] [decimal](12, 3) NULL,
	[apr] [decimal](12, 3) NULL,
	[may] [decimal](12, 3) NULL,
	[jun] [decimal](12, 3) NULL,
	[jul] [decimal](12, 3) NULL,
	[aug] [decimal](12, 3) NULL,
	[sep] [decimal](12, 3) NULL,
	[oct] [decimal](12, 3) NULL,
	[nov] [decimal](12, 3) NULL,
	[dec] [decimal](12, 3) NULL,
	[total_2018] [decimal](12, 3) NULL
) ON [PRIMARY]
GO



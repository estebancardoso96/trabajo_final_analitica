USE [base_esteban]
GO

/****** Object:  Table [bronze].[sap_customers]    Script Date: 27/11/2026 20:50:23 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [bronze].[sap_customers](
	[MANDT] [int] NULL,
	[KUNNR] [varchar](200) NULL,
	[STCD1] [varchar](200) NULL,
	[PSTLZ] [int] NULL,
	[ORT01] [varchar](200) NULL,
	[REGIO] [varchar](200) NULL,
	[LAND1] [varchar](200) NULL
) ON [PRIMARY]
GO



USE [base_esteban]
GO

/****** Object:  Table [bronze].[olist_customers]    Script Date: 27/11/2026 20:51:32 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [bronze].[olist_customers](
	[customer_id] [varchar](200) NULL,
	[customer_zip_code_prefix] [varchar](200) NULL,
	[customer_city] [varchar](200) NULL,
	[customer_state] [varchar](200) NULL
) ON [PRIMARY]
GO



USE [base_esteban]
GO

/****** Object:  Table [silver].[customers]    Script Date: 27/11/2026 20:48:49 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [silver].[customers](
	[customer_id] [varchar](max) NULL,
	[customer_zip_code_prefix] [varchar](max) NULL,
	[customer_city] [varchar](max) NULL,
	[customer_state] [varchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO



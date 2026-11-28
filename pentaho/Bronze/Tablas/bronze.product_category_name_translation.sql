USE [base_esteban]
GO

/****** Object:  Table [bronze].[product_category_name_translation]    Script Date: 27/11/2026 20:51:20 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [bronze].[product_category_name_translation](
	[product_category_name] [varchar](100) NULL,
	[product_category_name_english] [varchar](100) NULL
) ON [PRIMARY]
GO



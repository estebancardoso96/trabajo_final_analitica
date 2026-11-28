USE [base_esteban]
GO

/****** Object:  Table [bronze].[products]    Script Date: 27/11/2026 20:51:12 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [bronze].[products](
	[product_id] [varchar](100) NULL,
	[product_category_name] [varchar](100) NULL,
	[product_name_lenght] [int] NULL,
	[product_description_lenght] [int] NULL,
	[product_photos_qty] [int] NULL,
	[product_weight_g] [int] NULL,
	[product_length_cm] [int] NULL,
	[product_height_cm] [int] NULL,
	[product_width_cm] [int] NULL
) ON [PRIMARY]
GO



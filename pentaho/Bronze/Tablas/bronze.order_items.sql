USE [base_esteban]
GO

/****** Object:  Table [bronze].[order_items]    Script Date: 27/11/2026 20:51:28 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [bronze].[order_items](
	[order_id] [varchar](32) NULL,
	[order_item_id] [int] NULL,
	[product_id] [varchar](32) NULL,
	[seller_id] [varchar](32) NULL,
	[shipping_limit_date] [datetime2](0) NULL,
	[price] [decimal](15, 2) NULL,
	[freight_value] [decimal](15, 2) NULL
) ON [PRIMARY]
GO



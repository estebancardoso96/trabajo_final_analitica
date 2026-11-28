USE [base_esteban]
GO

/****** Object:  Table [bronze].[orders]    Script Date: 27/11/2026 20:51:24 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [bronze].[orders](
	[order_id] [varchar](32) NULL,
	[customer_id] [varchar](32) NULL,
	[order_status] [varchar](20) NULL,
	[order_purchase_timestamp] [datetime2](0) NULL,
	[order_approved_at] [datetime2](0) NULL,
	[order_delivered_carrier_date] [datetime2](0) NULL,
	[order_delivered_customer_date] [datetime2](0) NULL,
	[order_estimated_delivery_date] [datetime2](0) NULL
) ON [PRIMARY]
GO



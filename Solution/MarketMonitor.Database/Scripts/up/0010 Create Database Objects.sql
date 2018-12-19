IF EXISTS (
	SELECT 1 
	FROM [sys].[foreign_keys] 
	WHERE [object_id] = OBJECT_ID(N'dbo.FK_Spread_Product]')
	AND parent_object_id = OBJECT_ID(N'dbo.Spread')
)
	ALTER TABLE [dbo].[Spread] DROP CONSTRAINT [FK_Spread_Product]
GO
IF EXISTS (
	SELECT 1 
	FROM [sys].[foreign_keys] 
	WHERE [object_id] = OBJECT_ID(N'dbo.FK_Product_Market]')
	AND parent_object_id = OBJECT_ID(N'dbo.Product')
)
	ALTER TABLE [dbo].[Product] DROP CONSTRAINT [FK_Product_Market]
GO
/****** Object:  Table [dbo].[Spread]    Script Date: 19/12/2018 14:14:24 ******/
DROP TABLE IF EXISTS [dbo].[Spread]
GO
/****** Object:  Table [dbo].[Product]    Script Date: 19/12/2018 14:14:24 ******/
DROP TABLE IF EXISTS [dbo].[Product]
GO
/****** Object:  Table [dbo].[Market]    Script Date: 19/12/2018 14:14:24 ******/
DROP TABLE IF EXISTS [dbo].[Market]
GO
/****** Object:  Table [dbo].[Market]    Script Date: 19/12/2018 14:14:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Market](
	[MarketId] [int] IDENTITY(1,1) NOT NULL,
	[MarketUid] [uniqueidentifier] NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
 CONSTRAINT [PK_Market] PRIMARY KEY CLUSTERED 
(
	[MarketId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Product]    Script Date: 19/12/2018 14:14:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Product](
	[ProductId] [int] IDENTITY(1,1) NOT NULL,
	[MarketId] [int] NOT NULL,
	[ProductUid] [uniqueidentifier] NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
 CONSTRAINT [PK_Product] PRIMARY KEY CLUSTERED 
(
	[ProductId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Spread]    Script Date: 19/12/2018 14:14:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Spread](
	[SpreadId] [int] NOT NULL,
	[ProductId] [int] NOT NULL,
	[SpreadUid] [uniqueidentifier] NOT NULL,
	[BidPrice] [decimal](18, 2) NULL,
	[BidQuantity] [int] NOT NULL,
	[OfferPrice] [decimal](18, 2) NULL,
	[OfferQuantity] [int] NOT NULL,
 CONSTRAINT [PK_Spread] PRIMARY KEY CLUSTERED 
(
	[SpreadId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Product]  WITH CHECK ADD  CONSTRAINT [FK_Product_Market] FOREIGN KEY([MarketId])
REFERENCES [dbo].[Market] ([MarketId])
GO
ALTER TABLE [dbo].[Product] CHECK CONSTRAINT [FK_Product_Market]
GO
ALTER TABLE [dbo].[Spread]  WITH CHECK ADD  CONSTRAINT [FK_Spread_Product] FOREIGN KEY([ProductId])
REFERENCES [dbo].[Product] ([ProductId])
GO
ALTER TABLE [dbo].[Spread] CHECK CONSTRAINT [FK_Spread_Product]
GO

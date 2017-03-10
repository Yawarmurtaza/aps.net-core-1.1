USE [master]
GO
/****** Object:  Database [MyCoffeeShop]    Script Date: 10/03/2017 20:53:40 ******/
CREATE DATABASE [MyCoffeeShop]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'MyChaiShop', FILENAME = N'E:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\MyChaiShop.mdf' , SIZE = 5120KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'MyChaiShop_log', FILENAME = N'E:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\MyChaiShop_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [MyCoffeeShop] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [MyCoffeeShop].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [MyCoffeeShop] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [MyCoffeeShop] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [MyCoffeeShop] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [MyCoffeeShop] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [MyCoffeeShop] SET ARITHABORT OFF 
GO
ALTER DATABASE [MyCoffeeShop] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [MyCoffeeShop] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [MyCoffeeShop] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [MyCoffeeShop] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [MyCoffeeShop] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [MyCoffeeShop] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [MyCoffeeShop] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [MyCoffeeShop] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [MyCoffeeShop] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [MyCoffeeShop] SET  DISABLE_BROKER 
GO
ALTER DATABASE [MyCoffeeShop] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [MyCoffeeShop] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [MyCoffeeShop] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [MyCoffeeShop] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [MyCoffeeShop] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [MyCoffeeShop] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [MyCoffeeShop] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [MyCoffeeShop] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [MyCoffeeShop] SET  MULTI_USER 
GO
ALTER DATABASE [MyCoffeeShop] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [MyCoffeeShop] SET DB_CHAINING OFF 
GO
ALTER DATABASE [MyCoffeeShop] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [MyCoffeeShop] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [MyCoffeeShop] SET DELAYED_DURABILITY = DISABLED 
GO
USE [MyCoffeeShop]
GO
/****** Object:  Table [dbo].[Coffee]    Script Date: 10/03/2017 20:53:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Coffee](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[ShortDesc] [nvarchar](500) NOT NULL,
	[LongDesc] [nvarchar](1000) NOT NULL,
	[Price] [decimal](4, 2) NOT NULL,
	[ImageThumbnailUrl] [nvarchar](500) NOT NULL,
	[ImageUrl] [nvarchar](500) NOT NULL,
	[IsCoffeeOfTheWeek] [bit] NOT NULL,
	[InStock] [bit] NOT NULL,
	[CategoryId] [int] NOT NULL,
	[DateTimeStamp] [datetime] NOT NULL CONSTRAINT [DF_Coffee_DateTimeStamp]  DEFAULT (getdate()),
 CONSTRAINT [PK_Coffee] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[CoffeeCategory]    Script Date: 10/03/2017 20:53:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CoffeeCategory](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NULL,
	[Description] [nvarchar](1000) NULL,
 CONSTRAINT [PK_Categories] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Order]    Script Date: 10/03/2017 20:53:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Order](
	[OrderId] [uniqueidentifier] NOT NULL,
	[AddressLine1] [nvarchar](100) NOT NULL,
	[AddressLine2] [nvarchar](max) NULL,
	[City] [nvarchar](50) NOT NULL,
	[Email] [nvarchar](50) NOT NULL,
	[FirstName] [nvarchar](50) NOT NULL,
	[LastName] [nvarchar](50) NOT NULL,
	[OrderPlaced] [datetime2](7) NOT NULL CONSTRAINT [DF_Order_OrderPlaced]  DEFAULT (getdate()),
	[OrderTotal] [decimal](18, 2) NOT NULL,
	[PhoneNumber] [nvarchar](25) NOT NULL,
	[County] [nvarchar](10) NULL,
	[PostCode] [nvarchar](10) NOT NULL,
 CONSTRAINT [PK_Orders] PRIMARY KEY CLUSTERED 
(
	[OrderId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[OrderDetail]    Script Date: 10/03/2017 20:53:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderDetail](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CoffeeId] [int] NOT NULL,
	[Quantity] [int] NOT NULL,
	[OrderId] [uniqueidentifier] NOT NULL,
	[Price] [decimal](4, 2) NOT NULL,
	[DateTimeStamp] [datetime] NOT NULL CONSTRAINT [DF_OrderDetail_DateTimeStamp]  DEFAULT (getdate()),
 CONSTRAINT [PK_OrderDetail] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ShoppingBasketItem]    Script Date: 10/03/2017 20:53:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ShoppingBasketItem](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Quantity] [int] NOT NULL,
	[CoffeeId] [int] NOT NULL,
	[ShoppingBasketNumber] [uniqueidentifier] NOT NULL,
	[DateTimeStamp] [datetime] NOT NULL CONSTRAINT [DF_ShoppingCartItem_DateTimeStamp]  DEFAULT (getdate()),
 CONSTRAINT [PK_ShoppingCartItem] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET IDENTITY_INSERT [dbo].[Coffee] ON 

GO
INSERT [dbo].[Coffee] ([Id], [Name], [ShortDesc], [LongDesc], [Price], [ImageThumbnailUrl], [ImageUrl], [IsCoffeeOfTheWeek], [InStock], [CategoryId], [DateTimeStamp]) VALUES (1, N'Café Latte', N'made with espresso and steamed milk.', N'A café latte, or “latte” for short, is an espresso based drink with steamed milk and micro-foam added to the coffee. This coffee is much sweeter compared to an espresso due to the steamed milk', CAST(3.25 AS Decimal(4, 2)), N'\images\thumbnails\CafeLatte.JPG', N'\images\fullImages\CafeLatte.JPG', 0, 1, 1, CAST(N'2017-03-06 19:42:17.950' AS DateTime))
GO
INSERT [dbo].[Coffee] ([Id], [Name], [ShortDesc], [LongDesc], [Price], [ImageThumbnailUrl], [ImageUrl], [IsCoffeeOfTheWeek], [InStock], [CategoryId], [DateTimeStamp]) VALUES (2, N'Cappuccino', N'An Italian coffee drink made with double espresso & hot milk.', N'A cappuccino is similar to a latte. However the key difference between a latte and cappuccino is that a cappuccino has more foam and chocolate placed on top of the drink. Further a cappuccino is made in a cup rather than a tumbler glass.', CAST(1.99 AS Decimal(4, 2)), N'\images\thumbnails\Cappuccino.jpg', N'\images\fullImages\Cappuccino.jpg', 1, 1, 1, CAST(N'2017-03-06 19:45:15.440' AS DateTime))
GO
INSERT [dbo].[Coffee] ([Id], [Name], [ShortDesc], [LongDesc], [Price], [ImageThumbnailUrl], [ImageUrl], [IsCoffeeOfTheWeek], [InStock], [CategoryId], [DateTimeStamp]) VALUES (3, N'Flat White', N'Espresso based coffee with  microfoam over a double shot of espresso.', N'A flat white is a coffee you’ll primarily find in Australia and New Zealand. It is made the same as a cappuccino expect it does not have any foam or chocolate on top', CAST(2.75 AS Decimal(4, 2)), N'\images\thumbnails\flat-white.jpg', N'\images\fullImages\flat-white.jpg', 0, 1, 1, CAST(N'2017-03-06 19:46:33.390' AS DateTime))
GO
INSERT [dbo].[Coffee] ([Id], [Name], [ShortDesc], [LongDesc], [Price], [ImageThumbnailUrl], [ImageUrl], [IsCoffeeOfTheWeek], [InStock], [CategoryId], [DateTimeStamp]) VALUES (4, N'Piccolo Latte', N'A piccolo latte is a café latte made in an espresso cup. ', N'A piccolo latte is a café latte made in an espresso cup. This means it has a very strong but mellowed down espresso taste thanks to the steamed milk and micro foam within it.', CAST(3.75 AS Decimal(4, 2)), N'\images\thumbnails\piccolo-latte.jpg', N'\images\fullImages\piccolo-latte.jpg', 0, 1, 1, CAST(N'2017-03-06 19:47:28.400' AS DateTime))
GO
INSERT [dbo].[Coffee] ([Id], [Name], [ShortDesc], [LongDesc], [Price], [ImageThumbnailUrl], [ImageUrl], [IsCoffeeOfTheWeek], [InStock], [CategoryId], [DateTimeStamp]) VALUES (5, N'Double Espresso (Doppio)', N'A double shot espresso extracted using a double coffee filter.', N'wo shots of espresso prepared with 14 grams of ground coffee in a double portafilter. The double espresso shot should be about 1.5 ounces. A double espresso is a more concentrated shot with a thick, rich crema. It can still be made ristretto or luongo.', CAST(2.99 AS Decimal(4, 2)), N'\images\thumbnails\double-espresso.jpg', N'\images\fullImages\double-espresso.jpg', 0, 1, 2, CAST(N'2017-03-06 19:51:14.177' AS DateTime))
GO
INSERT [dbo].[Coffee] ([Id], [Name], [ShortDesc], [LongDesc], [Price], [ImageThumbnailUrl], [ImageUrl], [IsCoffeeOfTheWeek], [InStock], [CategoryId], [DateTimeStamp]) VALUES (6, N'Ristretto', N'A traditionally a short shot of espresso.', N'A ristretto is an espresso shot that is extracted with the same amount of coffee but half the amount of water. The end result is a more concentrated and darker espresso extraction.', CAST(3.99 AS Decimal(4, 2)), N'\images\thumbnails\ristretto.jpg', N'\images\fullImages\ristretto.jpg', 1, 1, 2, CAST(N'2017-03-06 19:52:55.830' AS DateTime))
GO
INSERT [dbo].[Coffee] ([Id], [Name], [ShortDesc], [LongDesc], [Price], [ImageThumbnailUrl], [ImageUrl], [IsCoffeeOfTheWeek], [InStock], [CategoryId], [DateTimeStamp]) VALUES (7, N'Long Black (Americano)', N'Hot water with an espresso.', N'A long black (aka “americano”) is hot water with an espresso shot extracted on top of the hot water', CAST(2.50 AS Decimal(4, 2)), N'\images\thumbnails\long-black.jpg', N'\images\fullImages\long-black.jpg', 0, 1, 2, CAST(N'2017-03-06 19:54:00.667' AS DateTime))
GO
INSERT [dbo].[Coffee] ([Id], [Name], [ShortDesc], [LongDesc], [Price], [ImageThumbnailUrl], [ImageUrl], [IsCoffeeOfTheWeek], [InStock], [CategoryId], [DateTimeStamp]) VALUES (8, N'Short Macchiato', N'Espresso with a dollop of steamed milk and foam.', N'A short macchiato is similar to an espresso but with a dollop of steamed milk and foam to mellow the harsh taste of an espresso. You will find that baristas in different countries make short macchiatos differently. ', CAST(4.20 AS Decimal(4, 2)), N'\images\thumbnails\short-macchiato.jpg', N'\images\fullImages\short-macchiato.jpg', 0, 1, 3, CAST(N'2017-03-06 19:56:48.860' AS DateTime))
GO
INSERT [dbo].[Coffee] ([Id], [Name], [ShortDesc], [LongDesc], [Price], [ImageThumbnailUrl], [ImageUrl], [IsCoffeeOfTheWeek], [InStock], [CategoryId], [DateTimeStamp]) VALUES (9, N'Long Macchiato', N'Short macchiato but with a double shot of espresso.', N'A long macchiato is the same as a short macchiato but with a double shot of espresso. ', CAST(5.20 AS Decimal(4, 2)), N'\images\thumbnails\long-macchiato.jpg', N'\images\fullImages\long-macchiato.jpg', 1, 1, 3, CAST(N'2017-03-06 19:58:00.203' AS DateTime))
GO
INSERT [dbo].[Coffee] ([Id], [Name], [ShortDesc], [LongDesc], [Price], [ImageThumbnailUrl], [ImageUrl], [IsCoffeeOfTheWeek], [InStock], [CategoryId], [DateTimeStamp]) VALUES (10, N'Mocha', N'A mix between a cappuccino and a hot chocolate.', N'A mocha is a mix between a cappuccino and a hot chocolate. It is made by putting mixing chocolate powder with an espresso shot and then adding steamed milk and micro-foam into the beverage.', CAST(4.80 AS Decimal(4, 2)), N'\images\thumbnails\mocha-coffee.jpg', N'\images\fullImages\mocha-coffee.jpg', 0, 1, 3, CAST(N'2017-03-06 19:58:53.020' AS DateTime))
GO
INSERT [dbo].[Coffee] ([Id], [Name], [ShortDesc], [LongDesc], [Price], [ImageThumbnailUrl], [ImageUrl], [IsCoffeeOfTheWeek], [InStock], [CategoryId], [DateTimeStamp]) VALUES (11, N'Espresso (Short Black)', N'It is the foundation of coffee.', N'The espresso (aka “short black”) is the foundation and the most important part to every espresso based drink. So much so that we’ve written a guide on how to make the perfect espresso shot.', CAST(2.80 AS Decimal(4, 2)), N'\images\thumbnails\espresso.jpg', N'\images\fullImages\espresso.jpg', 0, 1, 2, CAST(N'2017-03-06 20:01:23.197' AS DateTime))
GO
SET IDENTITY_INSERT [dbo].[Coffee] OFF
GO
SET IDENTITY_INSERT [dbo].[CoffeeCategory] ON 

GO
INSERT [dbo].[CoffeeCategory] ([Id], [Name], [Description]) VALUES (1, N'Milky Coffees', N'Rich with milk and milk foam for a smoother taste.')
GO
INSERT [dbo].[CoffeeCategory] ([Id], [Name], [Description]) VALUES (2, N'Strong Coffees', N'Intense coffee with concentration of expresso with water.')
GO
INSERT [dbo].[CoffeeCategory] ([Id], [Name], [Description]) VALUES (3, N'Hot Chocolates', N'Coffee with hot chocolate.')
GO
SET IDENTITY_INSERT [dbo].[CoffeeCategory] OFF
GO
INSERT [dbo].[Order] ([OrderId], [AddressLine1], [AddressLine2], [City], [Email], [FirstName], [LastName], [OrderPlaced], [OrderTotal], [PhoneNumber], [County], [PostCode]) VALUES (N'd5ea94b0-00ce-4713-96ce-4eb4cc19748b', N'rty', N'erty', N'ery', N'yaw@gmail.com', N'rty', N'rty', CAST(N'2017-03-09 23:02:42.1000000' AS DateTime2), CAST(0.00 AS Decimal(18, 2)), N'012478', N'erty', N'ertytry')
GO
INSERT [dbo].[Order] ([OrderId], [AddressLine1], [AddressLine2], [City], [Email], [FirstName], [LastName], [OrderPlaced], [OrderTotal], [PhoneNumber], [County], [PostCode]) VALUES (N'323662ab-b7ee-4f50-ba84-9fbf3c55fe5a', N'sdf', N'sdf', N'df', N'yaw@gmail.com', N'sdf', N'khuwaja', CAST(N'2017-03-09 23:10:25.9130000' AS DateTime2), CAST(0.00 AS Decimal(18, 2)), N'012478', N'df', N'pe3 4rf')
GO
INSERT [dbo].[Order] ([OrderId], [AddressLine1], [AddressLine2], [City], [Email], [FirstName], [LastName], [OrderPlaced], [OrderTotal], [PhoneNumber], [County], [PostCode]) VALUES (N'6e06484a-6cf9-48c9-871b-ca45371c48d8', N'asdfas', N'asd', N'asd', N'yaw@gmail.com', N'asd', N'asd', CAST(N'2017-03-09 22:52:48.6770000' AS DateTime2), CAST(0.00 AS Decimal(18, 2)), N'012478', N'asd', N'asdasd')
GO
INSERT [dbo].[Order] ([OrderId], [AddressLine1], [AddressLine2], [City], [Email], [FirstName], [LastName], [OrderPlaced], [OrderTotal], [PhoneNumber], [County], [PostCode]) VALUES (N'5c7a6ed2-3f5a-48a4-8364-dc0ccd924e8b', N'sdfsd', N'sdfsd', N'sdfdf', N'asdf@hotmail.com', N'asdfsdf', N'sdfsdf', CAST(N'2017-03-10 11:14:55.2530000' AS DateTime2), CAST(0.00 AS Decimal(18, 2)), N'sdfsdfsdfsdf', N'sdfd', N'fffff')
GO
SET IDENTITY_INSERT [dbo].[OrderDetail] ON 

GO
INSERT [dbo].[OrderDetail] ([Id], [CoffeeId], [Quantity], [OrderId], [Price], [DateTimeStamp]) VALUES (1, 2, 1, N'6e06484a-6cf9-48c9-871b-ca45371c48d8', CAST(1.99 AS Decimal(4, 2)), CAST(N'2017-03-09 22:53:06.150' AS DateTime))
GO
INSERT [dbo].[OrderDetail] ([Id], [CoffeeId], [Quantity], [OrderId], [Price], [DateTimeStamp]) VALUES (2, 2, 1, N'd5ea94b0-00ce-4713-96ce-4eb4cc19748b', CAST(1.99 AS Decimal(4, 2)), CAST(N'2017-03-09 23:02:46.357' AS DateTime))
GO
INSERT [dbo].[OrderDetail] ([Id], [CoffeeId], [Quantity], [OrderId], [Price], [DateTimeStamp]) VALUES (3, 2, 1, N'323662ab-b7ee-4f50-ba84-9fbf3c55fe5a', CAST(1.99 AS Decimal(4, 2)), CAST(N'2017-03-09 23:10:25.920' AS DateTime))
GO
INSERT [dbo].[OrderDetail] ([Id], [CoffeeId], [Quantity], [OrderId], [Price], [DateTimeStamp]) VALUES (4, 2, 2, N'5c7a6ed2-3f5a-48a4-8364-dc0ccd924e8b', CAST(1.99 AS Decimal(4, 2)), CAST(N'2017-03-10 11:14:55.260' AS DateTime))
GO
INSERT [dbo].[OrderDetail] ([Id], [CoffeeId], [Quantity], [OrderId], [Price], [DateTimeStamp]) VALUES (5, 3, 1, N'5c7a6ed2-3f5a-48a4-8364-dc0ccd924e8b', CAST(2.75 AS Decimal(4, 2)), CAST(N'2017-03-10 11:14:55.267' AS DateTime))
GO
SET IDENTITY_INSERT [dbo].[OrderDetail] OFF
GO
SET IDENTITY_INSERT [dbo].[ShoppingBasketItem] ON 

GO
INSERT [dbo].[ShoppingBasketItem] ([Id], [Quantity], [CoffeeId], [ShoppingBasketNumber], [DateTimeStamp]) VALUES (1, 1, 2, N'fb8d4ad4-a362-4e9b-8c4a-24ca8e4e8fd4', CAST(N'2017-03-09 12:44:52.643' AS DateTime))
GO
INSERT [dbo].[ShoppingBasketItem] ([Id], [Quantity], [CoffeeId], [ShoppingBasketNumber], [DateTimeStamp]) VALUES (2, 2, 2, N'fb8d4ad4-a362-4e9b-8c4a-24ca8e4e8fd4', CAST(N'2017-03-09 12:45:52.007' AS DateTime))
GO
INSERT [dbo].[ShoppingBasketItem] ([Id], [Quantity], [CoffeeId], [ShoppingBasketNumber], [DateTimeStamp]) VALUES (3, 1, 2, N'96237e2e-6ff1-4987-85c7-7e78b4908128', CAST(N'2017-03-09 12:48:30.370' AS DateTime))
GO
INSERT [dbo].[ShoppingBasketItem] ([Id], [Quantity], [CoffeeId], [ShoppingBasketNumber], [DateTimeStamp]) VALUES (4, 2, 2, N'c5444601-9e1a-4d5a-b442-f3db88c3580f', CAST(N'2017-03-09 12:49:41.617' AS DateTime))
GO
INSERT [dbo].[ShoppingBasketItem] ([Id], [Quantity], [CoffeeId], [ShoppingBasketNumber], [DateTimeStamp]) VALUES (5, 2, 9, N'c5444601-9e1a-4d5a-b442-f3db88c3580f', CAST(N'2017-03-09 12:50:41.140' AS DateTime))
GO
INSERT [dbo].[ShoppingBasketItem] ([Id], [Quantity], [CoffeeId], [ShoppingBasketNumber], [DateTimeStamp]) VALUES (6, 1, 6, N'c5444601-9e1a-4d5a-b442-f3db88c3580f', CAST(N'2017-03-09 12:56:11.557' AS DateTime))
GO
INSERT [dbo].[ShoppingBasketItem] ([Id], [Quantity], [CoffeeId], [ShoppingBasketNumber], [DateTimeStamp]) VALUES (7, 2, 9, N'8f7feed2-cf04-43b1-8627-c6e991347f9c', CAST(N'2017-03-09 13:06:55.440' AS DateTime))
GO
INSERT [dbo].[ShoppingBasketItem] ([Id], [Quantity], [CoffeeId], [ShoppingBasketNumber], [DateTimeStamp]) VALUES (8, 1, 2, N'8f7feed2-cf04-43b1-8627-c6e991347f9c', CAST(N'2017-03-09 13:07:32.533' AS DateTime))
GO
INSERT [dbo].[ShoppingBasketItem] ([Id], [Quantity], [CoffeeId], [ShoppingBasketNumber], [DateTimeStamp]) VALUES (9, 1, 6, N'8f7feed2-cf04-43b1-8627-c6e991347f9c', CAST(N'2017-03-09 13:07:39.317' AS DateTime))
GO
INSERT [dbo].[ShoppingBasketItem] ([Id], [Quantity], [CoffeeId], [ShoppingBasketNumber], [DateTimeStamp]) VALUES (10, 1, 4, N'8f7feed2-cf04-43b1-8627-c6e991347f9c', CAST(N'2017-03-09 13:07:54.193' AS DateTime))
GO
INSERT [dbo].[ShoppingBasketItem] ([Id], [Quantity], [CoffeeId], [ShoppingBasketNumber], [DateTimeStamp]) VALUES (11, 3, 9, N'f85817cc-8df0-46a1-a9fd-47f8047cf2a8', CAST(N'2017-03-09 13:11:01.423' AS DateTime))
GO
INSERT [dbo].[ShoppingBasketItem] ([Id], [Quantity], [CoffeeId], [ShoppingBasketNumber], [DateTimeStamp]) VALUES (12, 1, 2, N'f85817cc-8df0-46a1-a9fd-47f8047cf2a8', CAST(N'2017-03-09 13:11:21.880' AS DateTime))
GO
INSERT [dbo].[ShoppingBasketItem] ([Id], [Quantity], [CoffeeId], [ShoppingBasketNumber], [DateTimeStamp]) VALUES (13, 1, 8, N'f85817cc-8df0-46a1-a9fd-47f8047cf2a8', CAST(N'2017-03-09 13:11:38.787' AS DateTime))
GO
INSERT [dbo].[ShoppingBasketItem] ([Id], [Quantity], [CoffeeId], [ShoppingBasketNumber], [DateTimeStamp]) VALUES (14, 1, 5, N'f85817cc-8df0-46a1-a9fd-47f8047cf2a8', CAST(N'2017-03-09 13:11:47.997' AS DateTime))
GO
INSERT [dbo].[ShoppingBasketItem] ([Id], [Quantity], [CoffeeId], [ShoppingBasketNumber], [DateTimeStamp]) VALUES (15, 1, 2, N'142a5430-9743-4372-99f3-2c0ff7747a7d', CAST(N'2017-03-09 13:12:54.287' AS DateTime))
GO
INSERT [dbo].[ShoppingBasketItem] ([Id], [Quantity], [CoffeeId], [ShoppingBasketNumber], [DateTimeStamp]) VALUES (16, 2, 2, N'a7e13849-1dcc-4896-9eb0-1f51ab45233e', CAST(N'2017-03-09 19:52:00.050' AS DateTime))
GO
INSERT [dbo].[ShoppingBasketItem] ([Id], [Quantity], [CoffeeId], [ShoppingBasketNumber], [DateTimeStamp]) VALUES (17, 3, 6, N'a7e13849-1dcc-4896-9eb0-1f51ab45233e', CAST(N'2017-03-09 19:52:22.577' AS DateTime))
GO
INSERT [dbo].[ShoppingBasketItem] ([Id], [Quantity], [CoffeeId], [ShoppingBasketNumber], [DateTimeStamp]) VALUES (18, 1, 9, N'a7e13849-1dcc-4896-9eb0-1f51ab45233e', CAST(N'2017-03-09 19:52:37.117' AS DateTime))
GO
INSERT [dbo].[ShoppingBasketItem] ([Id], [Quantity], [CoffeeId], [ShoppingBasketNumber], [DateTimeStamp]) VALUES (19, 2, 10, N'a7e13849-1dcc-4896-9eb0-1f51ab45233e', CAST(N'2017-03-09 19:52:59.473' AS DateTime))
GO
INSERT [dbo].[ShoppingBasketItem] ([Id], [Quantity], [CoffeeId], [ShoppingBasketNumber], [DateTimeStamp]) VALUES (20, 1, 6, N'aae3035d-417f-41ab-8104-fcebfdb55f0b', CAST(N'2017-03-09 20:03:05.340' AS DateTime))
GO
INSERT [dbo].[ShoppingBasketItem] ([Id], [Quantity], [CoffeeId], [ShoppingBasketNumber], [DateTimeStamp]) VALUES (21, 1, 9, N'7b9a1639-e6dc-40ee-8d99-88ec9fd63c4b', CAST(N'2017-03-09 20:03:27.960' AS DateTime))
GO
INSERT [dbo].[ShoppingBasketItem] ([Id], [Quantity], [CoffeeId], [ShoppingBasketNumber], [DateTimeStamp]) VALUES (22, 1, 10, N'7b9a1639-e6dc-40ee-8d99-88ec9fd63c4b', CAST(N'2017-03-09 20:03:34.657' AS DateTime))
GO
INSERT [dbo].[ShoppingBasketItem] ([Id], [Quantity], [CoffeeId], [ShoppingBasketNumber], [DateTimeStamp]) VALUES (23, 1, 2, N'7b9a1639-e6dc-40ee-8d99-88ec9fd63c4b', CAST(N'2017-03-09 20:03:40.063' AS DateTime))
GO
INSERT [dbo].[ShoppingBasketItem] ([Id], [Quantity], [CoffeeId], [ShoppingBasketNumber], [DateTimeStamp]) VALUES (24, 1, 3, N'aae3035d-417f-41ab-8104-fcebfdb55f0b', CAST(N'2017-03-09 20:03:47.987' AS DateTime))
GO
INSERT [dbo].[ShoppingBasketItem] ([Id], [Quantity], [CoffeeId], [ShoppingBasketNumber], [DateTimeStamp]) VALUES (25, 2, 6, N'7b9a1639-e6dc-40ee-8d99-88ec9fd63c4b', CAST(N'2017-03-09 20:04:05.727' AS DateTime))
GO
INSERT [dbo].[ShoppingBasketItem] ([Id], [Quantity], [CoffeeId], [ShoppingBasketNumber], [DateTimeStamp]) VALUES (26, 1, 9, N'060fb7fc-919d-42c5-ad88-473d86fde5d7', CAST(N'2017-03-09 20:07:00.853' AS DateTime))
GO
INSERT [dbo].[ShoppingBasketItem] ([Id], [Quantity], [CoffeeId], [ShoppingBasketNumber], [DateTimeStamp]) VALUES (27, 1, 2, N'060fb7fc-919d-42c5-ad88-473d86fde5d7', CAST(N'2017-03-09 20:07:07.650' AS DateTime))
GO
INSERT [dbo].[ShoppingBasketItem] ([Id], [Quantity], [CoffeeId], [ShoppingBasketNumber], [DateTimeStamp]) VALUES (28, 1, 8, N'060fb7fc-919d-42c5-ad88-473d86fde5d7', CAST(N'2017-03-09 20:07:15.183' AS DateTime))
GO
INSERT [dbo].[ShoppingBasketItem] ([Id], [Quantity], [CoffeeId], [ShoppingBasketNumber], [DateTimeStamp]) VALUES (29, 1, 2, N'59e8392e-104a-4a74-abcc-59be22cf1388', CAST(N'2017-03-09 20:26:09.993' AS DateTime))
GO
INSERT [dbo].[ShoppingBasketItem] ([Id], [Quantity], [CoffeeId], [ShoppingBasketNumber], [DateTimeStamp]) VALUES (30, 1, 2, N'499715fe-c77d-4cf2-bab4-f2882631c976', CAST(N'2017-03-09 20:27:07.173' AS DateTime))
GO
INSERT [dbo].[ShoppingBasketItem] ([Id], [Quantity], [CoffeeId], [ShoppingBasketNumber], [DateTimeStamp]) VALUES (31, 1, 6, N'499715fe-c77d-4cf2-bab4-f2882631c976', CAST(N'2017-03-09 20:27:15.430' AS DateTime))
GO
INSERT [dbo].[ShoppingBasketItem] ([Id], [Quantity], [CoffeeId], [ShoppingBasketNumber], [DateTimeStamp]) VALUES (32, 1, 2, N'fdfa67e6-c858-4e8e-9b85-0e0ea33a6bd3', CAST(N'2017-03-09 20:27:52.050' AS DateTime))
GO
INSERT [dbo].[ShoppingBasketItem] ([Id], [Quantity], [CoffeeId], [ShoppingBasketNumber], [DateTimeStamp]) VALUES (33, 1, 1, N'fdfa67e6-c858-4e8e-9b85-0e0ea33a6bd3', CAST(N'2017-03-09 20:28:45.247' AS DateTime))
GO
INSERT [dbo].[ShoppingBasketItem] ([Id], [Quantity], [CoffeeId], [ShoppingBasketNumber], [DateTimeStamp]) VALUES (34, 1, 2, N'185688a0-f147-4560-a994-99b42b1bdc08', CAST(N'2017-03-09 20:32:05.770' AS DateTime))
GO
INSERT [dbo].[ShoppingBasketItem] ([Id], [Quantity], [CoffeeId], [ShoppingBasketNumber], [DateTimeStamp]) VALUES (35, 1, 6, N'185688a0-f147-4560-a994-99b42b1bdc08', CAST(N'2017-03-09 20:32:10.230' AS DateTime))
GO
INSERT [dbo].[ShoppingBasketItem] ([Id], [Quantity], [CoffeeId], [ShoppingBasketNumber], [DateTimeStamp]) VALUES (36, 1, 7, N'185688a0-f147-4560-a994-99b42b1bdc08', CAST(N'2017-03-09 20:32:30.963' AS DateTime))
GO
INSERT [dbo].[ShoppingBasketItem] ([Id], [Quantity], [CoffeeId], [ShoppingBasketNumber], [DateTimeStamp]) VALUES (37, 1, 8, N'bd04b5d6-53cf-4148-87a6-2eb282a42796', CAST(N'2017-03-09 21:09:26.157' AS DateTime))
GO
INSERT [dbo].[ShoppingBasketItem] ([Id], [Quantity], [CoffeeId], [ShoppingBasketNumber], [DateTimeStamp]) VALUES (38, 4, 6, N'bd04b5d6-53cf-4148-87a6-2eb282a42796', CAST(N'2017-03-09 21:09:30.833' AS DateTime))
GO
INSERT [dbo].[ShoppingBasketItem] ([Id], [Quantity], [CoffeeId], [ShoppingBasketNumber], [DateTimeStamp]) VALUES (39, 1, 2, N'bd04b5d6-53cf-4148-87a6-2eb282a42796', CAST(N'2017-03-09 21:09:43.850' AS DateTime))
GO
INSERT [dbo].[ShoppingBasketItem] ([Id], [Quantity], [CoffeeId], [ShoppingBasketNumber], [DateTimeStamp]) VALUES (40, 1, 7, N'bd04b5d6-53cf-4148-87a6-2eb282a42796', CAST(N'2017-03-09 21:09:48.040' AS DateTime))
GO
INSERT [dbo].[ShoppingBasketItem] ([Id], [Quantity], [CoffeeId], [ShoppingBasketNumber], [DateTimeStamp]) VALUES (41, 1, 6, N'a25b14ea-6eab-46b2-989e-2ef8293bb424', CAST(N'2017-03-09 22:31:02.207' AS DateTime))
GO
INSERT [dbo].[ShoppingBasketItem] ([Id], [Quantity], [CoffeeId], [ShoppingBasketNumber], [DateTimeStamp]) VALUES (42, 1, 2, N'42315b24-d61e-4da2-bede-3456c018ad52', CAST(N'2017-03-09 22:33:30.083' AS DateTime))
GO
INSERT [dbo].[ShoppingBasketItem] ([Id], [Quantity], [CoffeeId], [ShoppingBasketNumber], [DateTimeStamp]) VALUES (43, 1, 2, N'518c7c96-0e4f-4849-b717-0593e853cea2', CAST(N'2017-03-09 22:35:42.453' AS DateTime))
GO
INSERT [dbo].[ShoppingBasketItem] ([Id], [Quantity], [CoffeeId], [ShoppingBasketNumber], [DateTimeStamp]) VALUES (44, 1, 2, N'4151a768-c8de-4a4f-9346-25b574881220', CAST(N'2017-03-09 22:37:28.603' AS DateTime))
GO
INSERT [dbo].[ShoppingBasketItem] ([Id], [Quantity], [CoffeeId], [ShoppingBasketNumber], [DateTimeStamp]) VALUES (45, 1, 2, N'eec0fefe-2c62-426a-82b6-460febcf30fc', CAST(N'2017-03-09 22:51:03.703' AS DateTime))
GO
INSERT [dbo].[ShoppingBasketItem] ([Id], [Quantity], [CoffeeId], [ShoppingBasketNumber], [DateTimeStamp]) VALUES (48, 1, 1, N'2905bc72-2c62-4622-a0d8-a1737fc1e463', CAST(N'2017-03-09 23:08:44.810' AS DateTime))
GO
INSERT [dbo].[ShoppingBasketItem] ([Id], [Quantity], [CoffeeId], [ShoppingBasketNumber], [DateTimeStamp]) VALUES (52, 1, 6, N'5df328be-d85e-4d49-a9c6-f500a394dba7', CAST(N'2017-03-10 11:15:38.990' AS DateTime))
GO
INSERT [dbo].[ShoppingBasketItem] ([Id], [Quantity], [CoffeeId], [ShoppingBasketNumber], [DateTimeStamp]) VALUES (53, 1, 1, N'800ae8da-592e-422e-b982-29ae08f03ec5', CAST(N'2017-03-10 11:23:31.230' AS DateTime))
GO
INSERT [dbo].[ShoppingBasketItem] ([Id], [Quantity], [CoffeeId], [ShoppingBasketNumber], [DateTimeStamp]) VALUES (54, 1, 2, N'fa4d58af-1d14-4f19-91d3-c97b1efb34f3', CAST(N'2017-03-10 11:25:15.687' AS DateTime))
GO
INSERT [dbo].[ShoppingBasketItem] ([Id], [Quantity], [CoffeeId], [ShoppingBasketNumber], [DateTimeStamp]) VALUES (55, 2, 6, N'fa4d58af-1d14-4f19-91d3-c97b1efb34f3', CAST(N'2017-03-10 11:26:44.070' AS DateTime))
GO
SET IDENTITY_INSERT [dbo].[ShoppingBasketItem] OFF
GO
ALTER TABLE [dbo].[Coffee]  WITH CHECK ADD  CONSTRAINT [FK_Coffee_CoffeeCategory] FOREIGN KEY([CategoryId])
REFERENCES [dbo].[CoffeeCategory] ([Id])
GO
ALTER TABLE [dbo].[Coffee] CHECK CONSTRAINT [FK_Coffee_CoffeeCategory]
GO
ALTER TABLE [dbo].[OrderDetail]  WITH CHECK ADD  CONSTRAINT [FK_OrderDetail_Coffee] FOREIGN KEY([CoffeeId])
REFERENCES [dbo].[Coffee] ([Id])
GO
ALTER TABLE [dbo].[OrderDetail] CHECK CONSTRAINT [FK_OrderDetail_Coffee]
GO
ALTER TABLE [dbo].[OrderDetail]  WITH CHECK ADD  CONSTRAINT [FK_OrderDetail_Orders] FOREIGN KEY([OrderId])
REFERENCES [dbo].[Order] ([OrderId])
GO
ALTER TABLE [dbo].[OrderDetail] CHECK CONSTRAINT [FK_OrderDetail_Orders]
GO
ALTER TABLE [dbo].[ShoppingBasketItem]  WITH CHECK ADD  CONSTRAINT [FK_ShoppingCartItem_Coffee] FOREIGN KEY([CoffeeId])
REFERENCES [dbo].[Coffee] ([Id])
GO
ALTER TABLE [dbo].[ShoppingBasketItem] CHECK CONSTRAINT [FK_ShoppingCartItem_Coffee]
GO
/****** Object:  StoredProcedure [dbo].[spClearAllItemsFromBasket]    Script Date: 10/03/2017 20:53:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spClearAllItemsFromBasket]
				@shoppingBasketNumber UNIQUEIDENTIFIER
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	DELETE FROM [dbo].[ShoppingBasketItem]
	WHERE ShoppingBasketNumber = @shoppingBasketNumber

END

GO
/****** Object:  StoredProcedure [dbo].[spGetAllCategories]    Script Date: 10/03/2017 20:53:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spGetAllCategories]

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT [Id]
      ,[Name]
      ,[Description]
  FROM [dbo].[CoffeeCategory]

END

GO
/****** Object:  StoredProcedure [dbo].[spGetAllCoffees]    Script Date: 10/03/2017 20:53:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spGetAllCoffees]
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT [Id]
      ,[Name]
      ,[ShortDesc]
      ,[LongDesc]
      ,[Price]
      ,[ImageUrl]
      ,[ImageThumbnailUrl]
      ,[IsCoffeeOfTheWeek]
      ,[InStock]
      ,[CategoryId]
      ,[DateTimeStamp]
  FROM [MyCoffeeShop].[dbo].[Coffee]
  WHERE InStock = 1
  ORDER BY CategoryId DESC
END

GO
/****** Object:  StoredProcedure [dbo].[spGetCofeeById]    Script Date: 10/03/2017 20:53:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spGetCofeeById]
				 @coffeeId INT 
AS
BEGIN
	SELECT [Id]
      ,[Name]
      ,[ShortDesc]
      ,[LongDesc]
      ,[Price]
      ,[ImageUrl]
      ,[ImageThumbnailUrl]
      ,[IsCoffeeOfTheWeek]
      ,[InStock]
      ,[CategoryId]
      ,[DateTimeStamp]
  FROM [MyCoffeeShop].[dbo].[Coffee]
  WHERE [Id] = @coffeeId
  
END

GO
/****** Object:  StoredProcedure [dbo].[spGetCoffeesByCategoryName]    Script Date: 10/03/2017 20:53:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spGetCoffeesByCategoryName]
				@categoryName NVARCHAR(100) NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here

	IF(@categoryName IS NOT NULL)
	BEGIN
		SELECT 
		   C.[Id]
		  ,C.[Name]
		  ,CC.NAME as 'CategoryName'
		  ,[ShortDesc]
		  ,[LongDesc]
		  ,[Price]
		  ,[ImageUrl]
		  ,[ImageThumbnailUrl]
		  ,[IsCoffeeOfTheWeek]
		  ,[InStock]
		  ,[CategoryId]
		  ,[DateTimeStamp]
		FROM dbo.Coffee C
		INNER JOIN dbo.CoffeeCategory CC
		ON CC.ID = C.CATEGORYID
		WHERE CC.NAME = @categoryName
		ORDER BY C.[Id]
	END
	ELSE
	BEGIN
			EXECUTE [dbo].[spGetAllCoffees]
	END
END

GO
/****** Object:  StoredProcedure [dbo].[spGetCoffeesOfTheWeek]    Script Date: 10/03/2017 20:53:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spGetCoffeesOfTheWeek]
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT [Id]
      ,[Name]
      ,[ShortDesc]
      ,[LongDesc]
      ,[Price]
      ,[ImageUrl]
      ,[ImageThumbnailUrl]
      ,[IsCoffeeOfTheWeek]
      ,[InStock]
      ,[CategoryId]
      ,[DateTimeStamp]
  FROM [MyCoffeeShop].[dbo].[Coffee]
  WHERE IsCoffeeOfTheWeek = 1
  AND InStock = 1
  ORDER BY NAME
END

GO
/****** Object:  StoredProcedure [dbo].[spGetShoppingBasketItem]    Script Date: 10/03/2017 20:53:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spGetShoppingBasketItem]
				@coffeeId INT,
				@shoppingBasketNumber UNIQUEIDENTIFIER

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT [Id]
      ,[Quantity]
      ,[CoffeeId]
      ,[ShoppingBasketNumber]
  FROM [MyCoffeeShop].[dbo].[ShoppingBasketItem]
  WHERE CoffeeId = @coffeeId
  AND [ShoppingBasketNumber] = @shoppingBasketNumber

  SELECT [Id]
      ,[Name]
      ,[ShortDesc]
      ,[LongDesc]
      ,[Price]
      ,[ImageThumbnailUrl]
      ,[ImageUrl]
      ,[IsCoffeeOfTheWeek]
      ,[InStock]
      ,[CategoryId]
      ,[DateTimeStamp]
  FROM [MyCoffeeShop].[dbo].[Coffee]
  WHERE ID = @coffeeId

END

GO
/****** Object:  StoredProcedure [dbo].[spGetShoppingBasketItemsForShoppingBasket]    Script Date: 10/03/2017 20:53:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spGetShoppingBasketItemsForShoppingBasket]
				@shoppingBasketNumber UNIQUEIDENTIFIER
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	/****** Script for SelectTopNRows command from SSMS  ******/
SELECT	  
	  C.Id AS 'CoffeeId',
	  C.CategoryId,
	  C.ImageThumbnailUrl,
	  C.ImageUrl,
	  C.IsCoffeeOfTheWeek,
	  C.LongDesc,
	  C.Name,
	  C.ShortDesc,
	  c.Price,
	  c.InStock,
	  SCI.[Id] AS 'ShoppingBasketItem_id'
      ,[Quantity]
      ,[CoffeeId] AS  'Coffee_Id'
      ,[ShoppingBasketNumber]      
  FROM [MyCoffeeShop].[dbo].[ShoppingBasketItem] SCI
  INNER JOIN [dbo].[Coffee] C
  ON C.Id = SCI.CoffeeId
  WHERE [ShoppingBasketNumber] = @ShoppingBasketNumber

END

GO
/****** Object:  StoredProcedure [dbo].[spGetShoppingBasketTotal]    Script Date: 10/03/2017 20:53:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spGetShoppingBasketTotal]
					@shoppingBasketNumber UNIQUEIDENTIFIER
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	
	SELECT SUM((C.[Price] * Quantity))  
	FROM [MyCoffeeShop].[dbo].[ShoppingBasketItem] sci
	INNER JOIN [dbo].[Coffee] C
	ON C.Id = SCI.CoffeeId
	where ShoppingBasketNumber = @shoppingBasketNumber
 


  
END

GO
/****** Object:  StoredProcedure [dbo].[spRemoveShoppingBasketItem]    Script Date: 10/03/2017 20:53:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spRemoveShoppingBasketItem]
				@id		INT
				
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	DELETE FROM [dbo].[ShoppingBasketItem]
	WHERE ID = @id
END

GO
/****** Object:  StoredProcedure [dbo].[spSaveOrder]    Script Date: 10/03/2017 20:53:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spSaveOrder]
			   @OrderId			UNIQUEIDENTIFIER
			  ,@AddressLine1	NVARCHAR(100)
			  ,@AddressLine2	NVARCHAR(100)
			  ,@City			NVARCHAR(50)			  
			  ,@Email			NVARCHAR(50)
			  ,@FirstName		NVARCHAR(50)
			  ,@LastName		NVARCHAR(50)			  
			  ,@OrderTotal		DECIMAL(4,2)
			  ,@PhoneNumber		NVARCHAR(25)
			  ,@County			NVARCHAR(50)
			  ,@PostCode		NVARCHAR(10)



AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	INSERT INTO [Order]
	(
		[OrderId]
       ,[AddressLine1]
       ,[AddressLine2]
       ,[City]      
       ,[Email]
       ,[FirstName]
       ,[LastName]       
       ,[OrderTotal]
       ,[PhoneNumber]
       ,[County]
       ,[PostCode]
	)
	VALUES
	(
		 @OrderId
		,@AddressLine1	
		,@AddressLine2	
		,@City			
		,@Email			
		,@FirstName		
		,@LastName				
		,@OrderTotal		
		,@PhoneNumber		
		,@County			
		,@PostCode		
	)

  
END

GO
/****** Object:  StoredProcedure [dbo].[spSaveOrderDetail]    Script Date: 10/03/2017 20:53:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spSaveOrderDetail]
				   @CoffeeId		INT
				  ,@Quantity		INT
				  ,@OrderId			UNIQUEIDENTIFIER
				  ,@Price			DECIMAL(4,2)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	INSERT INTO [OrderDetail]
	(
	   [CoffeeId]
      ,[Quantity]
      ,[OrderId]
      ,[Price]
	)
	VALUES
	(
		 @CoffeeId	
		,@Quantity	
		,@OrderId		
		,@Price		
	)
END

GO
/****** Object:  StoredProcedure [dbo].[spSaveShoppingBasketItem]    Script Date: 10/03/2017 20:53:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spSaveShoppingBasketItem]
			@coffeeId INT,
			@quantity INT,
			@shoppingBasketNumber uniqueidentifier
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	INSERT INTO [dbo].[ShoppingBasketItem]
	(
		[Quantity]
       ,[CoffeeId]
       ,[ShoppingBasketNumber]
	)
	VALUES
	(@quantity, @coffeeId, @shoppingBasketNumber)
END

GO
/****** Object:  StoredProcedure [dbo].[spUpdateShoppingBasketItem]    Script Date: 10/03/2017 20:53:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spUpdateShoppingBasketItem]
				 @id					INT
				,@quantity				INT
				,@coffeeId				INT
				,@shoppingBasketNumber	UNIQUEIDENTIFIER
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	UPDATE [dbo].[ShoppingBasketItem]
	SET Quantity = @quantity
	WHERE Id = @id
	AND ShoppingBasketNumber = @shoppingBasketNumber 
	AND CoffeeId = @coffeeId
END

GO
USE [master]
GO
ALTER DATABASE [MyCoffeeShop] SET  READ_WRITE 
GO

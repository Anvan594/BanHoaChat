USE [master]
GO
/****** Object:  Database [BanHoaChatDBv3]    Script Date: 7/10/2025 4:55:48 PM ******/
CREATE DATABASE [BanHoaChatDBv3]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'BanHoaChatDBv3', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\BanHoaChatDBv3.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'BanHoaChatDBv3_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\BanHoaChatDBv3_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [BanHoaChatDBv3] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [BanHoaChatDBv3].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [BanHoaChatDBv3] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [BanHoaChatDBv3] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [BanHoaChatDBv3] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [BanHoaChatDBv3] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [BanHoaChatDBv3] SET ARITHABORT OFF 
GO
ALTER DATABASE [BanHoaChatDBv3] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [BanHoaChatDBv3] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [BanHoaChatDBv3] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [BanHoaChatDBv3] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [BanHoaChatDBv3] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [BanHoaChatDBv3] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [BanHoaChatDBv3] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [BanHoaChatDBv3] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [BanHoaChatDBv3] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [BanHoaChatDBv3] SET  ENABLE_BROKER 
GO
ALTER DATABASE [BanHoaChatDBv3] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [BanHoaChatDBv3] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [BanHoaChatDBv3] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [BanHoaChatDBv3] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [BanHoaChatDBv3] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [BanHoaChatDBv3] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [BanHoaChatDBv3] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [BanHoaChatDBv3] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [BanHoaChatDBv3] SET  MULTI_USER 
GO
ALTER DATABASE [BanHoaChatDBv3] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [BanHoaChatDBv3] SET DB_CHAINING OFF 
GO
ALTER DATABASE [BanHoaChatDBv3] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [BanHoaChatDBv3] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [BanHoaChatDBv3] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [BanHoaChatDBv3] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [BanHoaChatDBv3] SET QUERY_STORE = ON
GO
ALTER DATABASE [BanHoaChatDBv3] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [BanHoaChatDBv3]
GO
/****** Object:  Table [dbo].[__EFMigrationsHistory]    Script Date: 7/10/2025 4:55:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[__EFMigrationsHistory](
	[MigrationId] [nvarchar](150) NOT NULL,
	[ProductVersion] [nvarchar](32) NOT NULL,
 CONSTRAINT [PK___EFMigrationsHistory] PRIMARY KEY CLUSTERED 
(
	[MigrationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Cart]    Script Date: 7/10/2025 4:55:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Cart](
	[cart_id] [int] IDENTITY(1,1) NOT NULL,
	[user_id] [int] NULL,
	[created_at] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[cart_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Cart_Items]    Script Date: 7/10/2025 4:55:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Cart_Items](
	[cart_item_id] [int] IDENTITY(1,1) NOT NULL,
	[cart_id] [int] NULL,
	[product_id] [int] NULL,
	[quantity] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[cart_item_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Categories]    Script Date: 7/10/2025 4:55:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Categories](
	[category_id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](100) NOT NULL,
	[description] [nvarchar](max) NULL,
	[parent_id] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[category_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Order_Items]    Script Date: 7/10/2025 4:55:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Order_Items](
	[order_item_id] [int] IDENTITY(1,1) NOT NULL,
	[order_id] [int] NULL,
	[product_id] [int] NULL,
	[quantity] [int] NOT NULL,
	[unit_price] [decimal](10, 2) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[order_item_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Orders]    Script Date: 7/10/2025 4:55:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Orders](
	[order_id] [int] IDENTITY(1,1) NOT NULL,
	[user_id] [int] NULL,
	[total_amount] [decimal](10, 2) NOT NULL,
	[status] [nvarchar](20) NULL,
	[shipping_address] [nvarchar](max) NULL,
	[created_at] [datetime] NULL,
	[updated_at] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[order_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Products]    Script Date: 7/10/2025 4:55:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Products](
	[product_id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](255) NOT NULL,
	[description] [nvarchar](max) NULL,
	[price] [decimal](10, 2) NOT NULL,
	[stock_quantity] [int] NULL,
	[category_id] [int] NULL,
	[image_url] [nvarchar](255) NULL,
	[created_at] [datetime] NULL,
	[updated_at] [datetime] NULL,
	[status] [bit] NULL,
	[StatusPrice] [bit] NULL,
	[ViewCount] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[product_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Reviews]    Script Date: 7/10/2025 4:55:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Reviews](
	[review_id] [int] IDENTITY(1,1) NOT NULL,
	[user_id] [int] NULL,
	[product_id] [int] NULL,
	[rating] [int] NULL,
	[comment] [nvarchar](max) NULL,
	[created_at] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[review_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 7/10/2025 4:55:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[user_id] [int] IDENTITY(1,1) NOT NULL,
	[username] [nvarchar](50) NOT NULL,
	[password] [nvarchar](255) NOT NULL,
	[email] [nvarchar](100) NOT NULL,
	[full_name] [nvarchar](100) NULL,
	[phone] [nvarchar](15) NULL,
	[address] [nvarchar](max) NULL,
	[role] [nvarchar](20) NULL,
	[created_at] [datetime] NULL,
	[updated_at] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[user_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Cart] ON 

INSERT [dbo].[Cart] ([cart_id], [user_id], [created_at]) VALUES (1, 1, CAST(N'2025-07-10T15:01:12.273' AS DateTime))
INSERT [dbo].[Cart] ([cart_id], [user_id], [created_at]) VALUES (2, 11, CAST(N'2025-07-10T15:12:51.157' AS DateTime))
INSERT [dbo].[Cart] ([cart_id], [user_id], [created_at]) VALUES (3, 24, CAST(N'2025-07-10T15:36:51.910' AS DateTime))
SET IDENTITY_INSERT [dbo].[Cart] OFF
GO
SET IDENTITY_INSERT [dbo].[Cart_Items] ON 

INSERT [dbo].[Cart_Items] ([cart_item_id], [cart_id], [product_id], [quantity]) VALUES (1, 1, 4, 1)
INSERT [dbo].[Cart_Items] ([cart_item_id], [cart_id], [product_id], [quantity]) VALUES (2, 2, 3, 4)
INSERT [dbo].[Cart_Items] ([cart_item_id], [cart_id], [product_id], [quantity]) VALUES (3, 2, 4, 1)
INSERT [dbo].[Cart_Items] ([cart_item_id], [cart_id], [product_id], [quantity]) VALUES (23, 3, 8, 4)
INSERT [dbo].[Cart_Items] ([cart_item_id], [cart_id], [product_id], [quantity]) VALUES (24, 3, 3, 3)
SET IDENTITY_INSERT [dbo].[Cart_Items] OFF
GO
SET IDENTITY_INSERT [dbo].[Categories] ON 

INSERT [dbo].[Categories] ([category_id], [name], [description], [parent_id]) VALUES (1, N'Axit', NULL, NULL)
INSERT [dbo].[Categories] ([category_id], [name], [description], [parent_id]) VALUES (2, N'Bazơ', NULL, NULL)
SET IDENTITY_INSERT [dbo].[Categories] OFF
GO
SET IDENTITY_INSERT [dbo].[Products] ON 

INSERT [dbo].[Products] ([product_id], [name], [description], [price], [stock_quantity], [category_id], [image_url], [created_at], [updated_at], [status], [StatusPrice], [ViewCount]) VALUES (3, N'Sản Phẩm 13', NULL, CAST(900000.00 AS Decimal(10, 2)), 10, 1, N'/Images/products/70068fbe-cc9a-44c9-bf12-7a07e72324d9.png', CAST(N'2025-07-08T16:55:32.287' AS DateTime), CAST(N'2025-07-09T23:21:36.550' AS DateTime), 1, 1, 212)
INSERT [dbo].[Products] ([product_id], [name], [description], [price], [stock_quantity], [category_id], [image_url], [created_at], [updated_at], [status], [StatusPrice], [ViewCount]) VALUES (4, N'Sản Phẩm 1', NULL, CAST(90000.00 AS Decimal(10, 2)), 10, 1, N'/Images/products/94d7db37-08fe-4bb4-860c-af1a78920fda.jpg', CAST(N'2025-07-09T18:30:08.843' AS DateTime), CAST(N'2025-07-09T18:30:08.843' AS DateTime), 1, 0, 161)
INSERT [dbo].[Products] ([product_id], [name], [description], [price], [stock_quantity], [category_id], [image_url], [created_at], [updated_at], [status], [StatusPrice], [ViewCount]) VALUES (5, N'Sản Phẩm 11', NULL, CAST(90000.00 AS Decimal(10, 2)), 10, 1, N'/Images/products/a2b8190f-c619-44e4-ac97-6345691ce286.png', CAST(N'2025-07-09T18:30:20.380' AS DateTime), CAST(N'2025-07-09T18:30:20.380' AS DateTime), 1, 0, 221)
INSERT [dbo].[Products] ([product_id], [name], [description], [price], [stock_quantity], [category_id], [image_url], [created_at], [updated_at], [status], [StatusPrice], [ViewCount]) VALUES (6, N'Sản Phẩm 1', NULL, CAST(10.00 AS Decimal(10, 2)), 10, 1, N'/Images/products/e0bb5991-8532-4ed8-81b3-672654a6dff8.png', CAST(N'2025-07-09T18:30:31.983' AS DateTime), CAST(N'2025-07-09T23:12:49.260' AS DateTime), 1, 1, 131)
INSERT [dbo].[Products] ([product_id], [name], [description], [price], [stock_quantity], [category_id], [image_url], [created_at], [updated_at], [status], [StatusPrice], [ViewCount]) VALUES (7, N'sp2', NULL, CAST(100000.00 AS Decimal(10, 2)), 10, 1, N'/Images/products/6f20c0bb-c509-41b1-938d-a1bac1b2bf06.png', CAST(N'2025-07-09T18:52:08.753' AS DateTime), CAST(N'2025-07-09T23:23:14.210' AS DateTime), 1, 0, 116)
INSERT [dbo].[Products] ([product_id], [name], [description], [price], [stock_quantity], [category_id], [image_url], [created_at], [updated_at], [status], [StatusPrice], [ViewCount]) VALUES (8, N'Sản Phẩm 12', NULL, CAST(90000.00 AS Decimal(10, 2)), 12, 1, N'/Images/products/66ada44b-4edc-4709-aff2-7fad3b921e59.png', CAST(N'2025-07-09T18:55:16.007' AS DateTime), CAST(N'2025-07-09T18:55:16.007' AS DateTime), 1, 1, 114)
INSERT [dbo].[Products] ([product_id], [name], [description], [price], [stock_quantity], [category_id], [image_url], [created_at], [updated_at], [status], [StatusPrice], [ViewCount]) VALUES (9, N'Sản Phẩm 12', NULL, CAST(1000.00 AS Decimal(10, 2)), 1, 1, N'/Images/products/81973368-d539-4079-a890-2f87360f80b8.jpg', CAST(N'2025-07-09T19:26:07.453' AS DateTime), CAST(N'2025-07-09T23:23:30.680' AS DateTime), 1, 1, 19)
INSERT [dbo].[Products] ([product_id], [name], [description], [price], [stock_quantity], [category_id], [image_url], [created_at], [updated_at], [status], [StatusPrice], [ViewCount]) VALUES (10, N'Sản Phẩm 13', NULL, CAST(10.00 AS Decimal(10, 2)), 10, 1, N'/Images/products/daa8438c-0729-4573-ae3a-280404bf9f4b.png', CAST(N'2025-07-09T19:26:17.820' AS DateTime), CAST(N'2025-07-09T19:26:17.820' AS DateTime), 1, 1, 218)
INSERT [dbo].[Products] ([product_id], [name], [description], [price], [stock_quantity], [category_id], [image_url], [created_at], [updated_at], [status], [StatusPrice], [ViewCount]) VALUES (11, N'1000', NULL, CAST(0.00 AS Decimal(10, 2)), 11, 1, N'/Images/products/2de477fb-a919-49c9-91b2-7bf33c5535b2.png', CAST(N'2025-07-09T19:26:30.017' AS DateTime), CAST(N'2025-07-09T19:26:30.017' AS DateTime), 1, 1, 208)
SET IDENTITY_INSERT [dbo].[Products] OFF
GO
SET IDENTITY_INSERT [dbo].[Users] ON 

INSERT [dbo].[Users] ([user_id], [username], [password], [email], [full_name], [phone], [address], [role], [created_at], [updated_at]) VALUES (1, N'admin', N'123456', N'admin@gmail.com', NULL, NULL, NULL, N'Admin', CAST(N'2025-07-08T11:26:18.440' AS DateTime), CAST(N'2025-07-08T11:26:18.440' AS DateTime))
INSERT [dbo].[Users] ([user_id], [username], [password], [email], [full_name], [phone], [address], [role], [created_at], [updated_at]) VALUES (4, N'', N'', N'', NULL, NULL, NULL, N'', CAST(N'2025-07-08T11:29:01.750' AS DateTime), CAST(N'2025-07-08T11:29:01.750' AS DateTime))
INSERT [dbo].[Users] ([user_id], [username], [password], [email], [full_name], [phone], [address], [role], [created_at], [updated_at]) VALUES (7, N'Admin1', N'123456', N'admin1@gmail.com', N'Phạm Minh Tuấn', N'0123456789', N'Hưng Yên', N'Admin', CAST(N'2025-07-08T11:44:12.307' AS DateTime), CAST(N'2025-07-08T11:44:12.533' AS DateTime))
INSERT [dbo].[Users] ([user_id], [username], [password], [email], [full_name], [phone], [address], [role], [created_at], [updated_at]) VALUES (9, N'Admin2', N'123456', N'admin2@gmail.com', N'Phạm Minh Tuấn', N'0123456789', N'Hưng Yên', N'Admin', CAST(N'2025-07-08T11:45:09.187' AS DateTime), CAST(N'2025-07-08T11:45:09.190' AS DateTime))
INSERT [dbo].[Users] ([user_id], [username], [password], [email], [full_name], [phone], [address], [role], [created_at], [updated_at]) VALUES (10, N'Admin3', N'123456', N'admin3@gmail.com', N'Phạm Minh Tuấn', N'0123456789', N'Hưng Yên', N'Admin', CAST(N'2025-07-08T11:47:23.070' AS DateTime), CAST(N'2025-07-08T11:47:23.170' AS DateTime))
INSERT [dbo].[Users] ([user_id], [username], [password], [email], [full_name], [phone], [address], [role], [created_at], [updated_at]) VALUES (11, N'Khách Vãng lai', N'1', N'user1007255jid@gmail.com', NULL, NULL, NULL, N'Custumer', CAST(N'2025-07-10T15:12:51.087' AS DateTime), CAST(N'2025-07-10T15:12:51.087' AS DateTime))
INSERT [dbo].[Users] ([user_id], [username], [password], [email], [full_name], [phone], [address], [role], [created_at], [updated_at]) VALUES (24, N'Khách_1007253833', N'1', N'user100725urcz@gmail.com', NULL, NULL, NULL, N'Customer', CAST(N'2025-07-10T15:36:51.850' AS DateTime), CAST(N'2025-07-10T15:36:51.850' AS DateTime))
SET IDENTITY_INSERT [dbo].[Users] OFF
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Users__AB6E6164BEB0E68C]    Script Date: 7/10/2025 4:55:48 PM ******/
ALTER TABLE [dbo].[Users] ADD UNIQUE NONCLUSTERED 
(
	[email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Users__F3DBC57220A522B8]    Script Date: 7/10/2025 4:55:48 PM ******/
ALTER TABLE [dbo].[Users] ADD UNIQUE NONCLUSTERED 
(
	[username] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Cart] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[Orders] ADD  DEFAULT ('Pending') FOR [status]
GO
ALTER TABLE [dbo].[Orders] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[Orders] ADD  DEFAULT (getdate()) FOR [updated_at]
GO
ALTER TABLE [dbo].[Products] ADD  DEFAULT ((0)) FOR [stock_quantity]
GO
ALTER TABLE [dbo].[Products] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[Products] ADD  DEFAULT (getdate()) FOR [updated_at]
GO
ALTER TABLE [dbo].[Reviews] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[Users] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[Users] ADD  DEFAULT (getdate()) FOR [updated_at]
GO
ALTER TABLE [dbo].[Cart]  WITH CHECK ADD  CONSTRAINT [FK_Cart_Users] FOREIGN KEY([user_id])
REFERENCES [dbo].[Users] ([user_id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Cart] CHECK CONSTRAINT [FK_Cart_Users]
GO
ALTER TABLE [dbo].[Cart_Items]  WITH CHECK ADD  CONSTRAINT [FK_CartItems_Cart] FOREIGN KEY([cart_id])
REFERENCES [dbo].[Cart] ([cart_id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Cart_Items] CHECK CONSTRAINT [FK_CartItems_Cart]
GO
ALTER TABLE [dbo].[Cart_Items]  WITH CHECK ADD  CONSTRAINT [FK_CartItems_Products] FOREIGN KEY([product_id])
REFERENCES [dbo].[Products] ([product_id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Cart_Items] CHECK CONSTRAINT [FK_CartItems_Products]
GO
ALTER TABLE [dbo].[Order_Items]  WITH CHECK ADD  CONSTRAINT [FK_OrderItems_Orders] FOREIGN KEY([order_id])
REFERENCES [dbo].[Orders] ([order_id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Order_Items] CHECK CONSTRAINT [FK_OrderItems_Orders]
GO
ALTER TABLE [dbo].[Order_Items]  WITH CHECK ADD  CONSTRAINT [FK_OrderItems_Products] FOREIGN KEY([product_id])
REFERENCES [dbo].[Products] ([product_id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Order_Items] CHECK CONSTRAINT [FK_OrderItems_Products]
GO
ALTER TABLE [dbo].[Orders]  WITH CHECK ADD  CONSTRAINT [FK_Orders_Users] FOREIGN KEY([user_id])
REFERENCES [dbo].[Users] ([user_id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Orders] CHECK CONSTRAINT [FK_Orders_Users]
GO
ALTER TABLE [dbo].[Products]  WITH CHECK ADD  CONSTRAINT [FK_Products_Categories] FOREIGN KEY([category_id])
REFERENCES [dbo].[Categories] ([category_id])
ON DELETE SET NULL
GO
ALTER TABLE [dbo].[Products] CHECK CONSTRAINT [FK_Products_Categories]
GO
ALTER TABLE [dbo].[Reviews]  WITH CHECK ADD  CONSTRAINT [FK_Reviews_Products] FOREIGN KEY([product_id])
REFERENCES [dbo].[Products] ([product_id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Reviews] CHECK CONSTRAINT [FK_Reviews_Products]
GO
ALTER TABLE [dbo].[Reviews]  WITH CHECK ADD  CONSTRAINT [FK_Reviews_Users] FOREIGN KEY([user_id])
REFERENCES [dbo].[Users] ([user_id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Reviews] CHECK CONSTRAINT [FK_Reviews_Users]
GO
ALTER TABLE [dbo].[Reviews]  WITH CHECK ADD CHECK  (([rating]>=(1) AND [rating]<=(5)))
GO
USE [master]
GO
ALTER DATABASE [BanHoaChatDBv3] SET  READ_WRITE 
GO

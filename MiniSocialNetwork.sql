USE [master]
GO
/****** Object:  Database [Mini_Social_Network]    Script Date: 1/25/2021 8:25:34 PM ******/
CREATE DATABASE [Mini_Social_Network]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Mini_Social_Network', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\Mini_Social_Network.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Mini_Social_Network_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\Mini_Social_Network_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [Mini_Social_Network] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Mini_Social_Network].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Mini_Social_Network] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Mini_Social_Network] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Mini_Social_Network] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Mini_Social_Network] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Mini_Social_Network] SET ARITHABORT OFF 
GO
ALTER DATABASE [Mini_Social_Network] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [Mini_Social_Network] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Mini_Social_Network] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Mini_Social_Network] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Mini_Social_Network] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Mini_Social_Network] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Mini_Social_Network] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Mini_Social_Network] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Mini_Social_Network] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Mini_Social_Network] SET  ENABLE_BROKER 
GO
ALTER DATABASE [Mini_Social_Network] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Mini_Social_Network] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Mini_Social_Network] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Mini_Social_Network] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Mini_Social_Network] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Mini_Social_Network] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Mini_Social_Network] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Mini_Social_Network] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [Mini_Social_Network] SET  MULTI_USER 
GO
ALTER DATABASE [Mini_Social_Network] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Mini_Social_Network] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Mini_Social_Network] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Mini_Social_Network] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Mini_Social_Network] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [Mini_Social_Network] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [Mini_Social_Network] SET QUERY_STORE = OFF
GO
USE [Mini_Social_Network]
GO
/****** Object:  Table [dbo].[tbl_Articles]    Script Date: 1/25/2021 8:25:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_Articles](
	[PostID] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](50) NULL,
	[Description] [nvarchar](max) NULL,
	[Image] [varchar](50) NULL,
	[Date] [varchar](50) NULL,
	[Email] [varchar](50) NULL,
	[Status] [varchar](50) NULL,
 CONSTRAINT [PK_tbl_Articles] PRIMARY KEY CLUSTERED 
(
	[PostID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_Comments]    Script Date: 1/25/2021 8:25:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_Comments](
	[CommentID] [int] IDENTITY(1,1) NOT NULL,
	[PostID] [int] NULL,
	[Email] [varchar](50) NULL,
	[Content] [nvarchar](max) NULL,
	[Date] [varchar](50) NULL,
	[Status] [varchar](50) NULL,
 CONSTRAINT [PK_tbl_Comments] PRIMARY KEY CLUSTERED 
(
	[CommentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_Emotion]    Script Date: 1/25/2021 8:25:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_Emotion](
	[EmotionID] [int] IDENTITY(1,1) NOT NULL,
	[PostID] [int] NOT NULL,
	[Email] [varchar](50) NULL,
	[Like] [int] NULL,
	[Dislike] [int] NULL,
	[Date] [varchar](50) NULL,
 CONSTRAINT [PK_tbl_Emotion] PRIMARY KEY CLUSTERED 
(
	[EmotionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_Notify]    Script Date: 1/25/2021 8:25:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_Notify](
	[NotifyID] [int] IDENTITY(1,1) NOT NULL,
	[PostID] [int] NOT NULL,
	[Email] [varchar](50) NULL,
	[Date] [varchar](50) NULL,
	[Type] [varchar](50) NULL,
 CONSTRAINT [PK_tbl_Notify] PRIMARY KEY CLUSTERED 
(
	[NotifyID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_Users]    Script Date: 1/25/2021 8:25:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_Users](
	[Email] [varchar](50) NOT NULL,
	[Name] [nvarchar](50) NULL,
	[Password] [varchar](max) NULL,
	[Role] [varchar](10) NULL,
	[Status] [varchar](10) NULL,
	[Code] [nvarchar](6) NULL,
 CONSTRAINT [PK__Accounts__A9D105359D8366C4] PRIMARY KEY CLUSTERED 
(
	[Email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[tbl_Articles] ON 

INSERT [dbo].[tbl_Articles] ([PostID], [Title], [Description], [Image], [Date], [Email], [Status]) VALUES (10, N'Coffee', N'Nigaiii', N'79ddd6bed3bd429d8f2eb054ee4c2911dc808564c7.jpg', N'1601202041414', N'caytamto@gmail.com', N'Active')
INSERT [dbo].[tbl_Articles] ([PostID], [Title], [Description], [Image], [Date], [Email], [Status]) VALUES (15, N'CHi Pheo', N'nay an gi', N'acff8298870641c8a30e9e6359c5286427b0994fb4.jpg', N'1601280872012', N'caytamto@gmail.com', N'Active')
INSERT [dbo].[tbl_Articles] ([PostID], [Title], [Description], [Image], [Date], [Email], [Status]) VALUES (16, N'Boc phot', N'Drama QK7', NULL, N'1601281106335', N'share@gmail.com', N'Deleted')
INSERT [dbo].[tbl_Articles] ([PostID], [Title], [Description], [Image], [Date], [Email], [Status]) VALUES (17, N'ghjiop[', N'dfghj', NULL, N'1601281128675', N'knight@gmail.com', N'Active')
INSERT [dbo].[tbl_Articles] ([PostID], [Title], [Description], [Image], [Date], [Email], [Status]) VALUES (19, N'adsfsadfsdfsdfsdf', N'aaaaaaaaaaaaaaaaa', NULL, N'1601281421938', N'knight@gmail.com', N'Active')
INSERT [dbo].[tbl_Articles] ([PostID], [Title], [Description], [Image], [Date], [Email], [Status]) VALUES (20, N'aaaaaaa', N'aaaaaaaaaaaa', NULL, N'1601281508593', N'knight@gmail.com', N'Active')
INSERT [dbo].[tbl_Articles] ([PostID], [Title], [Description], [Image], [Date], [Email], [Status]) VALUES (21, N'Mew mew', N'Ngaoo', N'0873b53dc66041dfabd61b08daa45c23f25194e4c4.jpg', N'1607482310883', N'knight@gmail.com', N'Active')
INSERT [dbo].[tbl_Articles] ([PostID], [Title], [Description], [Image], [Date], [Email], [Status]) VALUES (22, N'Game', N'game game', N'31857233f79f4538ae5d20a68f56aa831a3a0ec4b6.png', N'1607485535014', N'knight@gmail.com', N'Active')
INSERT [dbo].[tbl_Articles] ([PostID], [Title], [Description], [Image], [Date], [Email], [Status]) VALUES (23, N'FPT''s Student', N'Prisoner', N'38007b45503843e1afd4e1356dea515fa5b9f44006.png', N'1607488937351', N'share@gmail.com', N'Deleted')
INSERT [dbo].[tbl_Articles] ([PostID], [Title], [Description], [Image], [Date], [Email], [Status]) VALUES (24, N'Miyavi', N'Visual Kei', N'acff8298870641c8a30e9e6359c5286427b0994fb4.jpg', N'1607535912028', N'share@gmail.com', N'Deleted')
INSERT [dbo].[tbl_Articles] ([PostID], [Title], [Description], [Image], [Date], [Email], [Status]) VALUES (25, N'Shiba ', N'Shiba ngaooo', N'f34e7d50b2a945548f0d03cc9d328f659984f29ec8.jpg', N'1607536009740', N'knight@gmail.com', N'Active')
INSERT [dbo].[tbl_Articles] ([PostID], [Title], [Description], [Image], [Date], [Email], [Status]) VALUES (26, N'Quan com tro', N'Cau luong', N'0_dIcV1kYv6zsZ3oM_.jpg', N'1607759293073', N'kazuocyrus@gmail.com', N'Active')
INSERT [dbo].[tbl_Articles] ([PostID], [Title], [Description], [Image], [Date], [Email], [Status]) VALUES (30, N'Hello', N'Hello World', NULL, N'1608086026979', N'share@gmail.com', N'Active')
INSERT [dbo].[tbl_Articles] ([PostID], [Title], [Description], [Image], [Date], [Email], [Status]) VALUES (31, N'Hello', N'Hello World', NULL, N'1608086125008', N'share@gmail.com', N'Active')
INSERT [dbo].[tbl_Articles] ([PostID], [Title], [Description], [Image], [Date], [Email], [Status]) VALUES (32, N'QK7', N'a', N'89aeb239be7a57240e6b.jpg', N'1608086154262', N'share@gmail.com', N'Active')
INSERT [dbo].[tbl_Articles] ([PostID], [Title], [Description], [Image], [Date], [Email], [Status]) VALUES (33, N'Again', N'One more time', N'photo-1562577309-4932fdd64cd1.png', N'1608086221779', N'share@gmail.com', N'Active')
INSERT [dbo].[tbl_Articles] ([PostID], [Title], [Description], [Image], [Date], [Email], [Status]) VALUES (34, N'hello world', N'aaaaaaaaa', N'e458b908115b470a9f47318d5cb5c574d0bf559126.jpg', N'1608087388206', N'knight@gmail.com', N'Active')
INSERT [dbo].[tbl_Articles] ([PostID], [Title], [Description], [Image], [Date], [Email], [Status]) VALUES (35, N'Hello nhat linh', N'What''s the weather like now ?', N'0a2728f9997e45cb9ed7cf45508b632724d6fd023c.jpg', N'1609425002750', N'lienkhuong72@gmail.com', N'Active')
INSERT [dbo].[tbl_Articles] ([PostID], [Title], [Description], [Image], [Date], [Email], [Status]) VALUES (36, N'SALE 20 ', N'sale do nhen', N'f3f1724c5cbb40cb9916e0f4460c69e89282f72422.png', N'1611311751473', N'knight@gmail.com', N'Active')
INSERT [dbo].[tbl_Articles] ([PostID], [Title], [Description], [Image], [Date], [Email], [Status]) VALUES (37, N'Matcha', N'Tra Xanh thanh loc co the', N'4149513a37864f8cb8217a08c8fc0269fbe912cbcc.jpg', N'1611501333208', N'gianhse63203@fpt.edu.vn', N'Active')
SET IDENTITY_INSERT [dbo].[tbl_Articles] OFF
GO
SET IDENTITY_INSERT [dbo].[tbl_Comments] ON 

INSERT [dbo].[tbl_Comments] ([CommentID], [PostID], [Email], [Content], [Date], [Status]) VALUES (2, 10, N'ahihi@gmail.com', N'Ã¡df', N'1601441657572', N'Active')
INSERT [dbo].[tbl_Comments] ([CommentID], [PostID], [Email], [Content], [Date], [Status]) VALUES (3, 15, N'ahihi@gmail.com', N'Toi nay quay de', N'1601458917488', N'Active')
INSERT [dbo].[tbl_Comments] ([CommentID], [PostID], [Email], [Content], [Date], [Status]) VALUES (5, 22, N'share@gmail.com', N'táº¡m á»?n', N'1607487115440', N'Active')
INSERT [dbo].[tbl_Comments] ([CommentID], [PostID], [Email], [Content], [Date], [Status]) VALUES (15, 21, N'kazuocyrus@gmail.com', N'hello', N'1607613585583', N'Active')
INSERT [dbo].[tbl_Comments] ([CommentID], [PostID], [Email], [Content], [Date], [Status]) VALUES (16, 15, N'kazuocyrus@gmail.com', N'Life is tough', N'1607761285389', N'Active')
INSERT [dbo].[tbl_Comments] ([CommentID], [PostID], [Email], [Content], [Date], [Status]) VALUES (17, 15, N'share@gmail.com', N'Cy nÃ¨
Cy nÃ¨
Cy nÃ¨', N'1608040421418', N'Active')
INSERT [dbo].[tbl_Comments] ([CommentID], [PostID], [Email], [Content], [Date], [Status]) VALUES (19, 10, N'knight@gmail.com', N'ok', N'1608046784982', N'Active')
INSERT [dbo].[tbl_Comments] ([CommentID], [PostID], [Email], [Content], [Date], [Status]) VALUES (20, 10, N'knight@gmail.com', N'ok', N'1608046983658', N'Active')
INSERT [dbo].[tbl_Comments] ([CommentID], [PostID], [Email], [Content], [Date], [Status]) VALUES (24, 22, N'knight@gmail.com', N'Life is game', N'1608371910528', N'Active')
INSERT [dbo].[tbl_Comments] ([CommentID], [PostID], [Email], [Content], [Date], [Status]) VALUES (26, 35, N'kazuocyrus@gmail.com', N'Today is a bad day! :v', N'1609428388514', N'Active')
INSERT [dbo].[tbl_Comments] ([CommentID], [PostID], [Email], [Content], [Date], [Status]) VALUES (28, 37, N'gianhse63203@fpt.edu.vn', N'Ngon ma. Like ho cai coi', N'1611501349909', N'Active')
SET IDENTITY_INSERT [dbo].[tbl_Comments] OFF
GO
SET IDENTITY_INSERT [dbo].[tbl_Emotion] ON 

INSERT [dbo].[tbl_Emotion] ([EmotionID], [PostID], [Email], [Like], [Dislike], [Date]) VALUES (5, 21, N'knight@gmail.com', 1, 0, N'1607482737476')
INSERT [dbo].[tbl_Emotion] ([EmotionID], [PostID], [Email], [Like], [Dislike], [Date]) VALUES (6, 10, N'knight@gmail.com', 0, 1, N'1607485402112')
INSERT [dbo].[tbl_Emotion] ([EmotionID], [PostID], [Email], [Like], [Dislike], [Date]) VALUES (7, 22, N'share@gmail.com', 1, 0, N'1607487275856')
INSERT [dbo].[tbl_Emotion] ([EmotionID], [PostID], [Email], [Like], [Dislike], [Date]) VALUES (8, 21, N'kazuocyrus@gmail.com', 0, 1, N'1607539220515')
INSERT [dbo].[tbl_Emotion] ([EmotionID], [PostID], [Email], [Like], [Dislike], [Date]) VALUES (9, 10, N'kazuocyrus@gmail.com', 0, 1, N'1607614195471')
INSERT [dbo].[tbl_Emotion] ([EmotionID], [PostID], [Email], [Like], [Dislike], [Date]) VALUES (10, 15, N'kazuocyrus@gmail.com', 0, 1, N'1607761263115')
INSERT [dbo].[tbl_Emotion] ([EmotionID], [PostID], [Email], [Like], [Dislike], [Date]) VALUES (11, 15, N'share@gmail.com', 0, 1, N'1607762018455')
INSERT [dbo].[tbl_Emotion] ([EmotionID], [PostID], [Email], [Like], [Dislike], [Date]) VALUES (12, 17, N'knight@gmail.com', 1, 0, N'1608000633079')
INSERT [dbo].[tbl_Emotion] ([EmotionID], [PostID], [Email], [Like], [Dislike], [Date]) VALUES (13, 22, N'knight@gmail.com', 1, 0, N'1608000737483')
INSERT [dbo].[tbl_Emotion] ([EmotionID], [PostID], [Email], [Like], [Dislike], [Date]) VALUES (14, 19, N'share@gmail.com', 1, 0, N'1608040027025')
INSERT [dbo].[tbl_Emotion] ([EmotionID], [PostID], [Email], [Like], [Dislike], [Date]) VALUES (15, 23, N'share@gmail.com', 1, 0, N'1608085934341')
INSERT [dbo].[tbl_Emotion] ([EmotionID], [PostID], [Email], [Like], [Dislike], [Date]) VALUES (16, 34, N'knight@gmail.com', 0, 1, N'1608087400008')
INSERT [dbo].[tbl_Emotion] ([EmotionID], [PostID], [Email], [Like], [Dislike], [Date]) VALUES (17, 35, N'lienkhuong72@gmail.com', 0, 1, N'1609425058879')
INSERT [dbo].[tbl_Emotion] ([EmotionID], [PostID], [Email], [Like], [Dislike], [Date]) VALUES (18, 35, N'kazuocyrus@gmail.com', 0, 1, N'1609425421146')
INSERT [dbo].[tbl_Emotion] ([EmotionID], [PostID], [Email], [Like], [Dislike], [Date]) VALUES (19, 32, N'knight@gmail.com', 1, 0, N'1611501081571')
INSERT [dbo].[tbl_Emotion] ([EmotionID], [PostID], [Email], [Like], [Dislike], [Date]) VALUES (20, 37, N'gianhse63203@fpt.edu.vn', 1, 0, N'1611501352626')
SET IDENTITY_INSERT [dbo].[tbl_Emotion] OFF
GO
SET IDENTITY_INSERT [dbo].[tbl_Notify] ON 

INSERT [dbo].[tbl_Notify] ([NotifyID], [PostID], [Email], [Date], [Type]) VALUES (1, 21, N'knight@gmail.com', N'1607613585596', N'comment')
INSERT [dbo].[tbl_Notify] ([NotifyID], [PostID], [Email], [Date], [Type]) VALUES (2, 21, N'knight@gmail.com', N'1607613634045', N'like')
INSERT [dbo].[tbl_Notify] ([NotifyID], [PostID], [Email], [Date], [Type]) VALUES (3, 21, N'knight@gmail.com', N'1607613641999', N'dislike')
INSERT [dbo].[tbl_Notify] ([NotifyID], [PostID], [Email], [Date], [Type]) VALUES (4, 10, N'kazuocyrus@gmail.com', N'1607614195471', N'dislike')
INSERT [dbo].[tbl_Notify] ([NotifyID], [PostID], [Email], [Date], [Type]) VALUES (5, 15, N'kazuocyrus@gmail.com', N'1607761263114', N'like')
INSERT [dbo].[tbl_Notify] ([NotifyID], [PostID], [Email], [Date], [Type]) VALUES (6, 15, N'kazuocyrus@gmail.com', N'1607761285399', N'comment')
INSERT [dbo].[tbl_Notify] ([NotifyID], [PostID], [Email], [Date], [Type]) VALUES (7, 15, N'kazuocyrus@gmail.com', N'1607761334543', N'dislike')
INSERT [dbo].[tbl_Notify] ([NotifyID], [PostID], [Email], [Date], [Type]) VALUES (8, 15, N'kazuocyrus@gmail.com', N'1607761334543', N'dislike')
INSERT [dbo].[tbl_Notify] ([NotifyID], [PostID], [Email], [Date], [Type]) VALUES (9, 15, N'kazuocyrus@gmail.com', N'1607761334543', N'dislike')
INSERT [dbo].[tbl_Notify] ([NotifyID], [PostID], [Email], [Date], [Type]) VALUES (10, 15, N'kazuocyrus@gmail.com', N'1607761334543', N'dislike')
INSERT [dbo].[tbl_Notify] ([NotifyID], [PostID], [Email], [Date], [Type]) VALUES (11, 15, N'share@gmail.com', N'1607762018455', N'dislike')
INSERT [dbo].[tbl_Notify] ([NotifyID], [PostID], [Email], [Date], [Type]) VALUES (12, 15, N'share@gmail.com', N'1607762018455', N'dislike')
INSERT [dbo].[tbl_Notify] ([NotifyID], [PostID], [Email], [Date], [Type]) VALUES (13, 15, N'share@gmail.com', N'1607762018455', N'dislike')
INSERT [dbo].[tbl_Notify] ([NotifyID], [PostID], [Email], [Date], [Type]) VALUES (14, 15, N'share@gmail.com', N'1607762018455', N'dislike')
INSERT [dbo].[tbl_Notify] ([NotifyID], [PostID], [Email], [Date], [Type]) VALUES (15, 15, N'share@gmail.com', N'1607762018455', N'dislike')
INSERT [dbo].[tbl_Notify] ([NotifyID], [PostID], [Email], [Date], [Type]) VALUES (16, 15, N'share@gmail.com', N'1607762018455', N'dislike')
INSERT [dbo].[tbl_Notify] ([NotifyID], [PostID], [Email], [Date], [Type]) VALUES (17, 15, N'share@gmail.com', N'1607762018455', N'dislike')
INSERT [dbo].[tbl_Notify] ([NotifyID], [PostID], [Email], [Date], [Type]) VALUES (18, 15, N'share@gmail.com', N'1607762018455', N'dislike')
INSERT [dbo].[tbl_Notify] ([NotifyID], [PostID], [Email], [Date], [Type]) VALUES (19, 15, N'share@gmail.com', N'1607762018455', N'dislike')
INSERT [dbo].[tbl_Notify] ([NotifyID], [PostID], [Email], [Date], [Type]) VALUES (20, 15, N'share@gmail.com', N'1607762018455', N'dislike')
INSERT [dbo].[tbl_Notify] ([NotifyID], [PostID], [Email], [Date], [Type]) VALUES (21, 15, N'share@gmail.com', N'1607762018455', N'dislike')
INSERT [dbo].[tbl_Notify] ([NotifyID], [PostID], [Email], [Date], [Type]) VALUES (22, 15, N'share@gmail.com', N'1607762018455', N'dislike')
INSERT [dbo].[tbl_Notify] ([NotifyID], [PostID], [Email], [Date], [Type]) VALUES (23, 15, N'share@gmail.com', N'1607762018455', N'dislike')
INSERT [dbo].[tbl_Notify] ([NotifyID], [PostID], [Email], [Date], [Type]) VALUES (24, 15, N'share@gmail.com', N'1607762018455', N'dislike')
INSERT [dbo].[tbl_Notify] ([NotifyID], [PostID], [Email], [Date], [Type]) VALUES (25, 15, N'share@gmail.com', N'1607762018455', N'dislike')
INSERT [dbo].[tbl_Notify] ([NotifyID], [PostID], [Email], [Date], [Type]) VALUES (26, 15, N'share@gmail.com', N'1607762018455', N'dislike')
INSERT [dbo].[tbl_Notify] ([NotifyID], [PostID], [Email], [Date], [Type]) VALUES (27, 15, N'share@gmail.com', N'1607762018455', N'dislike')
INSERT [dbo].[tbl_Notify] ([NotifyID], [PostID], [Email], [Date], [Type]) VALUES (28, 15, N'share@gmail.com', N'1607762018455', N'dislike')
INSERT [dbo].[tbl_Notify] ([NotifyID], [PostID], [Email], [Date], [Type]) VALUES (29, 15, N'share@gmail.com', N'1607762018455', N'dislike')
INSERT [dbo].[tbl_Notify] ([NotifyID], [PostID], [Email], [Date], [Type]) VALUES (30, 15, N'share@gmail.com', N'1607762018455', N'dislike')
INSERT [dbo].[tbl_Notify] ([NotifyID], [PostID], [Email], [Date], [Type]) VALUES (31, 21, N'knight@gmail.com', N'1608000615127', N'dislike')
INSERT [dbo].[tbl_Notify] ([NotifyID], [PostID], [Email], [Date], [Type]) VALUES (32, 21, N'knight@gmail.com', N'1608000621107', N'like')
INSERT [dbo].[tbl_Notify] ([NotifyID], [PostID], [Email], [Date], [Type]) VALUES (33, 17, N'knight@gmail.com', N'1608000633079', N'like')
INSERT [dbo].[tbl_Notify] ([NotifyID], [PostID], [Email], [Date], [Type]) VALUES (34, 22, N'knight@gmail.com', N'1608000737483', N'like')
INSERT [dbo].[tbl_Notify] ([NotifyID], [PostID], [Email], [Date], [Type]) VALUES (35, 19, N'share@gmail.com', N'1608040027024', N'like')
INSERT [dbo].[tbl_Notify] ([NotifyID], [PostID], [Email], [Date], [Type]) VALUES (36, 19, N'share@gmail.com', N'1608040029859', N'dislike')
INSERT [dbo].[tbl_Notify] ([NotifyID], [PostID], [Email], [Date], [Type]) VALUES (37, 19, N'share@gmail.com', N'1608040031143', N'like')
INSERT [dbo].[tbl_Notify] ([NotifyID], [PostID], [Email], [Date], [Type]) VALUES (38, 15, N'share@gmail.com', N'1608040421435', N'comment')
INSERT [dbo].[tbl_Notify] ([NotifyID], [PostID], [Email], [Date], [Type]) VALUES (39, 10, N'share@gmail.com', N'1608042430740', N'comment')
INSERT [dbo].[tbl_Notify] ([NotifyID], [PostID], [Email], [Date], [Type]) VALUES (40, 10, N'knight@gmail.com', N'1608046784991', N'comment')
INSERT [dbo].[tbl_Notify] ([NotifyID], [PostID], [Email], [Date], [Type]) VALUES (41, 10, N'knight@gmail.com', N'1608046983666', N'comment')
INSERT [dbo].[tbl_Notify] ([NotifyID], [PostID], [Email], [Date], [Type]) VALUES (42, 10, N'share@gmail.com', N'1608081369742', N'comment')
INSERT [dbo].[tbl_Notify] ([NotifyID], [PostID], [Email], [Date], [Type]) VALUES (43, 10, N'share@gmail.com', N'1608081651283', N'comment')
INSERT [dbo].[tbl_Notify] ([NotifyID], [PostID], [Email], [Date], [Type]) VALUES (44, 10, N'share@gmail.com', N'1608081674615', N'comment')
INSERT [dbo].[tbl_Notify] ([NotifyID], [PostID], [Email], [Date], [Type]) VALUES (45, 23, N'share@gmail.com', N'1608085934340', N'like')
INSERT [dbo].[tbl_Notify] ([NotifyID], [PostID], [Email], [Date], [Type]) VALUES (46, 34, N'knight@gmail.com', N'1608087400006', N'like')
INSERT [dbo].[tbl_Notify] ([NotifyID], [PostID], [Email], [Date], [Type]) VALUES (47, 34, N'knight@gmail.com', N'1608087405326', N'dislike')
INSERT [dbo].[tbl_Notify] ([NotifyID], [PostID], [Email], [Date], [Type]) VALUES (48, 21, N'knight@gmail.com', N'1608371886603', N'dislike')
INSERT [dbo].[tbl_Notify] ([NotifyID], [PostID], [Email], [Date], [Type]) VALUES (49, 21, N'knight@gmail.com', N'1608371890294', N'like')
INSERT [dbo].[tbl_Notify] ([NotifyID], [PostID], [Email], [Date], [Type]) VALUES (50, 22, N'knight@gmail.com', N'1608371910536', N'comment')
INSERT [dbo].[tbl_Notify] ([NotifyID], [PostID], [Email], [Date], [Type]) VALUES (51, 35, N'lienkhuong72@gmail.com', N'1609425058878', N'like')
INSERT [dbo].[tbl_Notify] ([NotifyID], [PostID], [Email], [Date], [Type]) VALUES (52, 35, N'lienkhuong72@gmail.com', N'1609425066452', N'dislike')
INSERT [dbo].[tbl_Notify] ([NotifyID], [PostID], [Email], [Date], [Type]) VALUES (53, 35, N'lienkhuong72@gmail.com', N'1609425084794', N'comment')
INSERT [dbo].[tbl_Notify] ([NotifyID], [PostID], [Email], [Date], [Type]) VALUES (54, 35, N'kazuocyrus@gmail.com', N'1609425421145', N'like')
INSERT [dbo].[tbl_Notify] ([NotifyID], [PostID], [Email], [Date], [Type]) VALUES (55, 35, N'kazuocyrus@gmail.com', N'1609428376311', N'dislike')
INSERT [dbo].[tbl_Notify] ([NotifyID], [PostID], [Email], [Date], [Type]) VALUES (56, 35, N'kazuocyrus@gmail.com', N'1609428388517', N'comment')
INSERT [dbo].[tbl_Notify] ([NotifyID], [PostID], [Email], [Date], [Type]) VALUES (57, 32, N'knight@gmail.com', N'1611501081569', N'like')
INSERT [dbo].[tbl_Notify] ([NotifyID], [PostID], [Email], [Date], [Type]) VALUES (58, 32, N'knight@gmail.com', N'1611501093805', N'comment')
INSERT [dbo].[tbl_Notify] ([NotifyID], [PostID], [Email], [Date], [Type]) VALUES (59, 37, N'gianhse63203@fpt.edu.vn', N'1611501349913', N'comment')
INSERT [dbo].[tbl_Notify] ([NotifyID], [PostID], [Email], [Date], [Type]) VALUES (60, 37, N'gianhse63203@fpt.edu.vn', N'1611501352626', N'like')
INSERT [dbo].[tbl_Notify] ([NotifyID], [PostID], [Email], [Date], [Type]) VALUES (62, 10, N'lanlnhse140961@fpt.edu.vn', N'1611580859319', N'comment')
SET IDENTITY_INSERT [dbo].[tbl_Notify] OFF
GO
INSERT [dbo].[tbl_Users] ([Email], [Name], [Password], [Role], [Status], [Code]) VALUES (N'ahihi@gmail.com', N'Teo', N'15e2b0d3c33891ebb0f1ef609ec419420c20e320ce94c65fbc8c3312448eb225', N'member', N'New', NULL)
INSERT [dbo].[tbl_Users] ([Email], [Name], [Password], [Role], [Status], [Code]) VALUES (N'caytamto@gmail.com', N'giang', N'96cae35ce8a9b0244178bf28e4966c2ce1b8385723a96a6b838858cdd6ca0a1e', N'member', N'New', N'628233')
INSERT [dbo].[tbl_Users] ([Email], [Name], [Password], [Role], [Status], [Code]) VALUES (N'cyrus@gmail.com', N'Cyrus Le', N'96cae35ce8a9b0244178bf28e4966c2ce1b8385723a96a6b838858cdd6ca0a1e', N'admin', N'Active', N'678696')
INSERT [dbo].[tbl_Users] ([Email], [Name], [Password], [Role], [Status], [Code]) VALUES (N'gianhse63203@fpt.edu.vn', N'Gia ne', N'96cae35ce8a9b0244178bf28e4966c2ce1b8385723a96a6b838858cdd6ca0a1e', N'member', N'Active', N'237510')
INSERT [dbo].[tbl_Users] ([Email], [Name], [Password], [Role], [Status], [Code]) VALUES (N'kazuocyrus@gmail.com', N'Cyrus Le', N'96cae35ce8a9b0244178bf28e4966c2ce1b8385723a96a6b838858cdd6ca0a1e', N'member', N'Active', N'396657')
INSERT [dbo].[tbl_Users] ([Email], [Name], [Password], [Role], [Status], [Code]) VALUES (N'knight@gmail.com', N'Knight', N'96cae35ce8a9b0244178bf28e4966c2ce1b8385723a96a6b838858cdd6ca0a1e', N'member', N'Active', N'619894')
INSERT [dbo].[tbl_Users] ([Email], [Name], [Password], [Role], [Status], [Code]) VALUES (N'lanlnhse140961@fpt.edu.vn', N'Cy', N'96cae35ce8a9b0244178bf28e4966c2ce1b8385723a96a6b838858cdd6ca0a1e', N'member', N'Active', N'504106')
INSERT [dbo].[tbl_Users] ([Email], [Name], [Password], [Role], [Status], [Code]) VALUES (N'lienkhuong72@gmail.com', N'khuong', N'96cae35ce8a9b0244178bf28e4966c2ce1b8385723a96a6b838858cdd6ca0a1e', N'member', N'Active', N'075575')
INSERT [dbo].[tbl_Users] ([Email], [Name], [Password], [Role], [Status], [Code]) VALUES (N'share@gmail.com', N'Share ', N'96cae35ce8a9b0244178bf28e4966c2ce1b8385723a96a6b838858cdd6ca0a1e', N'member', N'Active', N'568882')
INSERT [dbo].[tbl_Users] ([Email], [Name], [Password], [Role], [Status], [Code]) VALUES (N'vuthugiang@gmail.com', N'Giang ne', N'96cae35ce8a9b0244178bf28e4966c2ce1b8385723a96a6b838858cdd6ca0a1e', N'member', N'New', N'955259')
INSERT [dbo].[tbl_Users] ([Email], [Name], [Password], [Role], [Status], [Code]) VALUES (N'vuthugiang2610@gmail.com', N'Giang', N'96cae35ce8a9b0244178bf28e4966c2ce1b8385723a96a6b838858cdd6ca0a1e', N'member', N'Active', N'638881')
INSERT [dbo].[tbl_Users] ([Email], [Name], [Password], [Role], [Status], [Code]) VALUES (N'vuthugiang26100@gmail.com', N'vuthugiang26100@gmail.com', NULL, N'member', N'Active', NULL)
GO
ALTER TABLE [dbo].[tbl_Articles]  WITH CHECK ADD  CONSTRAINT [FK_tbl_Articles_tbl_Users] FOREIGN KEY([Email])
REFERENCES [dbo].[tbl_Users] ([Email])
GO
ALTER TABLE [dbo].[tbl_Articles] CHECK CONSTRAINT [FK_tbl_Articles_tbl_Users]
GO
ALTER TABLE [dbo].[tbl_Comments]  WITH CHECK ADD  CONSTRAINT [FK_tbl_Comments_tbl_Articles] FOREIGN KEY([PostID])
REFERENCES [dbo].[tbl_Articles] ([PostID])
GO
ALTER TABLE [dbo].[tbl_Comments] CHECK CONSTRAINT [FK_tbl_Comments_tbl_Articles]
GO
ALTER TABLE [dbo].[tbl_Comments]  WITH CHECK ADD  CONSTRAINT [FK_tbl_Comments_tbl_Users] FOREIGN KEY([Email])
REFERENCES [dbo].[tbl_Users] ([Email])
GO
ALTER TABLE [dbo].[tbl_Comments] CHECK CONSTRAINT [FK_tbl_Comments_tbl_Users]
GO
ALTER TABLE [dbo].[tbl_Emotion]  WITH CHECK ADD  CONSTRAINT [FK_tbl_Emotion_tbl_Articles] FOREIGN KEY([PostID])
REFERENCES [dbo].[tbl_Articles] ([PostID])
GO
ALTER TABLE [dbo].[tbl_Emotion] CHECK CONSTRAINT [FK_tbl_Emotion_tbl_Articles]
GO
ALTER TABLE [dbo].[tbl_Emotion]  WITH CHECK ADD  CONSTRAINT [FK_tbl_Emotion_tbl_Users] FOREIGN KEY([Email])
REFERENCES [dbo].[tbl_Users] ([Email])
GO
ALTER TABLE [dbo].[tbl_Emotion] CHECK CONSTRAINT [FK_tbl_Emotion_tbl_Users]
GO
ALTER TABLE [dbo].[tbl_Notify]  WITH CHECK ADD  CONSTRAINT [FK_tbl_Notify_tbl_Articles] FOREIGN KEY([PostID])
REFERENCES [dbo].[tbl_Articles] ([PostID])
GO
ALTER TABLE [dbo].[tbl_Notify] CHECK CONSTRAINT [FK_tbl_Notify_tbl_Articles]
GO
ALTER TABLE [dbo].[tbl_Notify]  WITH CHECK ADD  CONSTRAINT [FK_tbl_Notify_tbl_Users] FOREIGN KEY([Email])
REFERENCES [dbo].[tbl_Users] ([Email])
GO
ALTER TABLE [dbo].[tbl_Notify] CHECK CONSTRAINT [FK_tbl_Notify_tbl_Users]
GO
/****** Object:  StoredProcedure [dbo].[getProFromAd]    Script Date: 1/25/2021 8:25:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[getProFromAd] 
 @PageNumber int,
 @RowsOfPage int,
 @name varchar(100),
 @lowPrice float,
 @highPrice float,
 @cateId int
AS
	SELECT proId, name, price, quantity, cateId, image, description, expiredDate, createDate, status
	FROM tblProduct
	where name like '%' + @name + '%' and price >= @lowPrice and price <= @highPrice and cateId = @cateId
	ORDER BY createDate desc 
	OFFSET (@PageNumber-1)*@RowsOfPage ROWS
	FETCH NEXT @RowsOfPage ROWS ONLY;

	select * from tblProduct


GO
/****** Object:  StoredProcedure [dbo].[getProFromAdAcceptCate]    Script Date: 1/25/2021 8:25:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[getProFromAdAcceptCate] 
 @PageNumber int,
 @RowsOfPage int,
 @name varchar(100),
 @lowPrice float,
 @highPrice float
AS
	SELECT proId, name, price, quantity, cateId, image, description, expiredDate, createDate, status
	FROM tblProduct
	where name like '%' + @name + '%' and price >= @lowPrice and price <= @highPrice 
	ORDER BY createDate desc 
	OFFSET (@PageNumber-1)*@RowsOfPage ROWS
	FETCH NEXT @RowsOfPage ROWS ONLY;

	select * from tblProduct


GO
/****** Object:  StoredProcedure [dbo].[getProFromEmp]    Script Date: 1/25/2021 8:25:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create PROCEDURE [dbo].[getProFromEmp] 
 @PageNumber int,
 @RowsOfPage int,
 @name varchar(100),
 @lowPrice float,
 @highPrice float,
 @cateId int
AS
	SELECT proId, name, price, quantity, cateId, image, description, expiredDate, createDate, status
	FROM tblProduct
	where name like '%' + @name + '%' and price >= @lowPrice and price <= @highPrice 
	and cateId = @cateId and quantity > 0 and expiredDate > GETDATE() and status like 'Active'
	ORDER BY createDate desc 
	OFFSET (@PageNumber-1)*@RowsOfPage ROWS
	FETCH NEXT @RowsOfPage ROWS ONLY;

	select * from tblProduct



GO
/****** Object:  StoredProcedure [dbo].[getProFromEmpAcceptCate]    Script Date: 1/25/2021 8:25:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create PROCEDURE [dbo].[getProFromEmpAcceptCate] 
 @PageNumber int,
 @RowsOfPage int,
 @name varchar(100),
 @lowPrice float,
 @highPrice float
AS
	SELECT proId, name, price, quantity, cateId, image, description, expiredDate, createDate, status
	FROM tblProduct
	where name like '%' + @name + '%' and price >= @lowPrice and price <= @highPrice 
	 and quantity > 0 and expiredDate > GETDATE() and status like 'Active'
	ORDER BY createDate desc 
	OFFSET (@PageNumber-1)*@RowsOfPage ROWS
	FETCH NEXT @RowsOfPage ROWS ONLY;

	select * from tblProduct
GO
USE [master]
GO
ALTER DATABASE [Mini_Social_Network] SET  READ_WRITE 
GO

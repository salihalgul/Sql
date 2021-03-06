USE [master]
GO
/****** Object:  Database [Movies]    Script Date: 8/4/2019 5:49:38 PM ******/
CREATE DATABASE [Movies]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Movies', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\Movies.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Movies_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\Movies_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [Movies] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Movies].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Movies] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Movies] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Movies] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Movies] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Movies] SET ARITHABORT OFF 
GO
ALTER DATABASE [Movies] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [Movies] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Movies] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Movies] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Movies] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Movies] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Movies] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Movies] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Movies] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Movies] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Movies] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Movies] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Movies] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Movies] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Movies] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Movies] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Movies] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Movies] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [Movies] SET  MULTI_USER 
GO
ALTER DATABASE [Movies] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Movies] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Movies] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Movies] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Movies] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'Movies', N'ON'
GO
ALTER DATABASE [Movies] SET QUERY_STORE = OFF
GO
USE [Movies]
GO
/****** Object:  User [udemy]    Script Date: 8/4/2019 5:49:38 PM ******/
CREATE USER [udemy] WITHOUT LOGIN WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [canbozzz]    Script Date: 8/4/2019 5:49:38 PM ******/
CREATE USER [canbozzz] WITHOUT LOGIN WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_owner] ADD MEMBER [canbozzz]
GO
/****** Object:  UserDefinedFunction [dbo].[CurrentYear]    Script Date: 8/4/2019 5:49:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[CurrentYear]()
RETURNS INT
AS
BEGIN
	RETURN year(GetDate())
END

GO
/****** Object:  UserDefinedFunction [dbo].[format_currency]    Script Date: 8/4/2019 5:49:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[format_currency] (@monetary_value decimal(20,2) ) returns varchar(20)
as
begin
	declare @return_value varchar(20)
	declare @is_negative bit
	select @is_negative = case when @monetary_value<0 then 1 else 0 end

	if @is_negative = 1
		set @monetary_value = -1*@monetary_value

	set @return_value = convert(varchar, isnull(@monetary_value, 0))
	
	
		--------------------------------------------------------------------------------
		





	--------------------------------------------------------------------------------
	

	declare @before varchar(20), @after varchar(20)

	if charindex ('.', @return_value )>0 
	begin
		set @after= substring(@return_value,  charindex ('.', @return_value ), len(@return_value))	
		set @before= substring(@return_value,1,  charindex ('.', @return_value )-1)	
	end
	else
	begin
		set @before = @return_value
		set @after=''
	end
	-- after every third character:
	declare @i int
	if len(@before)>3 
	begin
		set @i = 3
		while @i>1 and @i < len(@before)
		begin
			set @before = substring(@before,1,len(@before)-@i) + ',' + right(@before,@i)
			set @i = @i + 4
		end
	end
	set @return_value = @before + @after

	if @is_negative = 1
		set @return_value = '-' + @return_value

	return @return_value 
end

GO
/****** Object:  UserDefinedFunction [dbo].[LeftPad]    Script Date: 8/4/2019 5:49:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[LeftPad](
	@stringToPad VARCHAR(8000),
	@finalLength INT,
	@paddingChar CHAR(1)
) 
RETURNS VARCHAR(8000)
AS
BEGIN    
	DECLARE @answer VARCHAR(8000)
	DECLARE @strLength INT
	DECLARE @charsToAdd INT
	
	SELECT @strLength = LEN(@stringToPad)
	SELECT @charsToAdd =  @finalLength - @strLength

	IF @charsToAdd<0 
		SELECT @answer = @stringToPad
	ELSE
		SELECT @answer = REPLICATE (@paddingChar, @charsToAdd) + @stringToPad

	RETURN @answer
END

GO
/****** Object:  UserDefinedFunction [dbo].[UkDate]    Script Date: 8/4/2019 5:49:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[UkDate](
	@DateToFormat AS DATETIME		-- the date to format
)
RETURNS varchar(10)

AS

BEGIN

	DECLARE @DayNo smallint
	DECLARE @MonthNo smallint
	DECLARE @YearNo smallint
	
	SELECT @DayNo = day(@DateToFormat)
	SELECT @MonthNo = month(@DateToFormat)
	SELECT @YearNo = year(@DateToFormat)

	RETURN 
		dbo.LeftPad(@DayNo,2,'0') + '-' +
		dbo.LeftPad(@MonthNo,2,'0') + '-' +
		CAST(@YearNo AS char(4))
END

GO
/****** Object:  UserDefinedFunction [dbo].[YasHesap]    Script Date: 8/4/2019 5:49:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE function [dbo].[YasHesap](@DOB date)
RETURNS INT
AS
BEGIN
RETURN datepart(YEAR,getdate())-datepart(year,@DOB)
END
GO
/****** Object:  Table [dbo].[tblActor]    Script Date: 8/4/2019 5:49:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblActor](
	[ActorID] [int] NOT NULL,
	[ActorName] [nvarchar](255) NULL,
	[ActorDOB] [datetime] NULL,
	[ActorGender] [nvarchar](255) NULL,
 CONSTRAINT [PK_tblActor] PRIMARY KEY CLUSTERED 
(
	[ActorID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblCast]    Script Date: 8/4/2019 5:49:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblCast](
	[CastID] [int] NOT NULL,
	[CastFilmID] [int] NULL,
	[CastActorID] [int] NULL,
	[CastCharacterName] [nvarchar](255) NULL,
 CONSTRAINT [PK_tblCast] PRIMARY KEY CLUSTERED 
(
	[CastID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblFilm]    Script Date: 8/4/2019 5:49:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblFilm](
	[FilmID] [int] IDENTITY(1,1) NOT NULL,
	[FilmName] [nvarchar](255) NULL,
	[FilmReleaseDate] [datetime] NULL,
	[FilmDirectorID] [int] NULL,
	[FilmLanguageID] [int] NULL,
	[FilmCountryID] [int] NULL,
	[FilmStudioID] [int] NULL,
	[FilmSynopsis] [nvarchar](max) NULL,
	[FilmRunTimeMinutes] [int] NULL,
	[FilmCertificateID] [bigint] NULL,
	[FilmBudgetDollars] [int] NULL,
	[FilmBoxOfficeDollars] [int] NULL,
	[FilmOscarNominations] [int] NULL,
	[FilmOscarWins] [int] NULL,
 CONSTRAINT [PK_tblFilm] PRIMARY KEY CLUSTERED 
(
	[FilmID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  View [dbo].[vw_Karakter]    Script Date: 8/4/2019 5:49:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vw_Karakter]
AS
SELECT        dbo.tblActor.ActorID, dbo.tblFilm.FilmID, dbo.tblActor.ActorName, dbo.tblActor.ActorDOB, dbo.tblActor.ActorGender, dbo.tblFilm.FilmName, dbo.tblCast.CastCharacterName
FROM            dbo.tblActor INNER JOIN
                         dbo.tblCast ON dbo.tblActor.ActorID = dbo.tblCast.CastActorID INNER JOIN
                         dbo.tblFilm ON dbo.tblCast.CastFilmID = dbo.tblFilm.FilmID
GO
/****** Object:  Table [dbo].[tblCertificate]    Script Date: 8/4/2019 5:49:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblCertificate](
	[CertificateID] [bigint] NOT NULL,
	[Certificate] [nvarchar](255) NULL,
 CONSTRAINT [PK_tblCertificate] PRIMARY KEY CLUSTERED 
(
	[CertificateID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[vwFilmDetails]    Script Date: 8/4/2019 5:49:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vwFilmDetails]
AS
SELECT     Certificate
FROM         dbo.tblCertificate

GO
/****** Object:  Table [dbo].[tblCountry]    Script Date: 8/4/2019 5:49:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblCountry](
	[CountryID] [int] NOT NULL,
	[CountryName] [nvarchar](255) NULL,
 CONSTRAINT [PK_tblCountry] PRIMARY KEY CLUSTERED 
(
	[CountryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblDirector]    Script Date: 8/4/2019 5:49:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblDirector](
	[DirectorID] [int] NOT NULL,
	[DirectorName] [nvarchar](255) NULL,
	[DirectorDOB] [datetime] NULL,
	[DirectorGender] [nvarchar](255) NULL,
 CONSTRAINT [PK_tblDirector] PRIMARY KEY CLUSTERED 
(
	[DirectorID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblLanguage]    Script Date: 8/4/2019 5:49:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblLanguage](
	[LanguageID] [int] NOT NULL,
	[Language] [nvarchar](255) NULL,
 CONSTRAINT [PK_tblLanguage] PRIMARY KEY CLUSTERED 
(
	[LanguageID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblStudio]    Script Date: 8/4/2019 5:49:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblStudio](
	[StudioID] [int] NOT NULL,
	[StudioName] [nvarchar](255) NULL,
 CONSTRAINT [PK_tblStudio] PRIMARY KEY CLUSTERED 
(
	[StudioID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[vwFilms]    Script Date: 8/4/2019 5:49:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vwFilms]
AS
SELECT     dbo.tblFilm.FilmName, dbo.tblDirector.DirectorName, dbo.tblCountry.CountryName, dbo.tblLanguage.Language, dbo.tblCertificate.Certificate, 
                      dbo.tblStudio.StudioName
FROM         dbo.tblCertificate INNER JOIN
                      dbo.tblFilm ON dbo.tblCertificate.CertificateID = dbo.tblFilm.FilmCertificateID INNER JOIN
                      dbo.tblCountry ON dbo.tblFilm.FilmCountryID = dbo.tblCountry.CountryID INNER JOIN
                      dbo.tblDirector ON dbo.tblFilm.FilmDirectorID = dbo.tblDirector.DirectorID INNER JOIN
                      dbo.tblLanguage ON dbo.tblFilm.FilmLanguageID = dbo.tblLanguage.LanguageID INNER JOIN
                      dbo.tblStudio ON dbo.tblFilm.FilmStudioID = dbo.tblStudio.StudioID

GO
/****** Object:  View [dbo].[vwFilmSimple]    Script Date: 8/4/2019 5:49:39 PM ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vwFilmSimple]
AS
SELECT     FilmID, FilmName, FilmBoxOfficeDollars
FROM         dbo.tblFilm
WHERE     (FilmBoxOfficeDollars = NULL)

GO
/****** Object:  Table [dbo].[tblCategory]    Script Date: 8/4/2019 5:49:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblCategory](
	[CategoryID] [int] IDENTITY(1,1) NOT NULL,
	[CategoryName] [nvarchar](50) NULL,
 CONSTRAINT [PK_tblCategory] PRIMARY KEY CLUSTERED 
(
	[CategoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblFilmCategoryMatch]    Script Date: 8/4/2019 5:49:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblFilmCategoryMatch](
	[FID] [int] NULL,
	[CID] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblGenre]    Script Date: 8/4/2019 5:49:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblGenre](
	[GenreId] [bigint] NOT NULL,
	[GenreName] [varchar](50) NULL,
 CONSTRAINT [PK_tblGenre] PRIMARY KEY CLUSTERED 
(
	[GenreId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[tblFilm]  WITH CHECK ADD  CONSTRAINT [FK_tblFilm_tblCertificate] FOREIGN KEY([FilmCertificateID])
REFERENCES [dbo].[tblCertificate] ([CertificateID])
GO
ALTER TABLE [dbo].[tblFilm] CHECK CONSTRAINT [FK_tblFilm_tblCertificate]
GO
ALTER TABLE [dbo].[tblFilm]  WITH CHECK ADD  CONSTRAINT [FK_tblFilm_tblCountry] FOREIGN KEY([FilmCountryID])
REFERENCES [dbo].[tblCountry] ([CountryID])
GO
ALTER TABLE [dbo].[tblFilm] CHECK CONSTRAINT [FK_tblFilm_tblCountry]
GO
ALTER TABLE [dbo].[tblFilm]  WITH CHECK ADD  CONSTRAINT [FK_tblFilm_tblDirector] FOREIGN KEY([FilmDirectorID])
REFERENCES [dbo].[tblDirector] ([DirectorID])
GO
ALTER TABLE [dbo].[tblFilm] CHECK CONSTRAINT [FK_tblFilm_tblDirector]
GO
ALTER TABLE [dbo].[tblFilm]  WITH CHECK ADD  CONSTRAINT [FK_tblFilm_tblLanguage] FOREIGN KEY([FilmLanguageID])
REFERENCES [dbo].[tblLanguage] ([LanguageID])
GO
ALTER TABLE [dbo].[tblFilm] CHECK CONSTRAINT [FK_tblFilm_tblLanguage]
GO
ALTER TABLE [dbo].[tblFilm]  WITH CHECK ADD  CONSTRAINT [FK_tblFilm_tblStudio1] FOREIGN KEY([FilmStudioID])
REFERENCES [dbo].[tblStudio] ([StudioID])
GO
ALTER TABLE [dbo].[tblFilm] CHECK CONSTRAINT [FK_tblFilm_tblStudio1]
GO
ALTER TABLE [dbo].[tblFilmCategoryMatch]  WITH CHECK ADD  CONSTRAINT [FK_tblFilmCategoryMatch_tblCategory] FOREIGN KEY([CID])
REFERENCES [dbo].[tblCategory] ([CategoryID])
GO
ALTER TABLE [dbo].[tblFilmCategoryMatch] CHECK CONSTRAINT [FK_tblFilmCategoryMatch_tblCategory]
GO
ALTER TABLE [dbo].[tblFilmCategoryMatch]  WITH CHECK ADD  CONSTRAINT [FK_tblFilmCategoryMatch_tblFilm] FOREIGN KEY([FID])
REFERENCES [dbo].[tblFilm] ([FilmID])
GO
ALTER TABLE [dbo].[tblFilmCategoryMatch] CHECK CONSTRAINT [FK_tblFilmCategoryMatch_tblFilm]
GO
/****** Object:  StoredProcedure [dbo].[KategoriFilmEkle]    Script Date: 8/4/2019 5:49:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--Stored Procedure
 CREATE proc [dbo].[KategoriFilmEkle]
 @KatAdý nvarchar(50),@FilmAdý nvarchar(150)
 as
 begin
 begin transaction
  begin try
 
--Deðiþken Tanýmlama
 declare @FID int
 declare @CID int


 --if tek iþ yaparsa begin and kullanýlmaya gerek yok
 --Kategori ayný isimden varsa tekrardan eklememek için kullandýk.
 IF EXISTS (select *from tblCategory where CategoryName =@KatAdý )
 set @CID=(select top 1 CategoryID   from  tblCategory  where  CategoryName =@KatAdý)
 else
 begin
  
 insert into tblCategory (CategoryName ) values(@KatAdý)
 set @CID=(select top 1 CategoryID   from  tblCategory  order by  CategoryID desc)
 
 end
 insert into tblFilm (FilmName) values (@FilmAdý)
 --Eþleþme tablosuna oluþturduðumuz kaydýn ýdlerini kaydedelim
 
 set @FID=(select top 1 FilmID  from  tblFilm order by FilmID desc)
 
 insert into tblFilmCategoryMatch (FID,CID) VALUES (@FID,@CID)
	end try
	begin catch
	    rollback
	end catch
	commit
 end
GO
/****** Object:  StoredProcedure [dbo].[spExample]    Script Date: 8/4/2019 5:49:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spExample]

AS
BEGIN
	select * from tblFilm
END

GO
/****** Object:  StoredProcedure [dbo].[spFilms]    Script Date: 8/4/2019 5:49:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[spFilms] (

	@CertName varchar(2),	-- certificate looking for
	@MinOscars int=0		-- films with this many Oscars

) AS
SELECT 
	f.FilmName,
	c.certificate,
	f.FilmOscarWins
FROM
	tblFilm AS f
	INNER JOIN tblCertificate as c ON 
		f.FilmCertificateId=c.CertificateId
WHERE
	c.certificate=@CertName AND
	FilmOscarWins>=@MinOscars

GO
/****** Object:  StoredProcedure [dbo].[spOrnek1]    Script Date: 8/4/2019 5:49:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spOrnek1]
AS
BEGIN
	SELECT * FROM tbl_il il
	INNER JOIN tbl_ilce ilce
	ON il.il_id=ilce.ilce_id
END
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "tblActor"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tblCast"
            Begin Extent = 
               Top = 6
               Left = 246
               Bottom = 136
               Right = 441
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tblFilm"
            Begin Extent = 
               Top = 6
               Left = 479
               Bottom = 136
               Right = 690
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vw_Karakter'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vw_Karakter'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "tblCertificate"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 84
               Right = 189
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vwFilmDetails'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vwFilmDetails'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[41] 4[9] 2[14] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1[37] 4[17] 3) )"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1[50] 2[25] 3) )"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4[30] 2[40] 3) )"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1[56] 3) )"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 1
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "tblCertificate"
            Begin Extent = 
               Top = 131
               Left = 212
               Bottom = 209
               Right = 363
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tblFilm"
            Begin Extent = 
               Top = 84
               Left = 442
               Bottom = 192
               Right = 626
            End
            DisplayFlags = 280
            TopColumn = 2
         End
         Begin Table = "tblCountry"
            Begin Extent = 
               Top = 6
               Left = 631
               Bottom = 84
               Right = 782
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tblDirector"
            Begin Extent = 
               Top = 6
               Left = 820
               Bottom = 114
               Right = 973
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tblLanguage"
            Begin Extent = 
               Top = 84
               Left = 664
               Bottom = 162
               Right = 815
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tblStudio"
            Begin Extent = 
               Top = 27
               Left = 168
               Bottom = 105
               Right = 319
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
      PaneHidden = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width =' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vwFilms'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N' 1500
         Width = 1500
         Width = 1500
         Width = 1065
         Width = 1035
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vwFilms'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vwFilms'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "tblFilm"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 114
               Right = 222
            End
            DisplayFlags = 280
            TopColumn = 10
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vwFilmSimple'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vwFilmSimple'
GO
USE [master]
GO
ALTER DATABASE [Movies] SET  READ_WRITE 
GO

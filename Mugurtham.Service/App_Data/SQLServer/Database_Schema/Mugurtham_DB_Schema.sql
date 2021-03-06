USE [master]
GO
/****** Object:  Database [Mugurtham]    Script Date: 3/12/2015 9:38:48 AM ******/
CREATE DATABASE [Mugurtham]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Mugurtham', FILENAME = N'C:\Program Files (x86)\Parallels\Plesk\Databases\MSSQL\MSSQL11.MSSQLSERVER2012\MSSQL\DATA\Mugurtham.mdf' , SIZE = 4352KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'Mugurtham_log', FILENAME = N'C:\Program Files (x86)\Parallels\Plesk\Databases\MSSQL\MSSQL11.MSSQLSERVER2012\MSSQL\DATA\Mugurtham_log.LDF' , SIZE = 3136KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [Mugurtham] SET COMPATIBILITY_LEVEL = 100
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Mugurtham].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Mugurtham] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Mugurtham] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Mugurtham] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Mugurtham] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Mugurtham] SET ARITHABORT OFF 
GO
ALTER DATABASE [Mugurtham] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Mugurtham] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [Mugurtham] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Mugurtham] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Mugurtham] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Mugurtham] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Mugurtham] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Mugurtham] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Mugurtham] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Mugurtham] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Mugurtham] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Mugurtham] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Mugurtham] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Mugurtham] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Mugurtham] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Mugurtham] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Mugurtham] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Mugurtham] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Mugurtham] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [Mugurtham] SET  MULTI_USER 
GO
ALTER DATABASE [Mugurtham] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Mugurtham] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Mugurtham] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Mugurtham] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
USE [Mugurtham]
GO
/****** Object:  User [MugurthamAdmin]    Script Date: 3/12/2015 9:38:51 AM ******/
CREATE USER [MugurthamAdmin] FOR LOGIN [MugurthamAdmin] WITH DEFAULT_SCHEMA=[MugurthamAdmin]
GO
ALTER ROLE [db_securityadmin] ADD MEMBER [MugurthamAdmin]
GO
ALTER ROLE [db_ddladmin] ADD MEMBER [MugurthamAdmin]
GO
ALTER ROLE [db_backupoperator] ADD MEMBER [MugurthamAdmin]
GO
ALTER ROLE [db_datareader] ADD MEMBER [MugurthamAdmin]
GO
ALTER ROLE [db_datawriter] ADD MEMBER [MugurthamAdmin]
GO
/****** Object:  Schema [MugurthamAdmin]    Script Date: 3/12/2015 9:38:52 AM ******/
CREATE SCHEMA [MugurthamAdmin]
GO
/****** Object:  StoredProcedure [dbo].[uspAllProfileSearch]    Script Date: 3/12/2015 9:38:52 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:      <ANAND JAYASEELAN>
-- Create date: <NOV 17 2013>
-- Description: <ALL PROFILE SEARCH DYNAMIC SQL>
-- =============================================
CREATE PROCEDURE [dbo].[uspAllProfileSearch]
									(
										@strProfileID varchar(30)										
									)	
AS
BEGIN

	DECLARE @strSQLQuery AS NVARCHAR(4000) 

    SET NOCOUNT ON;
    SET XACT_ABORT,
        QUOTED_IDENTIFIER,
        ANSI_NULLS,
        ANSI_PADDING,
        ANSI_WARNINGS,
        ARITHABORT,
        CONCAT_NULL_YIELDS_NULL ON;
    SET NUMERIC_ROUNDABORT OFF;
 
    DECLARE @localTran bit
    IF @@TRANCOUNT = 0
    BEGIN
        SET @localTran = 1
        BEGIN TRANSACTION LocalTran
    END
 
    BEGIN TRY
 
						SET @strSQLQuery = 
										   'SELECT elanprofileid, 
											profile_basicinfo.profileid, 
											name, 
											age, 
											gender, 
											dateofbirth, 
											tamildob, 
											timeofbirth, 
											placeofbirth, 
											maritalstatus, 
											noofchildren, 
											childrenlivingstatus, 
											height, 
											weight, 
											bodytype, 
											complexion, 
											physicalstatus, 
											bloodgroup, 
											mothertongue, 
											profilecreatedby, 
											religion, 
											caste, 
											subcaste, 
											acceptothernaidu, 
											gothram, 
											star, 
											raasi, 
											zodiac, 
											horoscopematch, 
											anydosham, 
											eating, 
											smoking, 
											drinking, 
											aboutme, 
											partnerexpectations, 
											createdby, 
											createddate, 
											zodiacyear, 
											zodiacmonth, 
											zodiacday, 
											profile_basicinfo.matrimonyclientid, 
											profile_carrier.education,
											profile_carrier.Occupation,
											ResidingCity,
											ResidingState,
											CountryLivingIn,
											portal_clients.Clientname,
											Profile_Photo.Extension 
											FROM   
													portal_user portal_user WITH (nolock) 
													INNER JOIN profile_basicinfo profile_basicinfo WITH (nolock) 
													ON profile_basicinfo.ProfileID = ''' + @strProfileID + ''' AND
													portal_user.is_activated = 0 and profile_basicinfo.ProfileID = portal_user.login_name 														
													INNER JOIN portal_clients portal_clients WITH (nolock) 													
													ON portal_clients.clientid = profile_basicinfo.matrimonyclientid 
													LEFT OUTER JOIN profile_carrier Profile_Carrier 
													ON profile_carrier.profileid = profile_basicinfo.profileid 
													LEFT OUTER JOIN Profile_LocationInfo Profile_LocationInfo 
													ON Profile_LocationInfo.profileid = profile_basicinfo.profileid 
													LEFT OUTER JOIN Profile_Photo Profile_Photo 
													ON Profile_Photo.profileid = profile_basicinfo.profileid 
													
											WHERE  1 = 1 											
											ORDER BY profile_basicinfo.createddate '
						EXECUTE Sp_executesql  @strSQLQuery 
 
        IF @localTran = 1 AND XACT_STATE() = 1
            COMMIT TRAN LocalTran
 
    END TRY
    BEGIN CATCH
 
        DECLARE @ErrorMessage NVARCHAR(4000)
        DECLARE @ErrorSeverity INT
        DECLARE @ErrorState INT
 
        SELECT  @ErrorMessage = ERROR_MESSAGE(),
                @ErrorSeverity = ERROR_SEVERITY(),
                @ErrorState = ERROR_STATE()
 
        IF @localTran = 1 AND XACT_STATE() <> 0
            ROLLBACK TRAN
 
        RAISERROR ( @ErrorMessage, @ErrorSeverity, @ErrorState)
 
    END CATCH
 
END

GO
/****** Object:  StoredProcedure [dbo].[uspBlogForUser]    Script Date: 3/12/2015 9:38:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ==============================================================
-- Author:      <ANAND JAYASEELAN>
-- Create date: <NOV 30 2013>
-- Description: <TO DISPLAY ALL BLOGS FOR THE LOGGEDIN USER>
-- ==============================================================
CREATE PROCEDURE [dbo].[uspBlogForUser]
									(
										@strUserID varchar(30)										
									)	
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT,
        QUOTED_IDENTIFIER,
        ANSI_NULLS,
        ANSI_PADDING,
        ANSI_WARNINGS,
        ARITHABORT,
        CONCAT_NULL_YIELDS_NULL ON;
    SET NUMERIC_ROUNDABORT OFF;
 
    DECLARE @localTran bit
    IF @@TRANCOUNT = 0
    BEGIN
        SET @localTran = 1
        BEGIN TRANSACTION LocalTran
    END
 
    BEGIN TRY
 
						SELECT DISTINCT disc_master.disc_id, 
										disc_master.forum_name   'Forum Name', 
										portal_user.user_name    'Created By', 
										disc_master.created_date 'Created Date' 
						FROM   disc_master disc_master WITH (nolock) 
							   INNER JOIN disc_privilege disc_privilege WITH (nolock) 
									   ON disc_privilege.disc_id = disc_master.disc_id 
							   INNER JOIN portal_user portal_user WITH (nolock) 
									   ON portal_user.user_id = disc_master.moderator 
							   INNER JOIN (SELECT disc_privilege.disc_id AS disc_id 
										   FROM   portal_user portal_user WITH (nolock) 
												  INNER JOIN disc_privilege disc_privilege WITH (nolock) 
														  ON portal_user.user_id = 
															 @strUserID 
															 AND disc_privilege.user_id = 
																 portal_user.user_id 
										   UNION ALL 
										   SELECT disc_privilege.disc_id AS disc_id 
										   FROM   portal_user portal_user WITH ( nolock) 
												  INNER JOIN portal_group portal_group WITH (nolock) 
														  ON portal_user.user_id = 
															 @strUserID
															 AND portal_user.user_id = 
																 portal_group.user_id 
												  INNER JOIN disc_privilege disc_privilege WITH (nolock) 
														  ON portal_group.group_id = 
															 disc_privilege.user_id 
										   UNION ALL 
										   SELECT disc_privilege.disc_id AS disc_id 
										   FROM   portal_user portal_user WITH ( nolock) 
												  INNER JOIN portal_role portal_role WITH (nolock) 
														  ON portal_user.user_id = 
															 @strUserID
															 AND portal_user.user_id = 
																 portal_role.user_id 
												  INNER JOIN disc_privilege disc_privilege WITH (nolock) 
														  ON portal_role.role_id = 
															 disc_privilege.user_id) AS 
							   tblUserPrivilige 
									   ON tblUserPrivilige.disc_id = disc_privilege.disc_id 
						ORDER  BY disc_master.created_date DESC 
 
        IF @localTran = 1 AND XACT_STATE() = 1
            COMMIT TRAN LocalTran
 
    END TRY
    BEGIN CATCH
 
        DECLARE @ErrorMessage NVARCHAR(4000)
        DECLARE @ErrorSeverity INT
        DECLARE @ErrorState INT
 
        SELECT  @ErrorMessage = ERROR_MESSAGE(),
                @ErrorSeverity = ERROR_SEVERITY(),
                @ErrorState = ERROR_STATE()
 
        IF @localTran = 1 AND XACT_STATE() <> 0
            ROLLBACK TRAN
 
        RAISERROR ( @ErrorMessage, @ErrorSeverity, @ErrorState)
 
    END CATCH
 
END

GO
/****** Object:  StoredProcedure [dbo].[uspBlogResponses]    Script Date: 3/12/2015 9:38:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ==============================================================
-- Author:      <ANAND JAYASEELAN>
-- Create date: <NOV 30 2013>
-- Description: <TO DISPLAY ALL RESPONSES FOR THE SPECIFIC BLOG>
-- ==============================================================
CREATE PROCEDURE [dbo].[uspBlogResponses]
									(
										@strBlogID varchar(30)										
									)	
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT,
        QUOTED_IDENTIFIER,
        ANSI_NULLS,
        ANSI_PADDING,
        ANSI_WARNINGS,
        ARITHABORT,
        CONCAT_NULL_YIELDS_NULL ON;
    SET NUMERIC_ROUNDABORT OFF;
 
    DECLARE @localTran bit
    IF @@TRANCOUNT = 0
    BEGIN
        SET @localTran = 1
        BEGIN TRANSACTION LocalTran
    END
 
    BEGIN TRY
 
						SELECT portal_user.user_id, 
							   portal_user.user_name, 
							   disc_replythread.replied_date, 
							   disc_replythread.reply_msg, 
							   prof_user.photo_path, 
							   profile_photo.photopath,
							   Profile_BasicInfo.ProfileID,       
							   profile_photo.Extension  
						FROM   disc_replythread disc_replythread WITH (nolock) 
							   INNER JOIN portal_user portal_user WITH (nolock) 
									   ON disc_replythread.thread_id = @strBlogID 
										  AND portal_user.user_id = disc_replythread.reply_author 
							   INNER JOIN prof_user prof_user WITH (nolock) 
									   ON prof_user.user_id = portal_user.user_id 
							   LEFT OUTER JOIN profile_basicinfo Profile_BasicInfo WITH (nolock) 
									   ON profile_basicinfo.profileid = portal_user.login_name 
							   LEFT OUTER JOIN profile_photo Profile_photo WITH (nolock) 
											ON profile_basicinfo.profileid = profile_photo.profileid 
						ORDER  BY disc_replythread.replied_date DESC 
 
        IF @localTran = 1 AND XACT_STATE() = 1
            COMMIT TRAN LocalTran
 
    END TRY
    BEGIN CATCH
 
        DECLARE @ErrorMessage NVARCHAR(4000)
        DECLARE @ErrorSeverity INT
        DECLARE @ErrorState INT
 
        SELECT  @ErrorMessage = ERROR_MESSAGE(),
                @ErrorSeverity = ERROR_SEVERITY(),
                @ErrorState = ERROR_STATE()
 
        IF @localTran = 1 AND XACT_STATE() <> 0
            ROLLBACK TRAN
 
        RAISERROR ( @ErrorMessage, @ErrorSeverity, @ErrorState)
 
    END CATCH
 
END

GO
/****** Object:  StoredProcedure [dbo].[uspGeneralSearch]    Script Date: 3/12/2015 9:38:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================  
-- Author:      <ANAND JAYASEELAN>  
-- Create date: <NOV 02 2013>  
-- Description: <GENERAL SEARCH DYNAMIC SQL>  
-- =============================================  
CREATE PROCEDURE [dbo].[uspGeneralSearch]  
         (  
          @strMatrimonyClientID varchar(30),  
          @intIsSameSangam  AS INT,  
          @strGender  AS varchar(10),  
          @intFromAge  AS INT,  
          @intToAge  AS INT,  
          @strSubCaste  AS varchar(20),  
          @strStar  AS varchar(20),
          @strCaste  AS varchar(20)   
         )   
AS  
BEGIN  
  
 DECLARE @strSQLQuery AS NVARCHAR(4000)   
  
    SET NOCOUNT ON;  
    SET XACT_ABORT,  
        QUOTED_IDENTIFIER,  
        ANSI_NULLS,  
        ANSI_PADDING,  
        ANSI_WARNINGS,  
        ARITHABORT,  
        CONCAT_NULL_YIELDS_NULL ON;  
    SET NUMERIC_ROUNDABORT OFF;  
   
    DECLARE @localTran bit  
    IF @@TRANCOUNT = 0  
    BEGIN  
        SET @localTran = 1  
        BEGIN TRANSACTION LocalTran  
    END  
   
    BEGIN TRY  
   
      SET @strSQLQuery =   
             'SELECT elanprofileid,   
           profile_basicinfo.profileid,   
           name,   
           age,   
           gender,   
           dateofbirth,   
           tamildob,   
           timeofbirth,   
           placeofbirth,   
           maritalstatus,   
           noofchildren,   
           childrenlivingstatus,   
           height,   
           weight,   
           bodytype,   
           complexion,   
           physicalstatus,   
           bloodgroup,   
           mothertongue,   
           profilecreatedby,   
           religion,   
           caste,   
           subcaste,   
           acceptothernaidu,   
           gothram,   
           star,   
           raasi,   
           zodiac,   
           horoscopematch,   
           anydosham,   
           eating,   
           smoking,   
           drinking,   
           aboutme,   
           partnerexpectations,   
           createdby,   
           createddate,   
           zodiacyear,   
           zodiacmonth,   
           zodiacday,   
           portal_user.matrimonyclientid,   
           profile_carrier.education,  
           profile_carrier.Occupation,  
           ResidingCity,  
           ResidingState,  
           CountryLivingIn,  
           portal_clients.ClientName,  
           Profile_Photo.Extension   
           FROM   
             portal_user portal_user WITH (nolock)   
             INNER JOIN profile_basicinfo profile_basicinfo WITH (nolock)   
             on portal_user.is_activated = 0 and portal_user.login_name = profile_basicinfo.profileid               
             INNER JOIN portal_clients portal_clients WITH (nolock)   
             ON portal_clients.clientid = profile_basicinfo.matrimonyclientid   
             LEFT OUTER JOIN profile_carrier Profile_Carrier   
             ON profile_carrier.profileid = profile_basicinfo.profileid   
             LEFT OUTER JOIN Profile_LocationInfo Profile_LocationInfo   
             ON Profile_LocationInfo.profileid = profile_basicinfo.profileid   
             LEFT OUTER JOIN Profile_Photo Profile_Photo   
             ON Profile_Photo.profileid = profile_basicinfo.profileid   
           WHERE  1 = 1 '  
  
      --ADDING SANGAM   
      IF @intIsSameSangam = 1   
        SET @strSQLQuery = @strSQLQuery   
            + ' and profile_basicinfo.MatrimonyClientID != '''   
            + @strMatrimonyClientID + ''''   
       ELSE IF @intIsSameSangam = 0     
          SET @strSQLQuery = @strSQLQuery     
            + ' and profile_basicinfo.MatrimonyClientID = '''     
            + @strMatrimonyClientID + ''''  
  
      --ADDING GENDER   
      SET @strSQLQuery = @strSQLQuery   
             + ' and profile_basicinfo.Gender = '''   
             + @strGender + ''''   
      --ADDING AGE   
      SET @strSQLQuery = @strSQLQuery   
             + ' and profile_basicinfo.Age >= '''   
             + Cast(@intFromAge AS VARCHAR(5)) + ''''   
             + ' and profile_basicinfo.Age <= '''   
             + Cast(@intToAge AS VARCHAR(5)) + ''''   
             
      --ADDING CASTE   
      IF @strCaste <> ''   
        SET @strSQLQuery = @strSQLQuery   
            + ' and profile_basicinfo.Caste = '''   
            + @strSubCaste + ''''  
            
        --ADDING SUBCASTE   
      IF @strSubCaste <> ''   
        SET @strSQLQuery = @strSQLQuery   
            + ' and profile_basicinfo.SubCaste = '''   
            + @strSubCaste + ''''   
  
      --ADDING STAR   
      IF @strStar <> ''  
        SET @strSQLQuery = @strSQLQuery   
            + ' and profile_basicinfo.Star = '''   
            + @strStar + ''''   
       SET @strSQLQuery = @strSQLQuery + ' ORDER BY profile_basicinfo.createddate '       
       print @strSQLQuery   
      EXECUTE Sp_executesql  @strSQLQuery   
   
        IF @localTran = 1 AND XACT_STATE() = 1  
            COMMIT TRAN LocalTran  
   
    END TRY  
    BEGIN CATCH  
   
        DECLARE @ErrorMessage NVARCHAR(4000)  
        DECLARE @ErrorSeverity INT  
        DECLARE @ErrorState INT  
   
        SELECT  @ErrorMessage = ERROR_MESSAGE(),  
                @ErrorSeverity = ERROR_SEVERITY(),  
                @ErrorState = ERROR_STATE()  
   
        IF @localTran = 1 AND XACT_STATE() <> 0  
            ROLLBACK TRAN  
   
        RAISERROR ( @ErrorMessage, @ErrorSeverity, @ErrorState)  
   
    END CATCH  
   
END

GO
/****** Object:  StoredProcedure [dbo].[uspGetActiveTab]    Script Date: 3/12/2015 9:38:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =================================================================================================
-- Author:      <ANAND JAYASEELAN>
-- Create date: <NOV 15 2013>
-- Description: <TO GET THE ACTIVE TAB OF THE LOGGEDIN USER AND DISPLAY THAT TAB SPECIFIC PAGE>
-- =================================================================================================
CREATE PROCEDURE [dbo].[uspGetActiveTab]
					(  
						@userID   VARCHAR(25)
					)   
AS
/*

Purpose:
	     TO GET THE ACTIVE TAB OF THE LOGGEDIN USER AND DISPLAY THAT TAB SPECIFIC PAGE
Assumptions:

Exceptions:
	InternalOperation

Version History:
	15 NOVEMBER  2013  ANAND.J		Phase 1.0	Initial version	
	
*/
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT,
        QUOTED_IDENTIFIER,
        ANSI_NULLS,
        ANSI_PADDING,
        ANSI_WARNINGS,
        ARITHABORT,
        CONCAT_NULL_YIELDS_NULL ON;
    SET NUMERIC_ROUNDABORT OFF;
 
    DECLARE @localTran bit
    IF @@TRANCOUNT = 0
    BEGIN
        SET @localTran = 1
        BEGIN TRANSACTION LocalTran
    END
 
    BEGIN TRY
 
			SELECT portal_ordertab.orderindex 
			FROM   portal_ordertab portal_ordertab WITH (nolock) 
			   INNER JOIN portal_defaulttab portal_defaulttab WITH (nolock) 
					   ON portal_ordertab.userid =  @userID
						  AND portal_defaulttab.user_id = @userID
						  AND portal_defaulttab.tab_id = portal_ordertab.tabid 
 
        IF @localTran = 1 AND XACT_STATE() = 1
            COMMIT TRAN LocalTran
 
    END TRY
    BEGIN CATCH
 
        DECLARE @ErrorMessage NVARCHAR(4000)
        DECLARE @ErrorSeverity INT
        DECLARE @ErrorState INT
 
        SELECT  @ErrorMessage = ERROR_MESSAGE(),
                @ErrorSeverity = ERROR_SEVERITY(),
                @ErrorState = ERROR_STATE()
 
        IF @localTran = 1 AND XACT_STATE() <> 0
            ROLLBACK TRAN
 
        RAISERROR ( @ErrorMessage, @ErrorSeverity, @ErrorState)
 
    END CATCH
 
END

GO
/****** Object:  StoredProcedure [dbo].[uspGetAdminLinks]    Script Date: 3/12/2015 9:38:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		ANAND JAYASEELAN
-- Create date: OCT 30 2013
-- Description: GETS THE ADMIN LINKS SPECIFIC TO USER
-- =============================================
CREATE PROCEDURE [dbo].[uspGetAdminLinks]
					(
						@userID   VARCHAR(30)
					)
AS
/*

Purpose:
	     GETS THE ADMIN LINKS SPECIFIC TO USER
Assumptions:

Exceptions:
	InternalOperation

Version History:
	30 OCTOBER  2013  ANAND.J		Phase 1.0	Initial version	
	
*/BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT,
        QUOTED_IDENTIFIER,
        ANSI_NULLS,
        ANSI_PADDING,
        ANSI_WARNINGS,
        ARITHABORT,
        CONCAT_NULL_YIELDS_NULL ON;
    SET NUMERIC_ROUNDABORT OFF;
 
    DECLARE @localTran bit
    IF @@TRANCOUNT = 0
    BEGIN
        SET @localTran = 1
        BEGIN TRANSACTION LocalTran
    END
 
    BEGIN TRY
					-- LEFT DIVISION
					   SELECT DISTINCT portal_administration.admin_id, 
								portal_administration.admin_name, 
								portal_administration.admin_link, 
								admin_help, 
								image_path, 
								division 
				FROM   portal_administration portal_administration WITH (nolock) 
					   INNER JOIN portal_admin_rights portal_admin_rights WITH (nolock) 
							   ON portal_admin_rights.admin_id = portal_administration.admin_id 
				WHERE  portal_admin_rights.admin_id IN (SELECT 
					   portal_admin_rights.admin_id AS admin_id 
														FROM 
					   portal_user portal_user WITH (nolock) 
					   INNER JOIN portal_admin_rights 
								  portal_admin_rights WITH ( 
								  nolock) 
							   ON portal_admin_rights.user_id = 
								  portal_user.user_id 
								  AND portal_user.user_id = @userID
														UNION ALL 
														SELECT 
					   portal_admin_rights.admin_id AS admin_id 
														FROM 
					   portal_group portal_group WITH (nolock) 
					   INNER JOIN portal_admin_rights 
								  portal_admin_rights WITH ( 
								  nolock) 
							   ON portal_group.group_id = 
								  portal_admin_rights.user_id 
					   INNER JOIN portal_user portal_user WITH 
								  (nolock) 
							   ON portal_user.user_id = 
								  portal_group.user_id 
								  AND portal_user.user_id = @userID 
														UNION ALL 
														SELECT 
					   portal_admin_rights.admin_id AS admin_id 
														FROM 
					   portal_role portal_role WITH (nolock) 
					   INNER JOIN portal_admin_rights 
								  portal_admin_rights WITH ( 
								  nolock) 
							   ON portal_role.role_id = 
								  portal_admin_rights.user_id 
					   INNER JOIN portal_user portal_user WITH 
								  (nolock) 
							   ON portal_user.user_id = 
								  portal_role.user_id 
								  AND portal_user.user_id = @userID) 
					   AND division = 1
				ORDER  BY portal_administration.admin_name 
				
				
				
				-- RIGHT DIVISION
				 SELECT DISTINCT portal_administration.admin_id, 
								portal_administration.admin_name, 
								portal_administration.admin_link, 
								admin_help, 
								image_path, 
								division 
				FROM   portal_administration portal_administration WITH (nolock) 
					   INNER JOIN portal_admin_rights portal_admin_rights WITH (nolock) 
							   ON portal_admin_rights.admin_id = portal_administration.admin_id 
				WHERE  portal_admin_rights.admin_id IN (SELECT 
					   portal_admin_rights.admin_id AS admin_id 
														FROM 
					   portal_user portal_user WITH (nolock) 
					   INNER JOIN portal_admin_rights 
								  portal_admin_rights WITH ( 
								  nolock) 
							   ON portal_admin_rights.user_id = 
								  portal_user.user_id 
								  AND portal_user.user_id = @userID
														UNION ALL 
														SELECT 
					   portal_admin_rights.admin_id AS admin_id 
														FROM 
					   portal_group portal_group WITH (nolock) 
					   INNER JOIN portal_admin_rights 
								  portal_admin_rights WITH ( 
								  nolock) 
							   ON portal_group.group_id = 
								  portal_admin_rights.user_id 
					   INNER JOIN portal_user portal_user WITH 
								  (nolock) 
							   ON portal_user.user_id = 
								  portal_group.user_id 
								  AND portal_user.user_id = @userID 
														UNION ALL 
														SELECT 
					   portal_admin_rights.admin_id AS admin_id 
														FROM 
					   portal_role portal_role WITH (nolock) 
					   INNER JOIN portal_admin_rights 
								  portal_admin_rights WITH ( 
								  nolock) 
							   ON portal_role.role_id = 
								  portal_admin_rights.user_id 
					   INNER JOIN portal_user portal_user WITH 
								  (nolock) 
							   ON portal_user.user_id = 
								  portal_role.user_id 
								  AND portal_user.user_id = @userID) 
					   AND division = 2
				ORDER  BY portal_administration.admin_name 
 
        IF @localTran = 1 AND XACT_STATE() = 1
            COMMIT TRAN LocalTran
 
    END TRY
    BEGIN CATCH
 
        DECLARE @ErrorMessage NVARCHAR(4000)
        DECLARE @ErrorSeverity INT
        DECLARE @ErrorState INT
 
        SELECT  @ErrorMessage = ERROR_MESSAGE(),
                @ErrorSeverity = ERROR_SEVERITY(),
                @ErrorState = ERROR_STATE()
 
        IF @localTran = 1 AND XACT_STATE() <> 0
            ROLLBACK TRAN
 
        RAISERROR ( @ErrorMessage, @ErrorSeverity, @ErrorState)
 
    END CATCH
 
END

GO
/****** Object:  StoredProcedure [dbo].[uspGetAdminLinksForAdminUser]    Script Date: 3/12/2015 9:38:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		ANAND JAYASEELAN
-- Create date: OCT 30 2013
-- Description: GETS THE ADMIN LINKS TO ADMIN USER
-- =============================================
CREATE PROCEDURE [dbo].[uspGetAdminLinksForAdminUser]
					
AS
/*

Purpose:
	     GETS THE ADMIN LINKS TO ADMIN USER
Assumptions:

Exceptions:
	InternalOperation

Version History:
	30 OCTOBER  2013  ANAND.J		Phase 1.0	Initial version	
	
*/BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT,
        QUOTED_IDENTIFIER,
        ANSI_NULLS,
        ANSI_PADDING,
        ANSI_WARNINGS,
        ARITHABORT,
        CONCAT_NULL_YIELDS_NULL ON;
    SET NUMERIC_ROUNDABORT OFF;
 
    DECLARE @localTran bit
    IF @@TRANCOUNT = 0
    BEGIN
        SET @localTran = 1
        BEGIN TRANSACTION LocalTran
    END
 
    BEGIN TRY
				SELECT DISTINCT admin_id, 
								admin_name, 
								admin_link, 
								admin_help, 
								image_path, 
								division 
				FROM   portal_administration WITH (nolock) 
				WHERE  division = 1 
				ORDER  BY admin_name 

				SELECT DISTINCT admin_id, 
								admin_name, 
								admin_link, 
								admin_help, 
								image_path, 
								division 
				FROM   portal_administration WITH (nolock) 
				WHERE  division = 2
				ORDER  BY admin_name 
				
        IF @localTran = 1 AND XACT_STATE() = 1
            COMMIT TRAN LocalTran
 
    END TRY
    BEGIN CATCH
 
        DECLARE @ErrorMessage NVARCHAR(4000)
        DECLARE @ErrorSeverity INT
        DECLARE @ErrorState INT
 
        SELECT  @ErrorMessage = ERROR_MESSAGE(),
                @ErrorSeverity = ERROR_SEVERITY(),
                @ErrorState = ERROR_STATE()
 
        IF @localTran = 1 AND XACT_STATE() <> 0
            ROLLBACK TRAN
 
        RAISERROR ( @ErrorMessage, @ErrorSeverity, @ErrorState)
 
    END CATCH
 
END

GO
/****** Object:  StoredProcedure [dbo].[uspGetAdminSubLinks]    Script Date: 3/12/2015 9:38:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		ANAND JAYASEELAN
-- Create date: OCT 30 2013
-- Description: GETS THE ADMIN SUB LINKS SPECIFIC TO USER
-- =============================================
CREATE PROCEDURE [dbo].[uspGetAdminSubLinks]
					(
						@adminLinkID   VARCHAR(30)
					)
AS
/*

Purpose:
	     GETS THE ADMIN SUB LINKS SPECIFIC TO USER
Assumptions:

Exceptions:
	InternalOperation

Version History:
	30 OCTOBER  2013  ANAND.J		Phase 1.0	Initial version	
	
*/BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT,
        QUOTED_IDENTIFIER,
        ANSI_NULLS,
        ANSI_PADDING,
        ANSI_WARNINGS,
        ARITHABORT,
        CONCAT_NULL_YIELDS_NULL ON;
    SET NUMERIC_ROUNDABORT OFF;
 
    DECLARE @localTran bit
    IF @@TRANCOUNT = 0
    BEGIN
        SET @localTran = 1
        BEGIN TRANSACTION LocalTran
    END
 
    BEGIN TRY
			SELECT adminlinkid, 
					sublinkid, 
					name, 
					url, 
					imagepath, 
					help 
			FROM   portal_adminsublinks WITH (nolock) 
			WHERE  adminlinkid = @adminLinkID

        IF @localTran = 1 AND XACT_STATE() = 1
            COMMIT TRAN LocalTran
 
    END TRY
    BEGIN CATCH
 
        DECLARE @ErrorMessage NVARCHAR(4000)
        DECLARE @ErrorSeverity INT
        DECLARE @ErrorState INT
 
        SELECT  @ErrorMessage = ERROR_MESSAGE(),
                @ErrorSeverity = ERROR_SEVERITY(),
                @ErrorState = ERROR_STATE()
 
        IF @localTran = 1 AND XACT_STATE() <> 0
            ROLLBACK TRAN
 
        RAISERROR ( @ErrorMessage, @ErrorSeverity, @ErrorState)
 
    END CATCH
 
END

GO
/****** Object:  StoredProcedure [dbo].[uspGetTabs]    Script Date: 3/12/2015 9:38:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =================================================================================================
-- Author:      <ANAND JAYASEELAN>
-- Create date: <NOV 15 2013>
-- Description: <TO GET THE ASSOCIATED TAB OF THE LOGGEDIN USER> 
-- =================================================================================================
CREATE PROCEDURE [dbo].[uspGetTabs]
					(  
						@userID   VARCHAR(25)
					)   
AS
/*

Purpose:
	      TO GET THE ASSOCIATED TAB OF THE LOGGEDIN USER
Assumptions:

Exceptions:
	InternalOperation

Version History:
	15 NOVEMBER  2013  ANAND.J		Phase 1.0	Initial version	
	
*/
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT,
        QUOTED_IDENTIFIER,
        ANSI_NULLS,
        ANSI_PADDING,
        ANSI_WARNINGS,
        ARITHABORT,
        CONCAT_NULL_YIELDS_NULL ON;
    SET NUMERIC_ROUNDABORT OFF;
 
    DECLARE @localTran bit
    IF @@TRANCOUNT = 0
    BEGIN
        SET @localTran = 1
        BEGIN TRANSACTION LocalTran
    END
 
    BEGIN TRY
 
						SELECT portal_tab_master.tab_id, 
				   portal_tab_master.tab_name, 
				   portal_tab_master.tab_link, 
				   portal_tab_master.tab_type, 
				   portal_tab_master.istag, 
				   Isnull(portal_ordertab.orderindex, 200) tabindex 
			FROM   (SELECT portal_tab_master.tab_id, 
						   portal_tab_master.tab_name, 
						   portal_tab_master.tab_link, 
						   portal_tab_master.tab_type, 
						   portal_tab_master.istag 
					FROM   portal_tab_master portal_tab_master WITH (nolock) 
					WHERE  portal_tab_master.tab_id IN (SELECT 
						   portal_tab_rights.tab_id AS tab_id 
														FROM 
						   portal_user portal_user WITH (nolock 
						   ) 
						   INNER JOIN portal_tab_rights 
									  portal_tab_rights WITH ( 
									  nolock) 
								   ON portal_tab_rights.user_id 
									  = 
									  portal_user.user_id 
									  AND portal_user.user_id = 
										  @userID 
														UNION ALL 
														SELECT 
						   portal_tab_rights.tab_id AS tab_id 
														FROM 
						   portal_group portal_group WITH (nolock) 
						   INNER JOIN portal_tab_rights 
									  portal_tab_rights WITH (nolock) 
								   ON portal_group.group_id = 
									  portal_tab_rights.user_id 
						   INNER JOIN portal_user portal_user WITH ( 
									  nolock) 
								   ON portal_user.user_id = 
									  portal_group.user_id 
									  AND portal_user.user_id = 
										  @userID 
														UNION ALL 
														SELECT 
						   portal_tab_rights.tab_id AS tab_id 
														FROM 
						   portal_role portal_role WITH (nolock 
						   ) 
						   INNER JOIN portal_tab_rights 
									  portal_tab_rights WITH ( 
									  nolock) 
								   ON portal_role.role_id = 
									  portal_tab_rights.user_id 
						   INNER JOIN portal_user portal_user 
									  WITH ( 
									  nolock) 
								   ON portal_user.user_id = 
									  portal_role.user_id 
									  AND portal_user.user_id = 
										  @userID)) portal_tab_master 
				   LEFT OUTER JOIN portal_ordertab portal_ordertab 
								ON portal_ordertab.tabid = portal_tab_master.tab_id 
								   AND portal_ordertab.userid IN (SELECT 
									   portal_user.user_id AS user_id 
																  FROM 
									   portal_user portal_user WITH (nolock) 
									   INNER JOIN portal_tab_rights 
												  portal_tab_rights 
												  WITH (nolock) 
											   ON portal_tab_rights.user_id = 
												  portal_user.user_id 
												  AND portal_user.user_id = 
													  @userID 
																  UNION ALL 
																  SELECT 
									   portal_group.group_id AS group_id 
																  FROM 
									   portal_group portal_group WITH (nolock) 
									   INNER JOIN portal_tab_rights 
												  portal_tab_rights 
												  WITH (nolock) 
											   ON portal_group.group_id = 
												  portal_tab_rights.user_id 
									   INNER JOIN portal_user portal_user WITH ( 
												  nolock) 
											   ON portal_user.user_id = 
												  portal_group.user_id 
												  AND portal_user.user_id = 
													  @userID 
																  UNION ALL 
																  SELECT 
									   portal_role.role_id AS role_id 
																  FROM 
									   portal_role portal_role WITH (nolock) 
									   INNER JOIN portal_tab_rights 
												  portal_tab_rights 
												  WITH (nolock) 
											   ON portal_role.role_id = 
												  portal_tab_rights.user_id 
									   INNER JOIN portal_user portal_user WITH ( 
												  nolock) 
											   ON portal_user.user_id = 
												  portal_role.user_id 
												  AND portal_user.user_id = 
													  @userID) 
			ORDER  BY tabindex, 
					  tab_name 
 
        IF @localTran = 1 AND XACT_STATE() = 1
            COMMIT TRAN LocalTran
 
    END TRY
    BEGIN CATCH
 
        DECLARE @ErrorMessage NVARCHAR(4000)
        DECLARE @ErrorSeverity INT
        DECLARE @ErrorState INT
 
        SELECT  @ErrorMessage = ERROR_MESSAGE(),
                @ErrorSeverity = ERROR_SEVERITY(),
                @ErrorState = ERROR_STATE()
 
        IF @localTran = 1 AND XACT_STATE() <> 0
            ROLLBACK TRAN
 
        RAISERROR ( @ErrorMessage, @ErrorSeverity, @ErrorState)
 
    END CATCH
 
END

GO
/****** Object:  StoredProcedure [dbo].[uspInitializeUser]    Script Date: 3/12/2015 9:38:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =================================================================================
-- Author:      <ANAND JAYASEELAN>
-- Create date: <OCT 29 2013>
-- Description: <TO GET ALL THE VALUES FROM DIFFERENT SOURCE FOR THE LOGGED IN USER>
-- ================================================================================
CREATE PROCEDURE [dbo].[uspInitializeUser]
					(  
						@userName   VARCHAR(85)
					)   
AS
/*

Purpose:
	     TO GET ALL THE VALUES FROM DIFFERENT SOURCE FOR THE LOGGED IN USER
Assumptions:

Exceptions:
	InternalOperation

Version History:
	29 OCTOBER  2013  ANAND.J		Phase 1.0	Initial version	
	
*/
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT,
        QUOTED_IDENTIFIER,
        ANSI_NULLS,
        ANSI_PADDING,
        ANSI_WARNINGS,
        ARITHABORT,
        CONCAT_NULL_YIELDS_NULL ON;
    SET NUMERIC_ROUNDABORT OFF;
 
    DECLARE @localTran bit
    IF @@TRANCOUNT = 0
    BEGIN
        SET @localTran = 1
        BEGIN TRANSACTION LocalTran
    END
 
    BEGIN TRY
 
			  SELECT portal_user.user_id      user_id, 
			   portal_user.user_name    user_name, 
			   portal_user.login_name   login_name, 
			   portal_user.is_activated is_activated, 
			   portal_user.is_locked    islocked, 
			   portal_user.is_admin     isadmin, 
			   portal_skin.skin_name    user_theme, 
			   prof_user.prof_language  user_locale, 
			   portal_locale.smprovider smprovider, 
			   prof_user.empid, 
			   portal_user.sex, 
			   prof_user.photo_path, 
			   portal_role_master.role_name, 
			   portal_role_master.role_id, 
			   portal_role_master.role_level, 
			   portal_user.matrimonyclientid, 
			   portal_clients.clientname,
			   portal_banner.logopath,
			   portal_banner.bannerpath,
			   portal_banner.welcomenote       
		FROM   portal_user portal_user WITH (nolock) 
			   LEFT OUTER JOIN prof_user prof_user WITH (nolock) 
							ON prof_user.user_id = portal_user.user_id 
			   LEFT OUTER JOIN portal_skin portal_skin WITH (nolock) 
							ON portal_skin.skin_id = prof_user.theme 
			   LEFT OUTER JOIN portal_locale portal_locale WITH (nolock) 
							ON portal_locale.locale_id = prof_user.prof_language 
			   LEFT OUTER JOIN portal_role portal_role WITH (nolock) 
							ON portal_role.user_id = portal_user.user_id 
			   LEFT OUTER JOIN portal_role_master portal_role_master WITH (nolock) 
							ON portal_role_master.role_id = portal_role.role_id 
			   LEFT OUTER JOIN portal_clients portal_clients WITH (nolock) 
							ON portal_clients.clientid = portal_user.matrimonyclientid 
			   LEFT OUTER JOIN portal_banner portal_banner WITH (nolock) ON portal_banner.user_id = portal_user.user_id 
		WHERE  portal_user.login_name = @userName
 
        IF @localTran = 1 AND XACT_STATE() = 1
            COMMIT TRAN LocalTran
 
    END TRY
    BEGIN CATCH
 
        DECLARE @ErrorMessage NVARCHAR(4000)
        DECLARE @ErrorSeverity INT
        DECLARE @ErrorState INT
 
        SELECT  @ErrorMessage = ERROR_MESSAGE(),
                @ErrorSeverity = ERROR_SEVERITY(),
                @ErrorState = ERROR_STATE()
 
        IF @localTran = 1 AND XACT_STATE() <> 0
            ROLLBACK TRAN
 
        RAISERROR ( @ErrorMessage, @ErrorSeverity, @ErrorState)
 
    END CATCH
 
END

GO
/****** Object:  StoredProcedure [dbo].[uspSangamSearch]    Script Date: 3/12/2015 9:38:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:      <ANAND JAYASEELAN>
-- Create date: <NOV 12 2013>
-- Description: <SANGAM SEARCH DYNAMIC SQL>
-- =============================================
CREATE PROCEDURE [dbo].[uspSangamSearch]
									(
										@strSangamID varchar(30)										
									)	
AS
BEGIN

	DECLARE @strSQLQuery AS NVARCHAR(4000) 

    SET NOCOUNT ON;
    SET XACT_ABORT,
        QUOTED_IDENTIFIER,
        ANSI_NULLS,
        ANSI_PADDING,
        ANSI_WARNINGS,
        ARITHABORT,
        CONCAT_NULL_YIELDS_NULL ON;
    SET NUMERIC_ROUNDABORT OFF;
 
    DECLARE @localTran bit
    IF @@TRANCOUNT = 0
    BEGIN
        SET @localTran = 1
        BEGIN TRANSACTION LocalTran
    END
 
    BEGIN TRY
 
						SET @strSQLQuery = 
										   'SELECT elanprofileid, 
											profile_basicinfo.profileid, 
											name, 
											age, 
											gender, 
											dateofbirth, 
											tamildob, 
											timeofbirth, 
											placeofbirth, 
											maritalstatus, 
											noofchildren, 
											childrenlivingstatus, 
											height, 
											weight, 
											bodytype, 
											complexion, 
											physicalstatus, 
											bloodgroup, 
											mothertongue, 
											profilecreatedby, 
											religion, 
											caste, 
											subcaste, 
											acceptothernaidu, 
											gothram, 
											star, 
											raasi, 
											zodiac, 
											horoscopematch, 
											anydosham, 
											eating, 
											smoking, 
											drinking, 
											aboutme, 
											partnerexpectations, 
											createdby, 
											createddate, 
											zodiacyear, 
											zodiacmonth, 
											zodiacday, 
											profile_basicinfo.matrimonyclientid, 
											profile_carrier.education,
											profile_carrier.Occupation,
											ResidingCity,
											ResidingState,
											CountryLivingIn,
											portal_clients.clientname,
											Profile_Photo.Extension 
											FROM   
													portal_user portal_user WITH (nolock) 
													INNER JOIN profile_basicinfo profile_basicinfo WITH (nolock) 
													ON portal_user.matrimonyclientid = ''' + @strSangamID + ''' AND
													portal_user.is_activated = 0 and profile_basicinfo.ProfileID = portal_user.login_name 														
													INNER JOIN portal_clients portal_clients WITH (nolock) 													
													ON portal_clients.clientid = profile_basicinfo.matrimonyclientid 
													LEFT OUTER JOIN profile_carrier Profile_Carrier 
													ON profile_carrier.profileid = profile_basicinfo.profileid 
													LEFT OUTER JOIN Profile_LocationInfo Profile_LocationInfo 
													ON Profile_LocationInfo.profileid = profile_basicinfo.profileid 
													LEFT OUTER JOIN Profile_Photo Profile_Photo 
													ON Profile_Photo.profileid = profile_basicinfo.profileid 
													
											WHERE  1 = 1 											
											ORDER BY profile_basicinfo.createddate '
						EXECUTE Sp_executesql  @strSQLQuery 
 
        IF @localTran = 1 AND XACT_STATE() = 1
            COMMIT TRAN LocalTran
 
    END TRY
    BEGIN CATCH
 
        DECLARE @ErrorMessage NVARCHAR(4000)
        DECLARE @ErrorSeverity INT
        DECLARE @ErrorState INT
 
        SELECT  @ErrorMessage = ERROR_MESSAGE(),
                @ErrorSeverity = ERROR_SEVERITY(),
                @ErrorState = ERROR_STATE()
 
        IF @localTran = 1 AND XACT_STATE() <> 0
            ROLLBACK TRAN
 
        RAISERROR ( @ErrorMessage, @ErrorSeverity, @ErrorState)
 
    END CATCH
 
END

GO
/****** Object:  Table [dbo].[disc_master]    Script Date: 3/12/2015 9:38:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[disc_master](
	[disc_id] [varchar](20) NOT NULL,
	[forum_name] [nvarchar](50) NULL,
	[forum_desc] [nvarchar](500) NULL,
	[moderator] [varchar](20) NULL,
	[created_date] [datetime] NULL,
 CONSTRAINT [PK_disc_master] PRIMARY KEY CLUSTERED 
(
	[disc_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[disc_privilege]    Script Date: 3/12/2015 9:38:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[disc_privilege](
	[disc_id] [nvarchar](20) NOT NULL,
	[user_id] [nvarchar](20) NOT NULL,
 CONSTRAINT [PK_disc_privilege] PRIMARY KEY CLUSTERED 
(
	[disc_id] ASC,
	[user_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[disc_replythread]    Script Date: 3/12/2015 9:38:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[disc_replythread](
	[thread_id] [varchar](20) NOT NULL,
	[reply_id] [varchar](20) NOT NULL,
	[reply_author] [varchar](20) NULL,
	[replied_date] [datetime] NULL,
	[reply_msg] [nvarchar](2000) NULL,
 CONSTRAINT [PK_disc_replythread] PRIMARY KEY CLUSTERED 
(
	[reply_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[disc_thread_master]    Script Date: 3/12/2015 9:38:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[disc_thread_master](
	[thread_id] [varchar](20) NOT NULL,
	[thread_author] [varchar](20) NULL,
	[created_date] [datetime] NULL,
	[disc_id] [varchar](20) NULL,
	[topic] [nvarchar](100) NULL,
	[message] [nvarchar](2000) NULL,
 CONSTRAINT [PK_disc_thread_master] PRIMARY KEY CLUSTERED 
(
	[thread_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[elan_companies]    Script Date: 3/12/2015 9:38:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[elan_companies](
	[company_id] [varchar](20) NULL,
	[company_name] [varchar](100) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[event_category]    Script Date: 3/12/2015 9:38:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[event_category](
	[event_cateid] [varchar](20) NOT NULL,
	[event_catename] [nvarchar](150) NULL,
	[created_by] [varchar](20) NULL,
	[created_date] [datetime] NULL,
	[image_path] [nvarchar](300) NULL,
	[description] [nvarchar](2000) NULL,
	[event_date] [datetime] NULL,
 CONSTRAINT [PK__event_category__681373AD] PRIMARY KEY CLUSTERED 
(
	[event_cateid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[event_holidays]    Script Date: 3/12/2015 9:38:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[event_holidays](
	[holiday_id] [varchar](20) NOT NULL,
	[holiday_name] [varchar](150) NULL,
	[holiday_from] [datetime] NULL,
	[holiday_to] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[holiday_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[lookup_tempdata]    Script Date: 3/12/2015 9:38:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[lookup_tempdata](
	[id] [nvarchar](20) NOT NULL,
	[type_id] [nvarchar](20) NOT NULL,
	[type_name] [nvarchar](150) NULL,
	[type] [nvarchar](50) NULL,
 CONSTRAINT [PK_lookup_tempdata] PRIMARY KEY CLUSTERED 
(
	[id] ASC,
	[type_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[monthly_view]    Script Date: 3/12/2015 9:38:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[monthly_view](
	[dates] [datetime] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[msg_intramail]    Script Date: 3/12/2015 9:38:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[msg_intramail](
	[mail_id] [varchar](20) NOT NULL,
	[mail_from] [varchar](150) NOT NULL,
	[mail_subject] [nvarchar](200) NULL,
	[mail_body] [nvarchar](50) NULL,
	[mail_for] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_msg_intramail] PRIMARY KEY CLUSTERED 
(
	[mail_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[msg_intramail_master]    Script Date: 3/12/2015 9:38:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[msg_intramail_master](
	[msg_id] [varchar](20) NOT NULL,
	[subject] [nvarchar](150) NULL,
	[body] [nvarchar](50) NULL,
	[sender] [varchar](20) NULL,
	[sent_date] [datetime] NULL,
 CONSTRAINT [PK_msg_intramail_master] PRIMARY KEY CLUSTERED 
(
	[msg_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[msg_intramailrights]    Script Date: 3/12/2015 9:38:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[msg_intramailrights](
	[mail_id] [varchar](20) NOT NULL,
	[user_id] [varchar](20) NOT NULL,
 CONSTRAINT [PK_msg_intramailrights] PRIMARY KEY CLUSTERED 
(
	[mail_id] ASC,
	[user_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[poll_master]    Script Date: 3/12/2015 9:38:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[poll_master](
	[poll_id] [varchar](20) NOT NULL,
	[poll_title] [nvarchar](100) NULL,
	[poll_startdate] [datetime] NULL,
	[poll_enddate] [datetime] NULL,
	[poll_creator] [varchar](20) NULL,
	[poll_createddate] [datetime] NULL,
 CONSTRAINT [PK__poll_master__5535A963] PRIMARY KEY CLUSTERED 
(
	[poll_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[poll_nominee]    Script Date: 3/12/2015 9:38:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[poll_nominee](
	[poll_id] [varchar](20) NOT NULL,
	[nominee_name] [nvarchar](200) NOT NULL,
	[nominee_id] [varchar](20) NOT NULL,
 CONSTRAINT [PK_poll_nominee] PRIMARY KEY CLUSTERED 
(
	[poll_id] ASC,
	[nominee_name] ASC,
	[nominee_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[poll_reporttable]    Script Date: 3/12/2015 9:38:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[poll_reporttable](
	[rate] [nvarchar](50) NULL,
	[vote] [numeric](18, 0) NULL,
	[poll_id] [nvarchar](20) NULL,
	[primaryid] [nvarchar](20) NOT NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[poll_user]    Script Date: 3/12/2015 9:38:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[poll_user](
	[poll_id] [varchar](20) NOT NULL,
	[user_id] [varchar](20) NOT NULL,
 CONSTRAINT [PK__poll_user__02084FDA] PRIMARY KEY CLUSTERED 
(
	[poll_id] ASC,
	[user_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[poll_vote]    Script Date: 3/12/2015 9:38:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[poll_vote](
	[poll_id] [varchar](20) NOT NULL,
	[nominee_id] [varchar](20) NOT NULL,
	[poll_userid] [varchar](20) NOT NULL,
	[poll_uservoted] [numeric](18, 0) NULL,
	[poll_voteddate] [datetime] NULL,
 CONSTRAINT [PK_poll_vote] PRIMARY KEY CLUSTERED 
(
	[poll_id] ASC,
	[poll_userid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[portal_admin_rights]    Script Date: 3/12/2015 9:38:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[portal_admin_rights](
	[admin_id] [varchar](20) NOT NULL,
	[user_id] [varchar](20) NOT NULL,
 CONSTRAINT [PK_portal_admin_rights] PRIMARY KEY CLUSTERED 
(
	[admin_id] ASC,
	[user_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[portal_administration]    Script Date: 3/12/2015 9:38:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[portal_administration](
	[admin_id] [varchar](20) NOT NULL,
	[admin_name] [nvarchar](200) NULL,
	[admin_link] [varchar](200) NULL,
	[admin_help] [varchar](500) NULL,
	[image_path] [nvarchar](200) NULL,
	[division] [numeric](18, 0) NULL,
 CONSTRAINT [PK_portal_administration] PRIMARY KEY CLUSTERED 
(
	[admin_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[portal_adminsublinks]    Script Date: 3/12/2015 9:38:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[portal_adminsublinks](
	[adminlinkid] [nvarchar](20) NULL,
	[sublinkid] [nvarchar](20) NOT NULL,
	[name] [nvarchar](150) NULL,
	[url] [nvarchar](251) NULL,
	[imagepath] [nvarchar](200) NULL,
	[help] [nvarchar](200) NULL,
 CONSTRAINT [PK_portal_adminsublinks] PRIMARY KEY CLUSTERED 
(
	[sublinkid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[portal_application_modules]    Script Date: 3/12/2015 9:38:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[portal_application_modules](
	[moduleid] [nvarchar](20) NOT NULL,
	[sublinkid] [nvarchar](20) NOT NULL,
	[name] [nvarchar](150) NULL,
	[url] [nvarchar](251) NULL,
	[imagepath] [nvarchar](200) NULL,
	[help] [nvarchar](200) NULL,
 CONSTRAINT [PK_portal_application_modules] PRIMARY KEY CLUSTERED 
(
	[sublinkid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[portal_applications]    Script Date: 3/12/2015 9:38:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[portal_applications](
	[applicationid] [varchar](20) NOT NULL,
	[application_name] [nvarchar](200) NULL,
	[application_link] [varchar](200) NULL,
	[application_help] [varchar](500) NULL,
	[image_path] [nvarchar](200) NULL,
	[division] [numeric](18, 0) NULL,
	[moduleid] [varchar](20) NOT NULL,
 CONSTRAINT [PK_portal_applications] PRIMARY KEY CLUSTERED 
(
	[moduleid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[portal_banner]    Script Date: 3/12/2015 9:38:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[portal_banner](
	[user_id] [nvarchar](20) NOT NULL,
	[logopath] [nvarchar](200) NULL,
	[bannerpath] [nvarchar](200) NULL,
	[welcomenote] [nvarchar](100) NULL,
 CONSTRAINT [PK_portal_banner] PRIMARY KEY CLUSTERED 
(
	[user_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[portal_clients]    Script Date: 3/12/2015 9:38:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[portal_clients](
	[clientid] [varchar](20) NOT NULL,
	[clientname] [nvarchar](50) NULL,
	[descr] [nvarchar](50) NULL,
	[crdate] [datetime] NULL,
	[ClientTag] [varchar](20) NOT NULL,
	[ContactPerson] [nvarchar](50) NULL,
	[ContactNumber] [varchar](50) NULL,
	[ContactEmail] [varchar](100) NULL,
	[CasteID] [varchar](20) NOT NULL,
 CONSTRAINT [PK_portal_clients] PRIMARY KEY CLUSTERED 
(
	[clientid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[portal_company]    Script Date: 3/12/2015 9:38:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[portal_company](
	[company_id] [varchar](20) NOT NULL,
	[company_name] [varchar](100) NULL,
	[registered_date] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[company_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[portal_defaulttab]    Script Date: 3/12/2015 9:38:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[portal_defaulttab](
	[user_id] [varchar](20) NOT NULL,
	[tab_id] [varchar](20) NOT NULL,
 CONSTRAINT [PK_portal_defaulttab] PRIMARY KEY CLUSTERED 
(
	[user_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[portal_department]    Script Date: 3/12/2015 9:38:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[portal_department](
	[department_id] [varchar](20) NOT NULL,
	[user_id] [varchar](20) NOT NULL,
 CONSTRAINT [PK_portal_department] PRIMARY KEY CLUSTERED 
(
	[department_id] ASC,
	[user_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[portal_department_master]    Script Date: 3/12/2015 9:38:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[portal_department_master](
	[department_id] [varchar](20) NOT NULL,
	[department_name] [nvarchar](250) NULL,
	[created_by] [varchar](20) NULL,
	[created_date] [datetime] NULL,
 CONSTRAINT [PK_portal_department_master] PRIMARY KEY CLUSTERED 
(
	[department_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[portal_emptype]    Script Date: 3/12/2015 9:38:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[portal_emptype](
	[emptype_id] [varchar](20) NOT NULL,
	[user_id] [varchar](20) NOT NULL,
 CONSTRAINT [PK_portal_employee] PRIMARY KEY CLUSTERED 
(
	[emptype_id] ASC,
	[user_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[portal_emptype_master]    Script Date: 3/12/2015 9:38:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[portal_emptype_master](
	[emptype_id] [varchar](20) NOT NULL,
	[emp_type] [nvarchar](100) NULL,
	[created_by] [varchar](20) NULL,
	[created_date] [datetime] NULL,
 CONSTRAINT [PK__portal_emp_maste__4F7CD00D] PRIMARY KEY CLUSTERED 
(
	[emptype_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[portal_group]    Script Date: 3/12/2015 9:38:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[portal_group](
	[group_id] [varchar](20) NOT NULL,
	[user_id] [varchar](20) NOT NULL,
 CONSTRAINT [PK__portal_group__32E0915F] PRIMARY KEY CLUSTERED 
(
	[group_id] ASC,
	[user_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[portal_group_master]    Script Date: 3/12/2015 9:38:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[portal_group_master](
	[group_id] [varchar](20) NOT NULL,
	[group_name] [nvarchar](100) NULL,
	[created_by] [varchar](50) NULL,
	[created_date] [datetime] NULL,
 CONSTRAINT [PK__portal_group_mas__2E1BDC42] PRIMARY KEY CLUSTERED 
(
	[group_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[portal_holidays]    Script Date: 3/12/2015 9:38:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[portal_holidays](
	[holidayid] [varchar](20) NOT NULL,
	[date] [datetime] NULL,
	[day] [nvarchar](50) NULL,
	[description] [nvarchar](50) NULL,
	[crdate] [datetime] NULL,
 CONSTRAINT [PK_portal_holidays] PRIMARY KEY CLUSTERED 
(
	[holidayid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[portal_licence]    Script Date: 3/12/2015 9:38:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[portal_licence](
	[company_id] [varchar](20) NULL,
	[licence_key] [varchar](500) NOT NULL,
	[licence_updated] [datetime] NULL,
	[licence_no] [numeric](18, 0) NULL,
 CONSTRAINT [PK__portal_licence__3C69FB99] PRIMARY KEY CLUSTERED 
(
	[licence_key] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[portal_locale]    Script Date: 3/12/2015 9:38:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[portal_locale](
	[locale_id] [varchar](20) NOT NULL,
	[locale] [nvarchar](50) NULL,
	[smprovider] [nvarchar](50) NULL,
	[lcid] [varchar](50) NOT NULL,
 CONSTRAINT [PK__portal_locale__6EC0713C] PRIMARY KEY CLUSTERED 
(
	[locale_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[portal_location]    Script Date: 3/12/2015 9:38:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[portal_location](
	[location_id] [varchar](20) NOT NULL,
	[user_id] [varchar](20) NOT NULL,
 CONSTRAINT [PK_portal_location] PRIMARY KEY CLUSTERED 
(
	[location_id] ASC,
	[user_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[portal_location_master]    Script Date: 3/12/2015 9:38:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[portal_location_master](
	[location_id] [varchar](20) NOT NULL,
	[location_name] [nvarchar](100) NULL,
	[created_by] [varchar](20) NULL,
	[created_date] [datetime] NULL,
 CONSTRAINT [PK_portal_location_master] PRIMARY KEY CLUSTERED 
(
	[location_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[portal_modules]    Script Date: 3/12/2015 9:38:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[portal_modules](
	[module_id] [varchar](20) NOT NULL,
	[module_name] [nvarchar](100) NULL,
	[mid] [varchar](20) NULL,
 CONSTRAINT [PK__portal_modules__68487DD7] PRIMARY KEY CLUSTERED 
(
	[module_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[portal_month]    Script Date: 3/12/2015 9:38:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[portal_month](
	[month_no] [numeric](8, 0) NOT NULL,
	[month_name] [varchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[month_no] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[portal_news]    Script Date: 3/12/2015 9:38:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[portal_news](
	[newsid] [nvarchar](20) NOT NULL,
	[creator] [nvarchar](20) NULL,
	[created_date] [datetime] NULL,
	[content] [ntext] NULL,
	[title] [nvarchar](150) NULL,
 CONSTRAINT [PK_portal_news] PRIMARY KEY CLUSTERED 
(
	[newsid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[portal_ordertab]    Script Date: 3/12/2015 9:38:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[portal_ordertab](
	[tabid] [varchar](20) NOT NULL,
	[userid] [varchar](20) NOT NULL,
	[orderindex] [numeric](18, 0) NULL,
 CONSTRAINT [PK_portal_ordertab] PRIMARY KEY CLUSTERED 
(
	[tabid] ASC,
	[userid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[portal_projects]    Script Date: 3/12/2015 9:38:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[portal_projects](
	[projectid] [varchar](20) NOT NULL,
	[projectname] [nvarchar](50) NULL,
	[descr] [nvarchar](50) NULL,
	[crdate] [datetime] NULL,
 CONSTRAINT [PK_portal_projects] PRIMARY KEY CLUSTERED 
(
	[projectid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[portal_reportingto]    Script Date: 3/12/2015 9:38:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[portal_reportingto](
	[userid] [nvarchar](20) NOT NULL,
	[reportingto] [nvarchar](20) NOT NULL,
	[reproleid] [nvarchar](20) NOT NULL,
 CONSTRAINT [PK_portal_reportingto] PRIMARY KEY CLUSTERED 
(
	[userid] ASC,
	[reportingto] ASC,
	[reproleid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[portal_role]    Script Date: 3/12/2015 9:38:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[portal_role](
	[role_id] [varchar](20) NOT NULL,
	[user_id] [varchar](20) NOT NULL,
 CONSTRAINT [PK_portal_role] PRIMARY KEY CLUSTERED 
(
	[role_id] ASC,
	[user_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[portal_role_master]    Script Date: 3/12/2015 9:38:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[portal_role_master](
	[role_id] [varchar](20) NOT NULL,
	[role_name] [nvarchar](100) NULL,
	[role_level] [decimal](18, 0) NULL,
	[created_by] [varchar](50) NULL,
	[created_date] [datetime] NULL,
	[id] [numeric](18, 0) NULL,
	[pid] [numeric](18, 0) NULL,
 CONSTRAINT [PK__portal_role_mast__300424B4] PRIMARY KEY CLUSTERED 
(
	[role_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[portal_rssfeed]    Script Date: 3/12/2015 9:38:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[portal_rssfeed](
	[feed_id] [varchar](20) NOT NULL,
	[feed_name] [nvarchar](100) NULL,
	[feed_url] [nvarchar](300) NULL,
	[user_id] [varchar](20) NULL,
	[feed_date] [datetime] NULL,
 CONSTRAINT [PK_portal_rssfeed] PRIMARY KEY CLUSTERED 
(
	[feed_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[portal_rssfeed_rights]    Script Date: 3/12/2015 9:38:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[portal_rssfeed_rights](
	[feed_id] [varchar](20) NOT NULL,
	[user_id] [varchar](20) NOT NULL,
 CONSTRAINT [PK_portal_rssfeed_rights] PRIMARY KEY CLUSTERED 
(
	[feed_id] ASC,
	[user_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[portal_session]    Script Date: 3/12/2015 9:38:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[portal_session](
	[session_id] [nvarchar](20) NOT NULL,
	[login_time] [datetime] NULL,
	[logout_time] [datetime] NULL,
	[terminated_time] [datetime] NULL,
	[is_terminated] [numeric](18, 0) NULL,
	[user_id] [nvarchar](20) NULL,
 CONSTRAINT [PK_portal_session] PRIMARY KEY CLUSTERED 
(
	[session_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[portal_skin]    Script Date: 3/12/2015 9:38:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[portal_skin](
	[skin_id] [varchar](20) NOT NULL,
	[skin_name] [nvarchar](100) NULL,
 CONSTRAINT [PK__portal_skin__797309D9] PRIMARY KEY CLUSTERED 
(
	[skin_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[portal_subroles]    Script Date: 3/12/2015 9:38:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[portal_subroles](
	[roleid] [varchar](20) NOT NULL,
	[subroleid] [varchar](20) NOT NULL,
 CONSTRAINT [PK_portal_subroles] PRIMARY KEY CLUSTERED 
(
	[roleid] ASC,
	[subroleid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[portal_tab_master]    Script Date: 3/12/2015 9:38:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[portal_tab_master](
	[tab_id] [varchar](20) NOT NULL,
	[tab_name] [nvarchar](100) NULL,
	[tab_link] [nvarchar](600) NULL,
	[tab_creator] [varchar](20) NULL,
	[tab_createddate] [datetime] NULL,
	[tab_type] [int] NOT NULL,
	[isdefault] [numeric](18, 0) NULL,
	[istag] [numeric](18, 0) NULL,
	[langtext] [varchar](50) NULL,
 CONSTRAINT [PK_portal_tab_master] PRIMARY KEY CLUSTERED 
(
	[tab_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[portal_tab_rights]    Script Date: 3/12/2015 9:38:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[portal_tab_rights](
	[tab_id] [varchar](20) NOT NULL,
	[user_id] [varchar](20) NOT NULL,
 CONSTRAINT [PK__portal_tab_right__2C3393D0] PRIMARY KEY CLUSTERED 
(
	[tab_id] ASC,
	[user_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[portal_user]    Script Date: 3/12/2015 9:38:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[portal_user](
	[user_id] [varchar](20) NOT NULL,
	[user_name] [nvarchar](200) NULL,
	[login_name] [nvarchar](100) NOT NULL,
	[pwd] [nvarchar](150) NULL,
	[sex] [nvarchar](50) NULL,
	[is_activated] [int] NULL,
	[is_locked] [int] NULL,
	[is_admin] [int] NULL,
	[is_deleted] [int] NULL,
	[company_id] [nvarchar](50) NULL,
	[MatrimonyClientID] [varchar](20) NULL,
 CONSTRAINT [PK_portal_user] PRIMARY KEY CLUSTERED 
(
	[user_id] ASC,
	[login_name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[portal_userlogin]    Script Date: 3/12/2015 9:38:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[portal_userlogin](
	[session_id] [varchar](20) NOT NULL,
	[login_date] [datetime] NULL,
	[login_ip] [varchar](100) NULL,
	[user_id] [varchar](20) NULL,
	[logout_date] [datetime] NULL,
 CONSTRAINT [PK_portal_userlogin] PRIMARY KEY CLUSTERED 
(
	[session_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[prof_user]    Script Date: 3/12/2015 9:38:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[prof_user](
	[user_id] [varchar](20) NOT NULL,
	[doj] [datetime] NULL,
	[dob] [datetime] NULL,
	[experience] [varchar](200) NULL,
	[skills] [varchar](200) NULL,
	[address] [varchar](200) NULL,
	[theme] [varchar](20) NULL,
	[prof_language] [varchar](20) NULL,
	[photo_path] [varchar](200) NULL,
	[resume_path] [varchar](200) NULL,
	[empid] [nvarchar](50) NULL,
 CONSTRAINT [PK__prof_user__6E01572D] PRIMARY KEY CLUSTERED 
(
	[user_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Profile_BasicInfo]    Script Date: 3/12/2015 9:38:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Profile_BasicInfo](
	[ElanProfileID] [varchar](20) NOT NULL,
	[ProfileID] [varchar](50) NOT NULL,
	[Name] [nvarchar](80) NOT NULL,
	[Age] [numeric](18, 0) NULL,
	[Gender] [varchar](6) NULL,
	[DateOfBirth] [datetime] NULL,
	[TamilDOB] [datetime] NULL,
	[TimeOfBirth] [varchar](50) NULL,
	[PlaceOfBirth] [varchar](100) NULL,
	[MaritalStatus] [nvarchar](50) NULL,
	[NoOfChildren] [numeric](18, 0) NULL,
	[ChildrenLivingStatus] [nvarchar](50) NULL,
	[Height] [varchar](50) NULL,
	[Weight] [numeric](18, 0) NULL,
	[BodyType] [nvarchar](50) NULL,
	[Complexion] [nvarchar](50) NULL,
	[PhysicalStatus] [nvarchar](80) NULL,
	[BloodGroup] [nvarchar](50) NOT NULL,
	[MotherTongue] [nvarchar](50) NULL,
	[ProfileCreatedBy] [nvarchar](50) NULL,
	[Religion] [nvarchar](50) NULL,
	[Caste] [nvarchar](50) NULL,
	[SubCaste] [nvarchar](50) NULL,
	[AcceptOtherNaidu] [nvarchar](80) NULL,
	[Gothram] [nvarchar](50) NULL,
	[Star] [nvarchar](50) NULL,
	[Raasi] [nvarchar](50) NULL,
	[Zodiac] [nvarchar](50) NULL,
	[HoroscopeMatch] [nvarchar](50) NULL,
	[AnyDosham] [nvarchar](50) NULL,
	[Eating] [nvarchar](50) NULL,
	[Smoking] [nvarchar](50) NULL,
	[Drinking] [nvarchar](50) NULL,
	[AboutMe] [nvarchar](2000) NULL,
	[PartnerExpectations] [nvarchar](2000) NULL,
	[CreatedBy] [varchar](20) NULL,
	[CreatedDate] [datetime] NULL,
	[ZodiacYear] [numeric](18, 0) NULL,
	[ZodiacMonth] [numeric](18, 0) NULL,
	[ZodiacDay] [numeric](18, 0) NULL,
	[MatrimonyClientID] [varchar](20) NULL,
 CONSTRAINT [PK_Profile_BasicInfo_1] PRIMARY KEY CLUSTERED 
(
	[ProfileID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Profile_Carrier]    Script Date: 3/12/2015 9:38:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Profile_Carrier](
	[CarrierID] [varchar](20) NOT NULL,
	[ProfileID] [varchar](50) NOT NULL,
	[Education] [varchar](50) NULL,
	[EduInDetail] [nvarchar](50) NULL,
	[EmployedIn] [nvarchar](50) NULL,
	[Occupation] [nvarchar](50) NULL,
	[OccupationInDetail] [nvarchar](1000) NULL,
	[Income] [decimal](18, 0) NULL,
 CONSTRAINT [PK_Profile_Carrier_1] PRIMARY KEY CLUSTERED 
(
	[CarrierID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Profile_Caste]    Script Date: 3/12/2015 9:38:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Profile_Caste](
	[CasteID] [varchar](20) NOT NULL,
	[CasteName] [varchar](150) NULL,
	[Description] [varchar](500) NULL,
	[CreatedBy] [varchar](20) NULL,
	[CreatedDate] [datetime] NULL,
 CONSTRAINT [PK_Profile_Caste] PRIMARY KEY CLUSTERED 
(
	[CasteID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Profile_Contact]    Script Date: 3/12/2015 9:38:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Profile_Contact](
	[ContactId] [varchar](20) NOT NULL,
	[ProfileID] [varchar](50) NOT NULL,
	[EMail] [varchar](150) NULL,
	[MobileNumber] [varchar](100) NULL,
	[LandLineNumber] [varchar](100) NULL,
	[Address] [nvarchar](150) NULL,
	[RelationShipWithMember] [nvarchar](50) NULL,
	[ConvinientTimeToCall] [varchar](150) NULL,
 CONSTRAINT [PK_Profile_Contact] PRIMARY KEY CLUSTERED 
(
	[ContactId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Profile_FamilyDetails]    Script Date: 3/12/2015 9:38:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Profile_FamilyDetails](
	[FamilyDetailsID] [varchar](20) NOT NULL,
	[ProfileID] [varchar](50) NOT NULL,
	[FamilyValue] [nvarchar](50) NULL,
	[FamilType] [nvarchar](100) NULL,
	[FamilyStatus] [nvarchar](50) NULL,
	[FathersName] [nvarchar](100) NULL,
	[Mothersname] [nvarchar](100) NULL,
	[FathersOccupation] [nvarchar](100) NULL,
	[MothersOccupation] [nvarchar](100) NULL,
	[FamilyOrigin] [nvarchar](100) NULL,
	[NoOfBrothers] [numeric](18, 0) NULL,
	[BrothersMarried] [numeric](18, 0) NULL,
	[NoOfSisters] [numeric](18, 0) NULL,
	[SistersMarried] [numeric](18, 0) NULL,
	[AboutFamily] [nvarchar](2000) NULL,
 CONSTRAINT [PK_Profile_FamilyDetails_1] PRIMARY KEY CLUSTERED 
(
	[FamilyDetailsID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Profile_HoroscopeAmsam]    Script Date: 3/12/2015 9:38:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Profile_HoroscopeAmsam](
	[AmsamID] [varchar](20) NOT NULL,
	[ProfileID] [varchar](50) NULL,
	[Kattam1] [varchar](100) NULL,
	[Kattam2] [varchar](100) NULL,
	[Kattam3] [varchar](100) NULL,
	[Kattam4] [varchar](100) NULL,
	[Kattam5] [varchar](100) NULL,
	[Kattam6] [varchar](100) NULL,
	[Kattam7] [varchar](100) NULL,
	[Kattam8] [varchar](100) NULL,
	[Kattam9] [varchar](100) NULL,
	[Kattam10] [varchar](100) NULL,
	[Kattam11] [varchar](100) NULL,
	[Kattam12] [varchar](100) NULL,
 CONSTRAINT [PK_Profile_HoroscopeAmsam] PRIMARY KEY CLUSTERED 
(
	[AmsamID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Profile_HoroscopeRaasi]    Script Date: 3/12/2015 9:38:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Profile_HoroscopeRaasi](
	[RaasiID] [varchar](20) NOT NULL,
	[ProfileID] [varchar](50) NULL,
	[Kattam1] [varchar](100) NULL,
	[Kattam2] [varchar](100) NULL,
	[Kattam3] [varchar](100) NULL,
	[Kattam4] [varchar](100) NULL,
	[Kattam5] [varchar](100) NULL,
	[Kattam6] [varchar](100) NULL,
	[Kattam7] [varchar](100) NULL,
	[Kattam8] [varchar](100) NULL,
	[Kattam9] [varchar](100) NULL,
	[Kattam10] [varchar](100) NULL,
	[Kattam11] [varchar](100) NULL,
	[Kattam12] [varchar](100) NULL,
 CONSTRAINT [PK_Profile_HoroscopeRaasi] PRIMARY KEY CLUSTERED 
(
	[RaasiID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Profile_LocationInfo]    Script Date: 3/12/2015 9:38:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Profile_LocationInfo](
	[ProfileId] [varchar](50) NOT NULL,
	[LocationID] [varchar](20) NOT NULL,
	[CountryLivingIn] [nvarchar](50) NULL,
	[CitizenShip] [nvarchar](50) NULL,
	[ResidentStatus] [nvarchar](50) NULL,
	[ResidingState] [nvarchar](50) NULL,
	[ResidingCity] [nvarchar](50) NULL,
 CONSTRAINT [PK_Profile_LocationInfo_1] PRIMARY KEY CLUSTERED 
(
	[LocationID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Profile_PartnerPreference]    Script Date: 3/12/2015 9:38:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Profile_PartnerPreference](
	[PartnerPreferenceID] [varchar](20) NOT NULL,
	[ProfileID] [varchar](50) NOT NULL,
	[EatingHabits] [nvarchar](50) NULL,
	[DrinkingHabits] [nvarchar](50) NULL,
	[SmokingHabits] [nvarchar](50) NULL,
	[MotherTongue] [nvarchar](50) NULL,
	[CountryLivingIn] [nvarchar](50) NULL,
	[CitizenShip] [nvarchar](50) NULL,
	[EducationID] [varchar](20) NULL,
	[MastersDegreeID] [varchar](20) NULL,
	[ManagementID] [varchar](20) NULL,
	[FinanceID] [varchar](20) NULL,
	[ServiceID] [varchar](20) NULL,
	[PhDID] [varchar](20) NULL,
	[Occupation] [varchar](250) NULL,
	[AnnualIncome] [decimal](18, 0) NULL,
	[Partner Description] [varchar](150) NULL,
 CONSTRAINT [PK_Profile_PartnerPreference_1] PRIMARY KEY CLUSTERED 
(
	[PartnerPreferenceID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Profile_Photo]    Script Date: 3/12/2015 9:38:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Profile_Photo](
	[PhotoID] [varchar](20) NOT NULL,
	[ProfileID] [varchar](50) NOT NULL,
	[PhotoPath] [varchar](150) NULL,
	[FileName] [varchar](150) NULL,
	[Extension] [varchar](20) NULL,
	[ContentType] [varchar](50) NULL,
	[FileSize] [varchar](50) NULL,
 CONSTRAINT [PK_Profile_Photo] PRIMARY KEY CLUSTERED 
(
	[PhotoID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Profile_Reference]    Script Date: 3/12/2015 9:38:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Profile_Reference](
	[ReferenceID] [varchar](20) NOT NULL,
	[ProfileID] [varchar](50) NOT NULL,
	[NomineeName] [nvarchar](50) NULL,
	[ContactNo] [varchar](100) NULL,
 CONSTRAINT [PK_Profile_Reference_1] PRIMARY KEY CLUSTERED 
(
	[ReferenceID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Profile_Star]    Script Date: 3/12/2015 9:38:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Profile_Star](
	[StarID] [varchar](20) NOT NULL,
	[Name] [varchar](100) NULL,
	[Description] [varchar](1000) NULL,
	[CreatedBy] [varchar](20) NULL,
	[CreatedDate] [datetime] NULL,
 CONSTRAINT [PK_Profile_Star] PRIMARY KEY CLUSTERED 
(
	[StarID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Profile_SubCaste]    Script Date: 3/12/2015 9:38:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Profile_SubCaste](
	[SubCasteID] [varchar](20) NOT NULL,
	[CasteID] [varchar](20) NULL,
	[Name] [varchar](150) NULL,
	[Description] [varchar](500) NULL,
	[CreatedBy] [varchar](20) NULL,
	[CreatedDate] [datetime] NULL,
 CONSTRAINT [PK_Profile_SubCaste] PRIMARY KEY CLUSTERED 
(
	[SubCasteID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tbltime]    Script Date: 3/12/2015 9:38:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbltime](
	[time] [time](7) NOT NULL,
 CONSTRAINT [PK_tblTime] PRIMARY KEY CLUSTERED 
(
	[time] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[temp_master_insertion]    Script Date: 3/12/2015 9:38:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[temp_master_insertion](
	[master_id] [varchar](16) NULL,
	[master_name] [varchar](516) NULL,
	[created_by] [varchar](116) NULL,
	[created_date] [datetime] NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tempdata]    Script Date: 3/12/2015 9:38:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tempdata](
	[id] [varchar](20) NULL,
	[pid] [varchar](20) NULL,
	[name] [varchar](20) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_portal_clients]    Script Date: 3/12/2015 9:38:53 AM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_portal_clients] ON [dbo].[portal_clients]
(
	[ClientTag] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[disc_master] ADD  CONSTRAINT [DF_disc_master_last_activity]  DEFAULT (getdate()) FOR [created_date]
GO
ALTER TABLE [dbo].[disc_replythread] ADD  CONSTRAINT [DF_disc_replythread_replied_date]  DEFAULT (getdate()) FOR [replied_date]
GO
ALTER TABLE [dbo].[disc_thread_master] ADD  CONSTRAINT [DF_disc_thread_master_created_date_1]  DEFAULT (getdate()) FOR [created_date]
GO
ALTER TABLE [dbo].[event_category] ADD  CONSTRAINT [DF__event_cat__creat__690797E6]  DEFAULT (getdate()) FOR [created_date]
GO
ALTER TABLE [dbo].[event_category] ADD  CONSTRAINT [DF_event_category_event_date]  DEFAULT (getdate()) FOR [event_date]
GO
ALTER TABLE [dbo].[event_holidays] ADD  DEFAULT (getdate()) FOR [holiday_from]
GO
ALTER TABLE [dbo].[event_holidays] ADD  DEFAULT (getdate()) FOR [holiday_to]
GO
ALTER TABLE [dbo].[poll_vote] ADD  CONSTRAINT [DF_poll_vote_poll_uservoted]  DEFAULT ((0)) FOR [poll_uservoted]
GO
ALTER TABLE [dbo].[poll_vote] ADD  CONSTRAINT [DF_poll_vote_poll_voteddate]  DEFAULT (getdate()) FOR [poll_voteddate]
GO
ALTER TABLE [dbo].[portal_clients] ADD  CONSTRAINT [DF_portal_clients_crdate]  DEFAULT (getdate()) FOR [crdate]
GO
ALTER TABLE [dbo].[portal_emptype_master] ADD  CONSTRAINT [DF__portal_em__creat__5070F446]  DEFAULT (getdate()) FOR [created_date]
GO
ALTER TABLE [dbo].[portal_holidays] ADD  CONSTRAINT [DF_portal_holidays_date]  DEFAULT (getdate()) FOR [date]
GO
ALTER TABLE [dbo].[portal_holidays] ADD  CONSTRAINT [DF_portal_holidays_crdate]  DEFAULT (getdate()) FOR [crdate]
GO
ALTER TABLE [dbo].[portal_licence] ADD  CONSTRAINT [DF__portal_li__liecn__3D5E1FD2]  DEFAULT (getdate()) FOR [licence_updated]
GO
ALTER TABLE [dbo].[portal_licence] ADD  CONSTRAINT [DF_portal_licence_licence_no]  DEFAULT ((1)) FOR [licence_no]
GO
ALTER TABLE [dbo].[portal_location_master] ADD  CONSTRAINT [DF__portal_lo__creat__47DBAE45]  DEFAULT (getdate()) FOR [created_date]
GO
ALTER TABLE [dbo].[portal_projects] ADD  CONSTRAINT [DF_portal_projects_crdate]  DEFAULT (getdate()) FOR [crdate]
GO
ALTER TABLE [dbo].[portal_role_master] ADD  CONSTRAINT [DF_portal_role_master_role_level]  DEFAULT ((0)) FOR [role_level]
GO
ALTER TABLE [dbo].[portal_session] ADD  CONSTRAINT [DF_portal_session_login_time]  DEFAULT (getdate()) FOR [login_time]
GO
ALTER TABLE [dbo].[portal_session] ADD  CONSTRAINT [DF_portal_session_is_terminated]  DEFAULT ((0)) FOR [is_terminated]
GO
ALTER TABLE [dbo].[portal_tab_master] ADD  CONSTRAINT [DF_portal_tab_master_tab_type]  DEFAULT ((0)) FOR [tab_type]
GO
ALTER TABLE [dbo].[portal_tab_master] ADD  CONSTRAINT [DF_portal_tab_master_isdefault]  DEFAULT ((0)) FOR [isdefault]
GO
ALTER TABLE [dbo].[portal_tab_master] ADD  CONSTRAINT [DF_portal_tab_master_istag]  DEFAULT ((0)) FOR [istag]
GO
ALTER TABLE [dbo].[portal_user] ADD  CONSTRAINT [DF_portal_user_sex]  DEFAULT ('m') FOR [sex]
GO
ALTER TABLE [dbo].[portal_user] ADD  CONSTRAINT [DF_portal_user_is_activated]  DEFAULT ((0)) FOR [is_activated]
GO
ALTER TABLE [dbo].[portal_user] ADD  CONSTRAINT [DF_portal_user_is_locked]  DEFAULT ((0)) FOR [is_locked]
GO
ALTER TABLE [dbo].[portal_user] ADD  CONSTRAINT [DF_portal_user_is_admin]  DEFAULT ((0)) FOR [is_admin]
GO
ALTER TABLE [dbo].[portal_user] ADD  CONSTRAINT [DF__portal_us__is_de__5629CD9C]  DEFAULT ((0)) FOR [is_deleted]
GO
ALTER TABLE [dbo].[prof_user] ADD  CONSTRAINT [DF__prof_user__doj__6EF57B66]  DEFAULT (getdate()) FOR [doj]
GO
ALTER TABLE [dbo].[prof_user] ADD  CONSTRAINT [DF_prof_user_dob]  DEFAULT (getdate()) FOR [dob]
GO
ALTER TABLE [dbo].[Profile_BasicInfo] ADD  CONSTRAINT [DF_Profile_BasicInfo_CreatedDate]  DEFAULT (getdate()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[Profile_Caste] ADD  CONSTRAINT [DF_Profile_Caste_CreatedDate]  DEFAULT (getdate()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[Profile_Star] ADD  CONSTRAINT [DF_Profile_Star_CreatedDate]  DEFAULT (getdate()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[Profile_SubCaste] ADD  CONSTRAINT [DF_Profile_SubCaste_CreatedDate]  DEFAULT (getdate()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[portal_clients]  WITH CHECK ADD  CONSTRAINT [FK_portal_clients_Profile_Caste] FOREIGN KEY([CasteID])
REFERENCES [dbo].[Profile_Caste] ([CasteID])
GO
ALTER TABLE [dbo].[portal_clients] CHECK CONSTRAINT [FK_portal_clients_Profile_Caste]
GO
ALTER TABLE [dbo].[Profile_BasicInfo]  WITH CHECK ADD  CONSTRAINT [FK_Profile_BasicInfo_portal_clients] FOREIGN KEY([MatrimonyClientID])
REFERENCES [dbo].[portal_clients] ([clientid])
GO
ALTER TABLE [dbo].[Profile_BasicInfo] CHECK CONSTRAINT [FK_Profile_BasicInfo_portal_clients]
GO
ALTER TABLE [dbo].[Profile_Carrier]  WITH CHECK ADD  CONSTRAINT [FK_Profile_Carrier_Profile_BasicInfo] FOREIGN KEY([ProfileID])
REFERENCES [dbo].[Profile_BasicInfo] ([ProfileID])
GO
ALTER TABLE [dbo].[Profile_Carrier] CHECK CONSTRAINT [FK_Profile_Carrier_Profile_BasicInfo]
GO
ALTER TABLE [dbo].[Profile_Contact]  WITH CHECK ADD  CONSTRAINT [FK_Profile_Contact_Profile_BasicInfo] FOREIGN KEY([ProfileID])
REFERENCES [dbo].[Profile_BasicInfo] ([ProfileID])
GO
ALTER TABLE [dbo].[Profile_Contact] CHECK CONSTRAINT [FK_Profile_Contact_Profile_BasicInfo]
GO
ALTER TABLE [dbo].[Profile_FamilyDetails]  WITH CHECK ADD  CONSTRAINT [FK_Profile_FamilyDetails_Profile_BasicInfo] FOREIGN KEY([ProfileID])
REFERENCES [dbo].[Profile_BasicInfo] ([ProfileID])
GO
ALTER TABLE [dbo].[Profile_FamilyDetails] CHECK CONSTRAINT [FK_Profile_FamilyDetails_Profile_BasicInfo]
GO
ALTER TABLE [dbo].[Profile_HoroscopeAmsam]  WITH CHECK ADD  CONSTRAINT [FK_Profile_HoroscopeAmsam_Profile_BasicInfo] FOREIGN KEY([ProfileID])
REFERENCES [dbo].[Profile_BasicInfo] ([ProfileID])
GO
ALTER TABLE [dbo].[Profile_HoroscopeAmsam] CHECK CONSTRAINT [FK_Profile_HoroscopeAmsam_Profile_BasicInfo]
GO
ALTER TABLE [dbo].[Profile_HoroscopeRaasi]  WITH CHECK ADD  CONSTRAINT [FK_Profile_HoroscopeRaasi_Profile_BasicInfo] FOREIGN KEY([ProfileID])
REFERENCES [dbo].[Profile_BasicInfo] ([ProfileID])
GO
ALTER TABLE [dbo].[Profile_HoroscopeRaasi] CHECK CONSTRAINT [FK_Profile_HoroscopeRaasi_Profile_BasicInfo]
GO
ALTER TABLE [dbo].[Profile_LocationInfo]  WITH CHECK ADD  CONSTRAINT [FK_Profile_LocationInfo_Profile_BasicInfo] FOREIGN KEY([ProfileId])
REFERENCES [dbo].[Profile_BasicInfo] ([ProfileID])
GO
ALTER TABLE [dbo].[Profile_LocationInfo] CHECK CONSTRAINT [FK_Profile_LocationInfo_Profile_BasicInfo]
GO
ALTER TABLE [dbo].[Profile_PartnerPreference]  WITH CHECK ADD  CONSTRAINT [FK_Profile_PartnerPreference_Profile_BasicInfo] FOREIGN KEY([ProfileID])
REFERENCES [dbo].[Profile_BasicInfo] ([ProfileID])
GO
ALTER TABLE [dbo].[Profile_PartnerPreference] CHECK CONSTRAINT [FK_Profile_PartnerPreference_Profile_BasicInfo]
GO
ALTER TABLE [dbo].[Profile_Photo]  WITH CHECK ADD  CONSTRAINT [FK_Profile_Photo_Profile_BasicInfo1] FOREIGN KEY([ProfileID])
REFERENCES [dbo].[Profile_BasicInfo] ([ProfileID])
GO
ALTER TABLE [dbo].[Profile_Photo] CHECK CONSTRAINT [FK_Profile_Photo_Profile_BasicInfo1]
GO
ALTER TABLE [dbo].[Profile_Reference]  WITH CHECK ADD  CONSTRAINT [FK_Profile_Reference_Profile_BasicInfo] FOREIGN KEY([ProfileID])
REFERENCES [dbo].[Profile_BasicInfo] ([ProfileID])
GO
ALTER TABLE [dbo].[Profile_Reference] CHECK CONSTRAINT [FK_Profile_Reference_Profile_BasicInfo]
GO
ALTER TABLE [dbo].[Profile_SubCaste]  WITH CHECK ADD  CONSTRAINT [FK_Profile_SubCaste_Profile_SubCaste] FOREIGN KEY([CasteID])
REFERENCES [dbo].[Profile_Caste] ([CasteID])
GO
ALTER TABLE [dbo].[Profile_SubCaste] CHECK CONSTRAINT [FK_Profile_SubCaste_Profile_SubCaste]
GO
USE [master]
GO
ALTER DATABASE [Mugurtham] SET  READ_WRITE 
GO

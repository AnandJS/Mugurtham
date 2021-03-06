
/****** Object:  Database [Mugurtham]    Script Date: 6/22/2017 8:10:39 AM ******/
CREATE DATABASE [Mugurtham] ON  PRIMARY 
( NAME = N'Mugurtham', FILENAME = N'D:\Mugurtham\GIT\Mugurtham\Mugurtham.DAL\Database\Mugurtham.mdf' , SIZE = 3072KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'Mugurtham_log', FILENAME = N'D:\Mugurtham\GIT\Mugurtham\Mugurtham.DAL\Database\Mugurtham_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
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
ALTER DATABASE [Mugurtham] SET AUTO_CLOSE ON 
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
USE [Mugurtham]
GO
/****** Object:  User [MugurthamAdmin]    Script Date: 6/22/2017 8:10:39 AM ******/
CREATE USER [MugurthamAdmin] FOR LOGIN [MugurthamAdmin] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  StoredProcedure [dbo].[uspDeleteProfile]    Script Date: 6/22/2017 8:10:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================



-- Author:      <ANAND JAYASEELAN>



-- Create date: <APR 11 2017>



-- Description: <DELETE PROFILE>



-- =============================================



CREATE PROCEDURE [dbo].[uspDeleteProfile] @ProfileID varchar(20) 									 



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







				delete from ProfileAmsam where ProfileID = @ProfileID



				delete from ProfileReference where ProfileID = @ProfileID



				delete from ProfileCareer where ProfileID = @ProfileID



				delete from ProfileContact where ProfileID = @ProfileID



				delete from ProfileFamily where ProfileID = @ProfileID



				delete from ProfileLocation where ProfileID = @ProfileID



				delete from ProfileRaasi where ProfileID = @ProfileID



				delete from ProfileHoroscope where ProfileID = @ProfileID



				delete from ProfilePhoto where ProfileID = @ProfileID

				
				delete from ProfileViewed where ViewerID = @ProfileID

				
				delete from ProfileViewed where ViewedID = @ProfileID


				delete from ProfileInterested where ViewerID = @ProfileID

				
				delete from ProfileInterested where ViewerID = @ProfileID

				
				delete from ProfileBasicInfo where ProfileID = @ProfileID

				
				delete from PortalSession where UserID = @ProfileID

				

				delete from PortalUser where LoginID = @ProfileID

 



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
/****** Object:  StoredProcedure [dbo].[uspGetAllProfiles]    Script Date: 6/22/2017 8:10:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:      <ANAND JAYASEELAN>
-- Create date: <JUN 02 2015>
-- Description: <GETS ALL HIGHLIGHTED PROFILES AND LISTS
--               SAME SANGAM FIRST FOLLOWED BY OTHER SANGAMS  
--                  >
-- =============================================

CREATE PROCEDURE [dbo].[uspGetAllProfiles] @Gender   VARCHAR(30),
                                                     @SangamID VARCHAR(20)
AS
  BEGIN
      DECLARE @strSQLQuery AS NVARCHAR(max)

      SET nocount ON;
      SET xact_abort, quoted_identifier, ansi_nulls, ansi_padding, ansi_warnings
      ,
      arithabort, concat_null_yields_null ON;
      SET numeric_roundabort OFF;

      DECLARE @localTran BIT

      IF @@TRANCOUNT = 0
        BEGIN
            SET @localTran = 1

            BEGIN TRANSACTION localtran
        END

      BEGIN try
          SET @strSQLQuery =
          'SELECT profilebasicinfo.elanuserid,
                 profilebasicinfo.profileid,
                 profilebasicinfo.NAME,
                 profilebasicinfo.age,
                 profilebasicinfo.gender,
                 profilebasicinfo.dateofbirth,
                 profilebasicinfo.tamildob,
                 profilebasicinfo.timeofbirth,
                 profilebasicinfo.placeofbirth,
                 profilebasicinfo.maritalstatus,
                 profilebasicinfo.noofchildren,
                 profilebasicinfo.childrenlivingstatus,
                 profilebasicinfo.height,
                 profilebasicinfo.weight,
                 profilebasicinfo.bodytype,
                 profilebasicinfo.complexion,
                 profilebasicinfo.physicalstatus,
                 profilebasicinfo.bloodgroup,
                 profilebasicinfo.mothertongue,
                 profilebasicinfo.profilecreatedby,
                 profilebasicinfo.religion,
                 profilebasicinfo.caste,
                 profilebasicinfo.subcaste,
                 profilebasicinfo.gothram,
                 profilebasicinfo.star,
                 profilebasicinfo.raasi,
                 profilebasicinfo.zodiac,
                 profilebasicinfo.horoscopematch,
                 profilebasicinfo.anydosham,
                 profilebasicinfo.eating,
                 profilebasicinfo.smoking,
                 profilebasicinfo.drinking,
                 profilebasicinfo.aboutme,
                 profilebasicinfo.partnerexpectations,
                 profilebasicinfo.createdby,
                 profilebasicinfo.createddate,
                 profilebasicinfo.zodiacyear,
                 profilebasicinfo.zodiacmonth,
                 profilebasicinfo.zodiacday,
                 profilebasicinfo.photopath,
                 profilebasicinfo.sangamid,
                 profilebasicinfo.modifiedby,
                 profilebasicinfo.modifieddate,
				 1 as "sangam"
          FROM   profilebasicinfo ProfileBasicInfo WITH (nolock)
                 INNER JOIN portaluser PortalUser WITH (nolock)'
				  

          IF( @Gender = 'admin' )
            SELECT @Gender = ( '''male''' + ', ' + '''female''' )

          IF( @Gender = 'male' )
            SELECT @Gender = ( '''male''' )

          IF( @Gender = 'female' )
            SELECT @Gender = ( '''female''' )

          SET @strSQLQuery = @strSQLQuery
                             + ' ON ProfileBasicInfo.Gender in ( ' + @Gender
                             + ')
						 AND portaluser.roleid = ''F62DDFBE55448E3A3''
                            -- User Profiles only
                            AND portaluser.isactivated = 1
                            -- Activated Profile Only
                            AND portaluser.loginid = profilebasicinfo.profileid
                 INNER JOIN sangammaster SangamMaster WITH (nolock)
                         ON sangammaster.id = '
                             + '''' + @SangamID + ''''
                             +
          '
						 AND sangammaster.isactivated = 1
                            -- Activated Sangam Only
                            AND sangammaster.id = portaluser.sangamid 
							union all
							SELECT profilebasicinfo.elanuserid,
                 profilebasicinfo.profileid,
                 profilebasicinfo.NAME,
                 profilebasicinfo.age,
                 profilebasicinfo.gender,
                 profilebasicinfo.dateofbirth,
                 profilebasicinfo.tamildob,
                 profilebasicinfo.timeofbirth,
                 profilebasicinfo.placeofbirth,
                 profilebasicinfo.maritalstatus,
                 profilebasicinfo.noofchildren,
                 profilebasicinfo.childrenlivingstatus,
                 profilebasicinfo.height,
                 profilebasicinfo.weight,
                 profilebasicinfo.bodytype,
                 profilebasicinfo.complexion,
                 profilebasicinfo.physicalstatus,
                 profilebasicinfo.bloodgroup,
                 profilebasicinfo.mothertongue,
                 profilebasicinfo.profilecreatedby,
                 profilebasicinfo.religion,
                 profilebasicinfo.caste,
                 profilebasicinfo.subcaste,
                 profilebasicinfo.gothram,
                 profilebasicinfo.star,
                 profilebasicinfo.raasi,
                 profilebasicinfo.zodiac,
                 profilebasicinfo.horoscopematch,
                 profilebasicinfo.anydosham,
                 profilebasicinfo.eating,
                 profilebasicinfo.smoking,
                 profilebasicinfo.drinking,
                 profilebasicinfo.aboutme,
                 profilebasicinfo.partnerexpectations,
                 profilebasicinfo.createdby,
                 profilebasicinfo.createddate,
                 profilebasicinfo.zodiacyear,
                 profilebasicinfo.zodiacmonth,
                 profilebasicinfo.zodiacday,
                 profilebasicinfo.photopath,
                 profilebasicinfo.sangamid,
                 profilebasicinfo.modifiedby,
                 profilebasicinfo.modifieddate,
				 2 as "sangam"
          FROM   profilebasicinfo ProfileBasicInfo WITH (nolock)
                 INNER JOIN portaluser PortalUser WITH (nolock)'

          IF( @Gender = 'admin' )
            SELECT @Gender = ( '''male''' + ', ' + '''female''' )

          IF( @Gender = 'male' )
            SELECT @Gender = ( '''male''' )

          IF( @Gender = 'female' )
            SELECT @Gender = ( '''female''' )

          SET @strSQLQuery = @strSQLQuery
                             + ' ON ProfileBasicInfo.Gender in ( ' + @Gender
                             + ')
						 AND portaluser.roleid = ''F62DDFBE55448E3A3''
                            -- User Profiles only
                            AND portaluser.isactivated = 1
                            -- Activated Profile Only
                            AND portaluser.loginid = profilebasicinfo.profileid
                 INNER JOIN sangammaster SangamMaster WITH (nolock)
                         ON sangammaster.id <> '
                             + '''' + @SangamID + '''' + '
						 AND sangammaster.isactivated = 1
                            -- Activated Sangam Only
                            AND sangammaster.id = portaluser.sangamid	
							order by sangam, profilebasicinfo.createddate desc						
							'
          EXECUTE Sp_executesql
            @strSQLQuery

          IF @localTran = 1
             AND Xact_state() = 1
            COMMIT TRAN localtran
      END try

      BEGIN catch
          DECLARE @ErrorMessage NVARCHAR(4000)
          DECLARE @ErrorSeverity INT
          DECLARE @ErrorState INT

          SELECT @ErrorMessage = Error_message(),
                 @ErrorSeverity = Error_severity(),
                 @ErrorState = Error_state()

          IF @localTran = 1
             AND Xact_state() <> 0
            ROLLBACK TRAN

          RAISERROR ( @ErrorMessage,@ErrorSeverity,@ErrorState)
      END catch
  END 

GO
/****** Object:  StoredProcedure [dbo].[uspGetByProfileID]    Script Date: 6/22/2017 8:10:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:      <ANAND JAYASEELAN>
-- Create date: <APR 21 2014>
-- Description: <ALL PROFILE SEARCH DYNAMIC SQL>
-- =============================================
CREATE PROCEDURE [dbo].[uspGetByProfileID] @ProfileID varchar(20) 									 
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

	 SELECT profilebasicinfo.elanuserid,
       profilebasicinfo.profileid,
	   profilebasicinfo.SangamProfileID,
       profilebasicinfo.NAME,
       profilebasicinfo.age,
       profilebasicinfo.gender,
       profilebasicinfo.DateOfBirth,
       profilebasicinfo.tamildob,
       profilebasicinfo.timeofbirth,
       profilebasicinfo.placeofbirth,
       profilebasicinfo.maritalstatus,
       profilebasicinfo.noofchildren,
       profilebasicinfo.childrenlivingstatus,
       profilebasicinfo.height,
       profilebasicinfo.weight,
       profilebasicinfo.bodytype,
       profilebasicinfo.complexion,
       profilebasicinfo.physicalstatus,
       profilebasicinfo.bloodgroup,
       profilebasicinfo.mothertongue,
       profilebasicinfo.profilecreatedby,
       profilebasicinfo.religion,
       profilebasicinfo.caste,
       profilebasicinfo.subcaste,
       profilebasicinfo.gothram,
       profilebasicinfo.star,
       profilebasicinfo.raasi,
       profilebasicinfo.zodiac,
       profilebasicinfo.horoscopematch,
       profilebasicinfo.anydosham,
       profilebasicinfo.eating,
       profilebasicinfo.smoking,
       profilebasicinfo.drinking,
       profilebasicinfo.aboutme,
       profilebasicinfo.partnerexpectations,
       profilebasicinfo.createdby,
       profilebasicinfo.createddate,
       profilebasicinfo.zodiacyear,
       profilebasicinfo.zodiacmonth,
       profilebasicinfo.zodiacday,
       profilebasicinfo.photopath,
       profilebasicinfo.sangamid,
       profilebasicinfo.modifiedby,
       profilebasicinfo.modifieddate,
	   profilebasicinfo.Paadham
FROM   profilebasicinfo ProfileBasicInfo WITH (nolock)
       INNER JOIN portaluser PortalUser WITH (nolock)
               ON profilebasicinfo.profileid = @ProfileID
                  AND portaluser.roleid = 'F62DDFBE55448E3A3'
                  -- User Profiles only
                  AND portaluser.isactivated = 1 -- Activated Profile Only
                  AND portaluser.loginid = profilebasicinfo.profileid
       INNER JOIN sangammaster SangamMaster WITH (nolock)
               ON sangammaster.isactivated = 1 -- Activated Sangam Only
                  AND sangammaster.id = portaluser.sangamid 


					 
 
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
/****** Object:  StoredProcedure [dbo].[uspGetHighlightedProfiles]    Script Date: 6/22/2017 8:10:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:      <ANAND JAYASEELAN>
-- Create date: <JUN 02 2015>
-- Description: <GETS ALL HIGHLIGHTED PROFILES AND LISTS
--               SAME SANGAM FIRST FOLLOWED BY OTHER SANGAMS  
--                  >
-- Updated: <May 01 2015> for Performance Optimization
--          <May 16 2015> Orderby SangamID and ModifiedDate DESC
-- =============================================


CREATE PROCEDURE [dbo].[uspGetHighlightedProfiles] @Gender   VARCHAR(30), 
                                                   @SangamID VARCHAR(20) 
AS 
  BEGIN 
      DECLARE @strSQLQuery AS NVARCHAR(max) 

      SET nocount ON; 
      SET xact_abort, quoted_identifier, ansi_nulls, ansi_padding, ansi_warnings 
      , 
      arithabort, concat_null_yields_null ON; 
      SET numeric_roundabort OFF; 

      DECLARE @LOCALTRAN BIT 

      IF @@TRANCOUNT = 0 
        BEGIN 
            SET @LOCALTRAN = 1 

            BEGIN TRANSACTION localtran 
        END 

      BEGIN try 
          IF ( @Gender = 'admin' ) 
            SELECT @Gender = ( '''male''' + ', ' + '''female''' ) 

          IF ( @Gender = 'male' ) 
            SELECT @Gender = ( '''male''' ) 

          IF ( @Gender = 'female' ) 
            SELECT @Gender = ( '''female''' ) 

          CREATE TABLE #temptable 
            ( 
               sangamprofileid    VARCHAR(50), 
               mugurthamprofileid VARCHAR(50), 
               NAME               NVARCHAR(150), 
               age                NUMERIC(3, 0), 
               gender             VARCHAR(15), 
               location           NVARCHAR(150), 
               education          NVARCHAR(250), 
               occupation         NVARCHAR(250), 
               aboutme            NVARCHAR(max), 
               sangamid           VARCHAR(50), 
               sangamname         NVARCHAR(450), 
               subcaste           NVARCHAR(150), 
               star               VARCHAR(150), 
               modifieddate       DATETIME 
            ); 

          SET @strSQLQuery = ' INSERT INTO #tempTable         
							   SELECT profilebasicinfo.sangamprofileid, 
									   profilebasicinfo.profileid, 
									   profilebasicinfo.NAME, 
									   profilebasicinfo.age, 
									   profilebasicinfo.gender, 
									   profilelocation.residingcity AS location, 
									   profilecareer.education, 
									   profilecareer.occupation, 
									   profilebasicinfo.aboutme, 
									   sangammaster.id              AS sangamid, 
									   sangammaster.NAME            AS sangamname, 
									   profilebasicinfo.subcaste, 
									   profilebasicinfo.star, 
									   profilebasicinfo.modifieddate 
								FROM   profilebasicinfo profilebasicinfo WITH (nolock) 
									   INNER JOIN portaluser PortalUser WITH (nolock) 
											   ON portaluser.ishighlighted = 1 
												  AND profilebasicinfo.gender IN ( ' + @Gender + ' ) 
												  AND portaluser.roleid = ''f62ddfbe55448e3a3'' -- User Profiles only    
												  AND portaluser.isactivated = 1 -- Activated Profile Only    
												  AND portaluser.loginid = profilebasicinfo.profileid 
									   INNER JOIN profilecareer ProfileCareer WITH (nolock) 
											   ON profilecareer.profileid = profilebasicinfo.profileid 
									   INNER JOIN profilelocation ProfileLocation WITH (nolock) 
											   ON profilelocation.profileid = profilebasicinfo.profileid 
									   INNER JOIN sangammaster SangamMaster WITH (nolock) 
											   ON sangammaster.isactivated = 1 -- Activated Sangam Only   
												  AND sangammaster.id = portaluser.sangamid'

          EXECUTE Sp_executesql 
            @strSQLQuery 

          SELECT sangamprofileid, 
                 mugurthamprofileid, 
                 NAME, 
                 age, 
                 CASE gender 
                   WHEN 'male' THEN 'groom' 
                   WHEN 'female' THEN 'bride' 
                   ELSE gender 
                 END "Gender", 
                 location, 
                 education, 
                 occupation, 
                 aboutme, 
                 sangamid, 
                 sangamname, 
                 subcaste, 
                 star 
          FROM   #temptable WITH (nolock) 
          ORDER  BY CASE 
                      WHEN sangamid = @SangamID THEN 1 
                      ELSE 2 
                    END, 
                    modifieddate DESC 

          SELECT profilephoto.id, 
                 profilephoto.profileid, 
                 profilephoto.photopath, 
                 profilephoto.isprofilepic 
          FROM   profilephoto ProfilePhoto WITH (nolock) 
                 INNER JOIN #temptable SearchDataTable WITH (nolock) 
                         ON profilephoto.profileid = 
                            SearchDataTable.mugurthamprofileid 

          IF @LOCALTRAN = 1 
             AND Xact_state() = 1 
            COMMIT TRAN localtran 
      END try 

      BEGIN catch 
          DECLARE @ERRORMESSAGE NVARCHAR(4000) 
          DECLARE @ERRORSEVERITY INT 
          DECLARE @ERRORSTATE INT 

          SELECT @ERRORMESSAGE = Error_message(), 
                 @ERRORSEVERITY = Error_severity(), 
                 @ERRORSTATE = Error_state() 

          IF @LOCALTRAN = 1 
             AND Xact_state() <> 0 
            ROLLBACK TRAN 

          RAISERROR (@ERRORMESSAGE,@ERRORSEVERITY,@ERRORSTATE) 
      END catch 
  END 
GO
/****** Object:  StoredProcedure [dbo].[uspGetInterestedInMeProfiles]    Script Date: 6/22/2017 8:10:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- ===============================================================================

-- Author:      <ANAND JAYASEELAN>

-- Create date: <JUN 3 2015>

-- Description: <GETS THE INTERESTED IN ME NOTIFICATION OF THE LOGGED IN PROFILE>

-- Updated: <May 01 2015> for Performance Optimization

--          <May 16 2015> Orderby SangamID and ModifiedDate DESC

-- ===============================================================================

CREATE PROCEDURE [dbo].[uspGetInterestedInMeProfiles] @Gender       VARCHAR(30), 
                                                      @InterestedID VARCHAR(50), 
                                                      @SangamID     VARCHAR(20) 
AS 
  BEGIN 
      DECLARE @strSQLQuery AS NVARCHAR(max) 

      SET nocount ON; 
      SET xact_abort, quoted_identifier, ansi_nulls, ansi_padding, ansi_warnings 
      , 
      arithabort, concat_null_yields_null ON; 
      SET numeric_roundabort OFF; 

      DECLARE @LOCALTRAN BIT 

      IF @@TRANCOUNT = 0 
        BEGIN 
            SET @LOCALTRAN = 1 

            BEGIN TRANSACTION localtran 
        END 

      BEGIN try 
          IF ( @Gender = 'admin' ) 
            SELECT @Gender = ( '''male''' + ', ' + '''female''' ) 

          IF ( @Gender = 'male' ) 
            SELECT @Gender = ( '''male''' ) 

          IF ( @Gender = 'female' ) 
            SELECT @Gender = ( '''female''' ) 

          CREATE TABLE #temptable 
            ( 
               sangamprofileid    VARCHAR(50), 
               mugurthamprofileid VARCHAR(50), 
               NAME               NVARCHAR(150), 
               age                NUMERIC(3, 0), 
               gender             VARCHAR(15), 
               location           NVARCHAR(150), 
               education          NVARCHAR(250), 
               occupation         NVARCHAR(250), 
               aboutme            NVARCHAR(max), 
               sangamid           VARCHAR(50), 
               sangamname         NVARCHAR(450), 
               subcaste           NVARCHAR(150), 
               star               VARCHAR(150), 
               modifieddate       DATETIME 
            ); 

          SET @strSQLQuery = ' INSERT INTO #tempTable         SELECT     profilebasicinfo.sangamprofileid, 
           profilebasicinfo.profileid, 
           profilebasicinfo.NAME, 
           profilebasicinfo.age, 
           profilebasicinfo.gender, 
           profilelocation.residingcity AS location, 
           profilecareer.education, 
           profilecareer.occupation, 
           profilebasicinfo.aboutme, 
           sangammaster.id   AS sangamid, 
           sangammaster.NAME AS sangamname, 
           profilebasicinfo.subcaste, 
           profilebasicinfo.star, 
           profilebasicinfo.modifieddate 
FROM       profilebasicinfo profilebasicinfo WITH (nolock) 
INNER JOIN profileinterested ProfileInterested WITH (nolock) 
ON         profileinterested.interestedinid = ''' + @InterestedID + ''' 
AND        profileinterested.viewerid = profilebasicinfo.profileid 
INNER JOIN profilecareer ProfileCareer WITH (nolock) 
ON         profilecareer.profileid = profilebasicinfo.profileid 
INNER JOIN profilelocation ProfileLocation WITH (nolock) 
ON         profilelocation.profileid = profilebasicinfo.profileid 
INNER JOIN portaluser PortalUser WITH (nolock) 
ON         profilebasicinfo.gender IN ( ' + @Gender + ') 
AND        portaluser.roleid = ''f62ddfbe55448e3a3''-- User Profiles only   
AND portaluser.isactivated = 1 -- Activated Profile Only   
AND portaluser.loginid = profilebasicinfo.profileid 
INNER JOIN sangammaster SangamMaster WITH (NOLOCK)   
ON sangammaster.isactivated = 1 -- Activated Sangam Only   
AND sangammaster.id = portaluser.sangamid'


          EXECUTE Sp_executesql 
            @strSQLQuery 

          SELECT sangamprofileid, 
                 mugurthamprofileid, 
                 NAME, 
                 age, 
                 CASE gender 
                   WHEN 'male' THEN 'groom' 
                   WHEN 'female' THEN 'bride' 
                   ELSE gender 
                 END "Gender", 
                 location, 
                 education, 
                 occupation, 
                 aboutme, 
                 sangamid, 
                 sangamname, 
                 subcaste, 
                 star 
          FROM   #temptable WITH (nolock) 
          ORDER  BY CASE 
                      WHEN sangamid = @SangamID THEN 1 
                      ELSE 2 
                    END, 
                    modifieddate DESC 

          SELECT profilephoto.id, 
                 profilephoto.profileid, 
                 profilephoto.photopath, 
                 profilephoto.isprofilepic 
          FROM   profilephoto ProfilePhoto WITH (nolock) 
                 INNER JOIN #temptable SearchDataTable WITH (nolock) 
                         ON profilephoto.profileid = 
                            SearchDataTable.mugurthamprofileid 

          IF @LOCALTRAN = 1 
             AND Xact_state() = 1 
            COMMIT TRAN localtran 
      END try 

      BEGIN catch 
          DECLARE @ERRORMESSAGE NVARCHAR(4000) 
          DECLARE @ERRORSEVERITY INT 
          DECLARE @ERRORSTATE INT 

          SELECT @ERRORMESSAGE = Error_message(), 
                 @ERRORSEVERITY = Error_severity(), 
                 @ERRORSTATE = Error_state() 

          IF @LOCALTRAN = 1 
             AND Xact_state() <> 0 
            ROLLBACK TRAN 

          RAISERROR (@ERRORMESSAGE,@ERRORSEVERITY,@ERRORSTATE) 
      END catch 
  END 
GO
/****** Object:  StoredProcedure [dbo].[uspGetInterestedProfiles]    Script Date: 6/22/2017 8:10:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ===============================================================================

-- Author:      <ANAND JAYASEELAN>

-- Create date: <JUN 3 2015>

-- Description: <GETS THE INTERESTED IN ME NOTIFICATION OF THE LOGGED IN PROFILE>

-- Updated: <May 01 2015> for Performance Optimization

--          <May 16 2015> Orderby SangamID and ModifiedDate DESC

-- ===============================================================================


CREATE PROCEDURE [dbo].[uspGetInterestedProfiles] @Gender       VARCHAR(30), 
                                                  @InterestedID VARCHAR(50), 
                                                  @SangamID     VARCHAR(20) 
AS 
  BEGIN 
      DECLARE @strSQLQuery AS NVARCHAR(max) 

      SET nocount ON; 
      SET xact_abort, quoted_identifier, ansi_nulls, ansi_padding, ansi_warnings 
      , 
      arithabort, concat_null_yields_null ON; 
      SET numeric_roundabort OFF; 

      DECLARE @LOCALTRAN BIT 

      IF @@TRANCOUNT = 0 
        BEGIN 
            SET @LOCALTRAN = 1 

            BEGIN TRANSACTION localtran 
        END 

      BEGIN try 
          IF ( @Gender = 'admin' ) 
            SELECT @Gender = ( '''male''' + ', ' + '''female''' ) 

          IF ( @Gender = 'male' ) 
            SELECT @Gender = ( '''male''' ) 

          IF ( @Gender = 'female' ) 
            SELECT @Gender = ( '''female''' ) 

          CREATE TABLE #temptable 
            ( 
               sangamprofileid    VARCHAR(50), 
               mugurthamprofileid VARCHAR(50), 
               NAME               NVARCHAR(150), 
               age                NUMERIC(3, 0), 
               gender             VARCHAR(15), 
               location           NVARCHAR(150), 
               education          NVARCHAR(250), 
               occupation         NVARCHAR(250), 
               aboutme            NVARCHAR(max), 
               sangamid           VARCHAR(50), 
               sangamname         NVARCHAR(450), 
               subcaste           NVARCHAR(150), 
               star               VARCHAR(150), 
               modifieddate       DATETIME 
            ); 

          SET @strSQLQuery = ' INSERT INTO #tempTable        
		  SELECT     profilebasicinfo.sangamprofileid, 
           profilebasicinfo.profileid, 
           profilebasicinfo.NAME, 
           profilebasicinfo.age, 
           profilebasicinfo.gender, 
           profilelocation.residingcity AS location, 
           profilecareer.education, 
           profilecareer.occupation, 
           profilebasicinfo.aboutme, 
           sangammaster.id   AS sangamid, 
           sangammaster.NAME AS sangamname, 
           profilebasicinfo.subcaste, 
           profilebasicinfo.star, 
           profilebasicinfo.modifieddate 
FROM       profilebasicinfo profilebasicinfo WITH (nolock) 
INNER JOIN profileinterested ProfileInterested WITH (nolock) 
ON         profileinterested.viewerid = '''+ @InterestedID + ''' 
AND        profileinterested.interestedinid = profilebasicinfo.profileid 
INNER JOIN profilecareer ProfileCareer WITH (nolock) 
ON         profilecareer.profileid = profilebasicinfo.profileid 
INNER JOIN profilelocation ProfileLocation WITH (nolock) 
ON         profilelocation.profileid = profilebasicinfo.profileid 
INNER JOIN portaluser PortalUser WITH (nolock) 
ON         profilebasicinfo.gender IN ( ' + @Gender + ') 
AND        portaluser.roleid = ''f62ddfbe55448e3a3''-- User Profiles only   
AND portaluser.isactivated = 1 -- Activated Profile Only  
AND portaluser.loginid = profilebasicinfo.profileid 
INNER JOIN sangammaster SangamMaster WITH (NOLOCK)  
ON sangammaster.isactivated = 1 -- Activated Sangam Only   
AND sangammaster.id = portaluser.sangamid'


          EXECUTE Sp_executesql 
            @strSQLQuery 

          SELECT sangamprofileid, 
                 mugurthamprofileid, 
                 NAME, 
                 age, 
                 CASE gender 
                   WHEN 'male' THEN 'groom' 
                   WHEN 'female' THEN 'bride' 
                   ELSE gender 
                 END "Gender", 
                 location, 
                 education, 
                 occupation, 
                 aboutme, 
                 sangamid, 
                 sangamname, 
                 subcaste, 
                 star 
          FROM   #temptable WITH (nolock) 
          ORDER  BY CASE 
                      WHEN sangamid = @SangamID THEN 1 
                      ELSE 2 
                    END, 
                    modifieddate DESC 

          SELECT profilephoto.id, 
                 profilephoto.profileid, 
                 profilephoto.photopath, 
                 profilephoto.isprofilepic 
          FROM   profilephoto ProfilePhoto WITH (nolock) 
                 INNER JOIN #temptable SearchDataTable WITH (nolock) 
                         ON profilephoto.profileid = 
                            SearchDataTable.mugurthamprofileid 

          IF @LOCALTRAN = 1 
             AND Xact_state() = 1 
            COMMIT TRAN localtran 
      END try 

      BEGIN catch 
          DECLARE @ERRORMESSAGE NVARCHAR(4000) 
          DECLARE @ERRORSEVERITY INT 
          DECLARE @ERRORSTATE INT 

          SELECT @ERRORMESSAGE = Error_message(), 
                 @ERRORSEVERITY = Error_severity(), 
                 @ERRORSTATE = Error_state() 

          IF @LOCALTRAN = 1 
             AND Xact_state() <> 0 
            ROLLBACK TRAN 

          RAISERROR (@ERRORMESSAGE,@ERRORSEVERITY,@ERRORSTATE) 
      END catch 
  END 
GO
/****** Object:  StoredProcedure [dbo].[uspGetProfileBadgeCount]    Script Date: 6/22/2017 8:10:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--Uspgetprofilebadgecount 'female','TRY1006','ECEBD1B2B0B4FC799'




-- =====================================================================================================  

-- Author:         <ANAND JAYASEELAN> 

-- Create date:	   <APR 8 2016>

-- Description:    <This Procedure will get the badge count only for User Profiles and not for rest >

-- ======================================================================================================  

CREATE PROCEDURE [dbo].[uspGetProfileBadgeCount] @GENDER       VARCHAR(30), 

                                                 @INTERESTEDID VARCHAR(50), 

                                                 @SANGAMID     VARCHAR(20) 

AS 

  BEGIN 

      DECLARE @HIGHLIGHTEDPROFILESCOUNT    INT, 

              @INTERESTEDINMEPROFILESCOUNT INT, 

              @INTERESTEDPROFILESCOUNT     INT, 

              @PROFILESJOINEDTHISWEEKCOUNT INT, 

              @PROFILESVIEWEDMECOUNT       INT,
			  
			  @RECENTLYVIEWEDPROFILESCOUNT       INT  



      SET nocount ON; 

      SET xact_abort, quoted_identifier, ansi_nulls, ansi_padding, ansi_warnings 

      , 

      arithabort, concat_null_yields_null ON; 

      SET numeric_roundabort OFF; 



      DECLARE @LOCALTRAN BIT 



      IF @@TRANCOUNT = 0 

        BEGIN 

            SET @LOCALTRAN = 1 



            BEGIN TRANSACTION localtran 

        END 



      BEGIN try 

          IF( @GENDER = 'admin' ) 

            SET @GENDER = ( 'male' + ', ' + 'female' ) 



          IF( @GENDER = 'male' ) 

            SET @GENDER = ( 'male' ) 



          IF( @GENDER = 'female' ) 

            SET @GENDER = ( 'female' ) 



          /*=============================uspGetHighlightedProfiles  Starts===================================================*/

          SET @HIGHLIGHTEDPROFILESCOUNT = (SELECT 

          Count(profilebasicinfo.profileid) 

                                           FROM 

          profilebasicinfo ProfileBasicInfo WITH ( 

          nolock) 

          INNER JOIN portaluser PortalUser WITH ( 

                     nolock) 

                  ON portaluser.ishighlighted = 1 

                     AND profilebasicinfo.gender = 

                         @GENDER 

                     AND portaluser.roleid = 

                         'F62DDFBE55448E3A3' 

                     -- User Profiles only     

                     AND portaluser.isactivated = 

                         1 

                     -- Activated Profile Only                                 

                     AND portaluser.loginid = 

          profilebasicinfo.profileid 

          INNER JOIN sangammaster SangamMaster WITH (nolock) 

          ON sangammaster.isactivated = 1 

          -- Activated Sangam Only                                 

          AND sangammaster.id = portaluser.sangamid) 

      /*=============================uspGetHighlightedProfiles  Ends===================================================*/

          /*=============================uspGetInterestedInMeProfiles  Starts===================================================*/

          SET @INTERESTEDINMEPROFILESCOUNT = (SELECT Count( 

                                             profilebasicinfo.profileid) 

                                              FROM 

          profilebasicinfo ProfileBasicInfo WITH (nolock) 

          INNER JOIN profileinterested ProfileInterested WITH (nolock) 

                  ON profileinterested.interestedinid = @INTERESTEDID 

                     AND profileinterested.viewerid = profilebasicinfo.profileid 

          INNER JOIN portaluser PortalUser WITH (nolock) 

                  ON profilebasicinfo.gender = @GENDER 

                     AND portaluser.roleid = 'F62DDFBE55448E3A3' 

                     -- User Profiles only                                 

                     AND portaluser.isactivated = 1 

                     -- Activated Profile Only                                 

                     AND portaluser.loginid = profilebasicinfo.profileid 

          INNER JOIN sangammaster SangamMaster WITH (nolock) 

             ON sangammaster.isactivated = 1 

                     -- Activated Sangam Only                                 

                     AND sangammaster.id = portaluser.sangamid) 

      /*=============================uspGetInterestedInMeProfiles  Ends===================================================*/

          /*=============================uspGetInterestedProfiles  Starts===================================================*/

          SET @INTERESTEDPROFILESCOUNT = (SELECT Count( 

                                         profilebasicinfo.profileid) 

                                          FROM 

          profilebasicinfo ProfileBasicInfo WITH ( 

          nolock) 

          INNER JOIN profileinterested 

                     ProfileInterested WITH (nolock 

                     ) 

                  ON profileinterested.viewerid = 

                     @INTERESTEDID 

                     AND 

          profileinterested.interestedinid = 

          profilebasicinfo.profileid 

          INNER JOIN portaluser PortalUser WITH ( 

                     nolock) 

                  ON profilebasicinfo.gender = 

                     @GENDER 

                     AND portaluser.roleid = 

                         'F62DDFBE55448E3A3' 

                     -- User Profiles only     

                     AND portaluser.isactivated = 1 

                     -- Activated Profile Only     

                     AND portaluser.loginid = 

                         profilebasicinfo.profileid 

          INNER JOIN sangammaster SangamMaster WITH 

                     (nolock) 

                  ON sangammaster.isactivated = 1 

                     -- Activated Sangam Only     

                     AND sangammaster.id = 

                         portaluser.sangamid) 



      /*=============================uspGetInterestedProfiles  Ends===================================================*/

          /*=============================[uspGetProfilesJoinedThisWeek]  Starts===================================================*/ 

          DECLARE @strSQLQuery AS NVARCHAR(max) 



          CREATE TABLE #temptableforrecentlyjoined 

            ( 

               profileid VARCHAR(20) 

            ); 



          WITH cte_recentlyjoined 

               AS (SELECT profileid, 

                          NAME, 

                          Row_number() 

                            OVER ( 

                              partition BY sangamid 

                              ORDER BY createddate DESC) RowNumber 

                   FROM   profilebasicinfo) 

          INSERT INTO #temptableforrecentlyjoined 

                      (profileid) 

          SELECT profileid 

          FROM   cte_recentlyjoined 

          WHERE  rownumber BETWEEN 1 AND 30 



          CREATE TABLE #temptable 

            ( 

               sangamprofileid    VARCHAR(50), 

               mugurthamprofileid VARCHAR(50), 

               NAME               NVARCHAR(150), 

               age                NUMERIC(3, 0), 

               gender             VARCHAR(15), 

               location           NVARCHAR(150), 

               education          NVARCHAR(250), 

               occupation         NVARCHAR(250), 

               aboutme            NVARCHAR(max), 

               sangamid           VARCHAR(50), 

               sangamname         NVARCHAR(450), 

               subcaste           VARCHAR(150), 

               star               VARCHAR(150) 

            ); 



          SET @strSQLQuery = 

          ' INSERT INTO #tempTable           

		  SELECT     profilebasicinfo.sangamprofileid, 

           profilebasicinfo.profileid, 

           profilebasicinfo.NAME, 

           profilebasicinfo.age, 

           profilebasicinfo.gender, 

           profilelocation.residingcity AS location, 

           profilecareer.education, 

           profilecareer.occupation, 

           profilebasicinfo.aboutme, 

           sangammaster.id   AS sangamid, 

           sangammaster.NAME AS sangamname, 

           profilebasicinfo.subcaste, 

           profilebasicinfo.star 

FROM       profilebasicinfo profilebasicinfo WITH (nolock) 

INNER JOIN #temptableforrecentlyjoined AS recentlyjoinedprofiles WITH (nolock) 

ON         recentlyjoinedprofiles.profileid = profilebasicinfo.profileid 

INNER JOIN profilecareer ProfileCareer WITH (nolock) 

ON         profilecareer.profileid = profilebasicinfo.profileid 

INNER JOIN profilelocation ProfileLocation WITH (nolock) 

ON         profilelocation.profileid = profilebasicinfo.profileid 

INNER JOIN portaluser PortalUser WITH (nolock) 

ON         profilebasicinfo.gender IN ( ''' + @Gender + ''') 

AND        portaluser.roleid = ''f62ddfbe55448e3a3''-- User Profiles only    

AND portaluser.isactivated = 1 -- Activated Profile Only   

AND portaluser.loginid = profilebasicinfo.profileid  

INNER JOIN sangammaster SangamMaster WITH (NOLOCK)    

ON sangammaster.isactivated = 1 -- Activated Sangam Only    

AND sangammaster.id = portaluser.sangamid'

          EXECUTE Sp_executesql 

            @strSQLQuery 



          SET @PROFILESJOINEDTHISWEEKCOUNT = (SELECT Count(mugurthamprofileid) 

                                              FROM   #temptable) 

      /*=============================[uspGetProfilesJoinedThisWeek]  Ends===================================================*/ 

          /*=============================[uspGetViewedProfiles] STARTS===================================================*/ 

          SET @PROFILESVIEWEDMECOUNT = (SELECT Count(profilebasicinfo.profileid) 

                                        FROM 

          profilebasicinfo ProfileBasicInfo WITH 

          ( 

          nolock) 

          INNER JOIN profileviewed ProfileViewed 

                     WITH 

                     (nolock) 

                  ON profileviewed.viewedid = 

                     @INTERESTEDID 

                     AND profileviewed.viewerid = 

      profilebasicinfo.profileid 

      INNER JOIN portaluser PortalUser WITH ( 

      nolock) 

      ON profilebasicinfo.gender = 

      @GENDER 

      AND portaluser.roleid = 

      'F62DDFBE55448E3A3' 

      -- User Profiles only     

      AND portaluser.isactivated = 1 

      -- Activated Profile Only     

      AND portaluser.loginid = 

      profilebasicinfo.profileid 

      INNER JOIN sangammaster SangamMaster WITH ( 

      nolock) 

      ON sangammaster.isactivated = 1 

      -- Activated Sangam Only     

      AND sangammaster.id = 

      portaluser.sangamid) 



          /*=============================[uspGetViewedProfiles]  ENDS===================================================*/ 


		  /*=============================[uspGetRecentlyViewedProfiles] STARTS===================================================*/ 

          SET @RECENTLYVIEWEDPROFILESCOUNT = (SELECT Count(profilebasicinfo.profileid) 

                                        FROM 

          profilebasicinfo ProfileBasicInfo WITH 

          ( 

          nolock) 

          INNER JOIN profileviewed ProfileViewed 

                     WITH 

                     (nolock) 

                  ON profileviewed.ViewerID = 

                     @INTERESTEDID 

                     AND profileviewed.ViewedID = 

      profilebasicinfo.profileid 

      INNER JOIN portaluser PortalUser WITH ( 

      nolock) 

      ON profilebasicinfo.gender = 

      @GENDER 

      AND portaluser.roleid = 

      'F62DDFBE55448E3A3' 

      -- User Profiles only     

      AND portaluser.isactivated = 1 

      -- Activated Profile Only     

      AND portaluser.loginid = 

      profilebasicinfo.profileid 

      INNER JOIN sangammaster SangamMaster WITH ( 

      nolock) 

      ON sangammaster.isactivated = 1 

      -- Activated Sangam Only     

      AND sangammaster.id = 

      portaluser.sangamid) 



          /*=============================[uspGetRecentlyViewedProfiles]  ENDS===================================================*/ 


          SELECT @HIGHLIGHTEDPROFILESCOUNT    AS 'HighlightedProfilesCount', 

                 @INTERESTEDINMEPROFILESCOUNT AS 'InterestedInMeProfilesCount', 

                 @INTERESTEDPROFILESCOUNT     AS 'InterestedProfilesCount', 

                 @PROFILESJOINEDTHISWEEKCOUNT AS 'ProfilesJoinedThisWeekCount', 

                 @PROFILESVIEWEDMECOUNT       AS 'ProfilesViewedMeCount',
				 
				 @RECENTLYVIEWEDPROFILESCOUNT       AS 'RecentlyViewedProfilesCount'  



          IF @LOCALTRAN = 1 

             AND Xact_state() = 1 

            COMMIT TRAN localtran 

      END try 



      BEGIN catch 

          DECLARE @ERRORMESSAGE NVARCHAR(4000) 

          DECLARE @ERRORSEVERITY INT 

          DECLARE @ERRORSTATE INT 



          SELECT @ERRORMESSAGE = Error_message(), 

                 @ERRORSEVERITY = Error_severity(), 

                 @ERRORSTATE = Error_state() 



          IF @LOCALTRAN = 1 

             AND Xact_state() <> 0 

            ROLLBACK TRAN 



          RAISERROR ( @ERRORMESSAGE,@ERRORSEVERITY,@ERRORSTATE) 

      END catch 

  END 
GO
/****** Object:  StoredProcedure [dbo].[uspGetProfileBasicInfoView]    Script Date: 6/22/2017 8:10:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


--[uspGetProfileBasicInfoView] 'male', 'ECEBD1B2B0B4FC799', false



-- =====================================================================================================  

-- Author:         <ANAND JAYASEELAN> 

-- Create date:     <APR 11 2016>

-- Description:    <This Procedure will get all the profiles for BasicInfo view display >

-- ======================================================================================================  
CREATE PROCEDURE [dbo].[uspGetProfileBasicInfoView] @GENDER   VARCHAR(30), 
                                                    @SangamID VARCHAR(20),
													@lazyLoad BIT
AS 
  BEGIN 
      DECLARE @strSQLQuery AS NVARCHAR(max) 

      SET nocount ON; 
      SET xact_abort, quoted_identifier, ansi_nulls, ansi_padding, ansi_warnings 
      , 
      arithabort, concat_null_yields_null ON; 
      SET numeric_roundabort OFF; 

      DECLARE @LOCALTRAN BIT 

      IF @@TRANCOUNT = 0 
        BEGIN 
            SET @LOCALTRAN = 1 

            BEGIN TRANSACTION localtran 
        END 

      BEGIN try 
          IF ( @Gender = 'admin' ) 
            SELECT @Gender = ( '''male''' + ', ' + '''female''' ) 

          IF ( @Gender = 'male' ) 
            SELECT @Gender = ( '''male''' ) 

          IF ( @Gender = 'female' ) 
            SELECT @Gender = ( '''female''' ) 

          CREATE TABLE #temptable 
            ( 
               sangamprofileid    VARCHAR(50), 
               mugurthamprofileid VARCHAR(50), 
               NAME               NVARCHAR(150), 
               age                NUMERIC(3, 0), 
               gender             VARCHAR(15), 
               location           NVARCHAR(150), 
               education          NVARCHAR(250), 
               occupation         NVARCHAR(250), 
               aboutme            NVARCHAR(max), 
               sangamid           VARCHAR(50), 
               sangamname         NVARCHAR(450), 
               subcaste           NVARCHAR(150), 
               star               VARCHAR(150), 
               modifieddate       DATETIME 
            ); 

          SET @strSQLQuery = ' INSERT INTO #tempTable  SELECT '

		   IF(@lazyLoad = 1)
            SET @strSQLQuery =  @strSQLQuery + 'TOP 100 '
		          
		 SET @strSQLQuery = @strSQLQuery + 'profilebasicinfo.sangamprofileid, 
           profilebasicinfo.profileid, 
           profilebasicinfo.NAME, 
           profilebasicinfo.age, 
           profilebasicinfo.gender, 
           profilelocation.residingcity AS location, 
           profilecareer.education, 
           profilecareer.occupation, 
           profilebasicinfo.aboutme, 
           sangammaster.id   AS sangamid, 
           sangammaster.NAME AS sangamname, 
           profilebasicinfo.subcaste, 
           profilebasicinfo.star, 
           profilebasicinfo.modifieddate 
FROM       profilebasicinfo profilebasicinfo WITH (nolock) 
INNER JOIN profilecareer ProfileCareer WITH (nolock) 
ON         profilecareer.profileid = profilebasicinfo.profileid 
INNER JOIN profilelocation ProfileLocation WITH (nolock) 
ON         profilelocation.profileid = profilebasicinfo.profileid 
INNER JOIN portaluser PortalUser WITH (nolock) 
ON         profilebasicinfo.gender IN ( ' + @Gender + ') 
AND        portaluser.roleid = ''f62ddfbe55448e3a3''-- User Profiles only   
AND portaluser.isactivated = 1 -- Activated Profile Only   
AND portaluser.loginid = profilebasicinfo.profileid 
INNER JOIN sangammaster SangamMaster WITH (NOLOCK)  
ON sangammaster.isactivated = 1 -- Activated Sangam Only   
AND sangammaster.id = portaluser.sangamid'

          EXECUTE Sp_executesql 
            @strSQLQuery 

          SELECT sangamprofileid, 
                 mugurthamprofileid, 
                 NAME, 
                 age, 
                 CASE gender 
                   WHEN 'male' THEN 'groom' 
                   WHEN 'female' THEN 'bride' 
                   ELSE gender 
                 END "Gender", 
                 location, 
                 education, 
                 occupation, 
                 aboutme, 
                 sangamid, 
                 sangamname, 
                 subcaste, 
                 star 
          FROM   #temptable 
          ORDER  BY CASE 
                      WHEN sangamid = @SangamID THEN 1 
                      ELSE 2 
                    END, 
                    modifieddate DESC 

          SELECT profilephoto.id, 
                 profilephoto.profileid, 
                 profilephoto.photopath, 
                 profilephoto.isprofilepic 
          FROM   profilephoto ProfilePhoto WITH (nolock) 
                 INNER JOIN #temptable SearchDataTable WITH (nolock) 
                         ON profilephoto.profileid = 
                            SearchDataTable.mugurthamprofileid 

          IF @LOCALTRAN = 1 
             AND Xact_state() = 1 
            COMMIT TRAN localtran 
      END try 

      BEGIN catch 
          DECLARE @ERRORMESSAGE NVARCHAR(4000) 
          DECLARE @ERRORSEVERITY INT 
          DECLARE @ERRORSTATE INT 

          SELECT @ERRORMESSAGE = Error_message(), 
                 @ERRORSEVERITY = Error_severity(), 
                 @ERRORSTATE = Error_state() 

          IF @LOCALTRAN = 1 
             AND Xact_state() <> 0 
            ROLLBACK TRAN 

          RAISERROR (@ERRORMESSAGE,@ERRORSEVERITY,@ERRORSTATE) 
      END catch 
  END 
GO
/****** Object:  StoredProcedure [dbo].[uspGetProfileBasicInfoViewLazyLoad]    Script Date: 6/22/2017 8:10:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



/*

[uspGetProfileBasicInfoViewLazyLoad] 'male', 'ECEBD1B2B0B4FC799', true

*/



-- =====================================================================================================  

-- Author:         <ANAND JAYASEELAN> 

-- Create date:     <APR 11 2016>

-- Description:    <This Procedure will get all the profiles for BasicInfo view display >

-- ======================================================================================================  
CREATE PROCEDURE [dbo].[uspGetProfileBasicInfoViewLazyLoad] @GENDER   VARCHAR(30), 
                                                    @SangamID VARCHAR(20),
													@lazyLoad BIT
AS 
  BEGIN 
      DECLARE @strSQLQuery AS NVARCHAR(max) 

      SET nocount ON; 
      SET xact_abort, quoted_identifier, ansi_nulls, ansi_padding, ansi_warnings 
      , 
      arithabort, concat_null_yields_null ON; 
      SET numeric_roundabort OFF; 

      DECLARE @LOCALTRAN BIT 

      IF @@TRANCOUNT = 0 
        BEGIN 
            SET @LOCALTRAN = 1 

            BEGIN TRANSACTION localtran 
        END 

      BEGIN try 
          IF ( @Gender = 'admin' ) 
            SELECT @Gender = ( '''male''' + ', ' + '''female''' ) 

          IF ( @Gender = 'male' ) 
            SELECT @Gender = ( '''male''' ) 

          IF ( @Gender = 'female' ) 
            SELECT @Gender = ( '''female''' ) 

          CREATE TABLE #temptable 
            ( 
               sangamprofileid    VARCHAR(50), 
               mugurthamprofileid VARCHAR(50), 
               NAME               NVARCHAR(150), 
               age                NUMERIC(3, 0), 
               gender             VARCHAR(15), 
               location           NVARCHAR(150), 
               education          NVARCHAR(250), 
               occupation         NVARCHAR(250), 
               aboutme            NVARCHAR(max), 
               sangamid           VARCHAR(50), 
               sangamname         NVARCHAR(450), 
               subcaste           NVARCHAR(150), 
               star               VARCHAR(150), 
               modifieddate       DATETIME 
            ); 

          SET @strSQLQuery = ' INSERT INTO #tempTable  SELECT '

		   IF(@lazyLoad = 1)
            SET @strSQLQuery =  @strSQLQuery + 'TOP 100 '
		          
		 SET @strSQLQuery = @strSQLQuery + 'profilebasicinfo.sangamprofileid, 
           profilebasicinfo.profileid, 
           profilebasicinfo.NAME, 
           profilebasicinfo.age, 
           profilebasicinfo.gender, 
           profilelocation.residingcity AS location, 
           profilecareer.education, 
           profilecareer.occupation, 
           profilebasicinfo.aboutme, 
           sangammaster.id   AS sangamid, 
           sangammaster.NAME AS sangamname, 
           profilebasicinfo.subcaste, 
           profilebasicinfo.star, 
           profilebasicinfo.modifieddate 
FROM       profilebasicinfo profilebasicinfo WITH (nolock) 
INNER JOIN profilecareer ProfileCareer WITH (nolock) 
ON         profilecareer.profileid = profilebasicinfo.profileid 
INNER JOIN profilelocation ProfileLocation WITH (nolock) 
ON         profilelocation.profileid = profilebasicinfo.profileid 
INNER JOIN portaluser PortalUser WITH (nolock) 
ON         profilebasicinfo.gender IN ( ' + @Gender + ') 
AND        portaluser.roleid = ''f62ddfbe55448e3a3''-- User Profiles only   
AND portaluser.isactivated = 1 -- Activated Profile Only   
AND portaluser.loginid = profilebasicinfo.profileid 
INNER JOIN sangammaster SangamMaster WITH (NOLOCK)  
ON sangammaster.isactivated = 1 -- Activated Sangam Only   
AND sangammaster.id = portaluser.sangamid'

          EXECUTE Sp_executesql 
            @strSQLQuery 

          SELECT sangamprofileid, 
                 mugurthamprofileid, 
                 NAME, 
                 age, 
                 CASE gender 
                   WHEN 'male' THEN 'groom' 
                   WHEN 'female' THEN 'bride' 
                   ELSE gender 
                 END "Gender", 
                 location, 
                 education, 
                 occupation, 
                 aboutme, 
                 sangamid, 
                 sangamname, 
                 subcaste, 
                 star 
          FROM   #temptable 
          ORDER  BY CASE 
                      WHEN sangamid = @SangamID THEN 1 
                      ELSE 2 
                    END, 
                    modifieddate DESC 

          SELECT profilephoto.id, 
                 profilephoto.profileid, 
                 profilephoto.photopath, 
                 profilephoto.isprofilepic 
          FROM   profilephoto ProfilePhoto WITH (nolock) 
                 INNER JOIN #temptable SearchDataTable WITH (nolock) 
                         ON profilephoto.profileid = 
                            SearchDataTable.mugurthamprofileid 

          IF @LOCALTRAN = 1 
             AND Xact_state() = 1 
            COMMIT TRAN localtran 
      END try 

      BEGIN catch 
          DECLARE @ERRORMESSAGE NVARCHAR(4000) 
          DECLARE @ERRORSEVERITY INT 
          DECLARE @ERRORSTATE INT 

          SELECT @ERRORMESSAGE = Error_message(), 
                 @ERRORSEVERITY = Error_severity(), 
                 @ERRORSTATE = Error_state() 

          IF @LOCALTRAN = 1 
             AND Xact_state() <> 0 
            ROLLBACK TRAN 

          RAISERROR (@ERRORMESSAGE,@ERRORSEVERITY,@ERRORSTATE) 
      END catch 
  END 

GO
/****** Object:  StoredProcedure [dbo].[uspGetProfilesBySangam]    Script Date: 6/22/2017 8:10:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO








-- =====================================================================================================  

-- Author:         <ANAND JAYASEELAN> 

-- Create date:     <Jun 06 2016>

-- Description:    <This Procedure will get all the profiles by Sangam >

-- ======================================================================================================  

CREATE PROCEDURE [dbo].[uspGetProfilesBySangam] @GENDER varchar(30), @SangamID VARCHAR(20)

AS

BEGIN

  DECLARE @strSQLQuery AS nvarchar(max)



  SET NOCOUNT ON;

  SET XACT_ABORT, QUOTED_IDENTIFIER, ANSI_NULLS, ANSI_PADDING, ANSI_WARNINGS

  ,

  ARITHABORT, CONCAT_NULL_YIELDS_NULL ON;

  SET NUMERIC_ROUNDABORT OFF;



  DECLARE @LOCALTRAN bit



  IF @@TRANCOUNT = 0

  BEGIN

    SET @LOCALTRAN = 1



    BEGIN TRANSACTION localtran

    END



    BEGIN TRY



      IF (@Gender = 'admin')

        SELECT

          @Gender = ('''male''' + ', ' + '''female''')



      IF (@Gender = 'male')

        SELECT

          @Gender = ('''male''')



      IF (@Gender = 'female')

        SELECT

          @Gender = ('''female''')



      CREATE TABLE #tempTable (

        SangamProfileID varchar(50),

        MugurthamProfileID varchar(50),

        Name nvarchar(150),

        Age numeric(3, 0),

        Gender varchar(15),

        Location nvarchar(150),

        Education nvarchar(250),

        Occupation nvarchar(250),

        AboutMe nvarchar(max),

        SangamID varchar(50),

        SangamName nvarchar(450),

		Subcaste nvarchar(150),

		Star varchar(150),

		ModifiedDate Datetime

      );	  



      SET @strSQLQuery = ' INSERT INTO #tempTable

         SELECT

  profilebasicinfo.SangamProfileID,

  profilebasicinfo.ProfileID,

  profilebasicinfo.Name,

  profilebasicinfo.Age,

  profilebasicinfo.Gender,

  ProfileLocation.ResidingCity AS Location,

  ProfileCareer.Education,

  ProfileCareer.Occupation,

  profilebasicinfo.AboutMe,

  SangamMaster.ID AS SangamID,

  SangamMaster.Name AS SangamName,

  profilebasicinfo.SubCaste,

  profilebasicinfo.Star,

  profilebasicinfo.ModifiedDate



  

FROM profilebasicinfo profilebasicinfo WITH (NOLOCK)



INNER JOIN portaluser PortalUser WITH (NOLOCK)

  ON portaluser.isactivated = 1 -- Activated Profile Only

  AND PROFILEBASICINFO.gender in ( ' + @Gender + ')

  AND portaluser.roleid = ''F62DDFBE55448E3A3''-- User Profiles only  

  AND portaluser.loginid = profilebasicinfo.profileid



INNER JOIN ProfileCareer ProfileCareer WITH (NOLOCK)

  ON ProfileCareer.ProfileID = profilebasicinfo.ProfileID

INNER JOIN ProfileLocation ProfileLocation WITH (NOLOCK)

  ON ProfileLocation.ProfileID = profilebasicinfo.ProfileID





INNER JOIN sangammaster SangamMaster WITH (NOLOCK)

  ON sangammaster.ID = ''' + @SangamID + ''' -- Activated Sangam Only

  AND sangammaster.isactivated = 1 -- Activated Sangam Only

  AND sangammaster.id = portaluser.sangamid'

  print @strSQLQuery

     EXECUTE Sp_executesql @strSQLQuery



      SELECT

        SangamProfileID,

        MugurthamProfileID,

        Name,

        Age,

        CASE Gender

		  WHEN 'male' THEN 'groom'

		  WHEN 'female' THEN 'bride'

		  ELSE gender

		  END

		"Gender",

        Location,

        Education,

        Occupation,

        AboutMe,

        SangamID,

        SangamName,

		Subcaste,

		Star

      FROM #tempTable WITH (NOLOCK)

	  ORDER BY MugurthamProfileID

	      

		

      IF @LOCALTRAN = 1

        AND XACT_STATE() = 1

      COMMIT TRAN localtran

  END TRY



  BEGIN CATCH

    DECLARE @ERRORMESSAGE nvarchar(4000)

    DECLARE @ERRORSEVERITY int

    DECLARE @ERRORSTATE int



    SELECT

      @ERRORMESSAGE = ERROR_MESSAGE(),

      @ERRORSEVERITY = ERROR_SEVERITY(),

      @ERRORSTATE = ERROR_STATE()







    IF @LOCALTRAN = 1

      AND XACT_STATE() <> 0

      ROLLBACK TRAN



    RAISERROR (@ERRORMESSAGE, @ERRORSEVERITY, @ERRORSTATE)

  END CATCH

END









GO
/****** Object:  StoredProcedure [dbo].[Uspgetprofilesjoinedrecently]    Script Date: 6/22/2017 8:10:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =====================================================================================================  

-- Author:         <ANAND JAYASEELAN> 

-- Create date:     <JUN 17 2016>

-- Description:    <This Procedure will get 20 profiles joined recently from each and every Association>

-- ======================================================================================================   

CREATE PROCEDURE [dbo].[Uspgetprofilesjoinedrecently] @GENDER VARCHAR(30),@SangamID VARCHAR(20) 

AS 

  BEGIN 

      DECLARE @strSQLQuery AS NVARCHAR(max) 



      SET nocount ON; 

      SET xact_abort, quoted_identifier, ansi_nulls, ansi_padding, ansi_warnings 

      , 

      arithabort, concat_null_yields_null ON; 

      SET numeric_roundabort OFF; 



      DECLARE @LOCALTRAN BIT 



      IF @@TRANCOUNT = 0 

        BEGIN 

            SET @LOCALTRAN = 1 



            BEGIN TRANSACTION localtran 

        END 



      BEGIN try 

          CREATE TABLE #temptableforrecentlyjoined 

            ( 

               profileid VARCHAR(20) 

            ) 



          IF ( @Gender = 'admin' ) 

            SELECT @Gender = ( '''male''' + ', ' + '''female''' ) 



          IF ( @Gender = 'male' ) 

            SELECT @Gender = ( '''male''' ) 



          IF ( @Gender = 'female' ) 

            SELECT @Gender = ( '''female''' ); 



          WITH cte_recentlyjoined 

               AS (SELECT profileid, 

                          NAME, 

                          Row_number() 

                            OVER ( 

                              partition BY sangamid 

                              ORDER BY createddate DESC) RowNumber 

                   FROM   profilebasicinfo) 

          INSERT INTO #temptableforrecentlyjoined 

                      (profileid) 

          SELECT profileid 

          FROM   cte_recentlyjoined 

          WHERE  rownumber BETWEEN 1 AND 30 



          CREATE TABLE #temptable 

            ( 

               sangamprofileid    VARCHAR(50), 

               mugurthamprofileid VARCHAR(50), 

               NAME               NVARCHAR(150), 

               age                NUMERIC(3, 0), 

               gender             VARCHAR(15), 

               location           NVARCHAR(150), 

               education          NVARCHAR(250), 

               occupation         NVARCHAR(250), 

               aboutme            NVARCHAR(max), 

               sangamid           VARCHAR(50), 

               sangamname         NVARCHAR(450), 

               subcaste           VARCHAR(150), 

               star               VARCHAR(150),

			   ModifiedDate		  Datetime 

            ); 



          SET @strSQLQuery = ' INSERT INTO #tempTable         

											  SELECT     profilebasicinfo.sangamprofileid, 

														   profilebasicinfo.profileid, 

														   profilebasicinfo.NAME, 

														   profilebasicinfo.age, 

														   profilebasicinfo.gender, 

														   profilelocation.residingcity AS location, 

														   profilecareer.education, 

														   profilecareer.occupation, 

														   profilebasicinfo.aboutme, 

														   sangammaster.id   AS sangamid, 

														   sangammaster.NAME AS sangamname, 

														   profilebasicinfo.subcaste, 

														   profilebasicinfo.star,

														   profilebasicinfo.ModifiedDate 

												FROM       profilebasicinfo profilebasicinfo WITH (nolock) 

												INNER JOIN #temptableforrecentlyjoined AS recentlyjoinedprofiles WITH (nolock) 

												ON         recentlyjoinedprofiles.profileid = profilebasicinfo.profileid 

												INNER JOIN profilecareer ProfileCareer WITH (nolock) 

												ON         profilecareer.profileid = profilebasicinfo.profileid 

												INNER JOIN profilelocation ProfileLocation WITH (nolock) 

												ON         profilelocation.profileid = profilebasicinfo.profileid 

												INNER JOIN portaluser PortalUser WITH (nolock) 

												ON         profilebasicinfo.gender IN ( '+ @Gender + ') 

												AND        portaluser.roleid = ''f62ddfbe55448e3a3''-- User Profiles only   

												AND portaluser.isactivated = 1 -- Activated Profile Only  

												AND portaluser.loginid = profilebasicinfo.profileid 

												INNER JOIN sangammaster SangamMaster WITH (NOLOCK)   

												ON sangammaster.isactivated = 1 -- Activated Sangam Only   

												AND sangammaster.id = portaluser.sangamid'



          EXECUTE Sp_executesql 

            @strSQLQuery 



          SELECT sangamprofileid, 

                 mugurthamprofileid, 

                 NAME, 

                 age, 

                 gender, 

                 location, 

                 education, 

                 occupation, 

                 aboutme, 

                 sangamid, 

                 sangamname, 

                 subcaste, 

                 star 

          FROM   #temptable WITH (NOLOCK)

	     ORDER BY CASE WHEN SangamID = @SangamID THEN 1 ELSE 2 END, ModifiedDate DESC 



          SELECT profilephoto.id, 

                 profilephoto.profileid, 

                 profilephoto.photopath, 

                 profilephoto.isprofilepic 

          FROM   profilephoto ProfilePhoto WITH (nolock) 

                 INNER JOIN #temptable SearchDataTable WITH (nolock) 

                         ON profilephoto.profileid = 

                            SearchDataTable.mugurthamprofileid 



          IF @LOCALTRAN = 1 

             AND Xact_state() = 1 

            COMMIT TRAN localtran 

      END try 



      BEGIN catch 

          DECLARE @ERRORMESSAGE NVARCHAR(4000) 

          DECLARE @ERRORSEVERITY INT 

          DECLARE @ERRORSTATE INT 



          SELECT @ERRORMESSAGE = Error_message(), 

                 @ERRORSEVERITY = Error_severity(), 

                 @ERRORSTATE = Error_state() 



          IF @LOCALTRAN = 1 

             AND Xact_state() <> 0 

            ROLLBACK TRAN 



          RAISERROR (@ERRORMESSAGE,@ERRORSEVERITY,@ERRORSTATE) 

      END catch 

  END 







GO
/****** Object:  StoredProcedure [dbo].[uspGetProfilesJoinedThisWeek]    Script Date: 6/22/2017 8:10:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:      <ANAND JAYASEELAN>
-- Create date: <JUN 01 2015>
-- Description: <GETS ALL THE RECENTLY ADDED PROFILES THIS WEEK>
-- =============================================

CREATE PROCEDURE [dbo].[uspGetProfilesJoinedThisWeek] @Gender   VARCHAR(30),
                                                     @SangamID VARCHAR(20)
AS
  BEGIN
      DECLARE @strSQLQuery AS NVARCHAR(max)

      SET nocount ON;
      SET xact_abort, quoted_identifier, ansi_nulls, ansi_padding, ansi_warnings
      ,
      arithabort, concat_null_yields_null ON;
      SET numeric_roundabort OFF;

      DECLARE @localTran BIT

      IF @@TRANCOUNT = 0
        BEGIN
            SET @localTran = 1

            BEGIN TRANSACTION localtran
        END

      BEGIN try
          SET @strSQLQuery =
          'SELECT profilebasicinfo.elanuserid,
                 profilebasicinfo.profileid,
                 profilebasicinfo.NAME,
                 profilebasicinfo.age,
                 profilebasicinfo.gender,
                 profilebasicinfo.dateofbirth,
                 profilebasicinfo.tamildob,
                 profilebasicinfo.timeofbirth,
                 profilebasicinfo.placeofbirth,
                 profilebasicinfo.maritalstatus,
                 profilebasicinfo.noofchildren,
                 profilebasicinfo.childrenlivingstatus,
                 profilebasicinfo.height,
                 profilebasicinfo.weight,
                 profilebasicinfo.bodytype,
                 profilebasicinfo.complexion,
                 profilebasicinfo.physicalstatus,
                 profilebasicinfo.bloodgroup,
                 profilebasicinfo.mothertongue,
                 profilebasicinfo.profilecreatedby,
                 profilebasicinfo.religion,
                 profilebasicinfo.caste,
                 profilebasicinfo.subcaste,
                 profilebasicinfo.gothram,
                 profilebasicinfo.star,
                 profilebasicinfo.raasi,
                 profilebasicinfo.zodiac,
                 profilebasicinfo.horoscopematch,
                 profilebasicinfo.anydosham,
                 profilebasicinfo.eating,
                 profilebasicinfo.smoking,
                 profilebasicinfo.drinking,
                 profilebasicinfo.aboutme,
                 profilebasicinfo.partnerexpectations,
                 profilebasicinfo.createdby,
                 profilebasicinfo.createddate,
                 profilebasicinfo.zodiacyear,
                 profilebasicinfo.zodiacmonth,
                 profilebasicinfo.zodiacday,
                 profilebasicinfo.photopath,
                 profilebasicinfo.sangamid,
                 profilebasicinfo.modifiedby,
                 profilebasicinfo.modifieddate,
				 1 as "sangam"
          FROM   profilebasicinfo ProfileBasicInfo WITH (nolock)
                 INNER JOIN portaluser PortalUser WITH (nolock)
				  ON ProfileBasicInfo.CreatedDate >= getdate() - 7 AND '

          IF( @Gender = 'admin' )
            SELECT @Gender = ( '''male''' + ', ' + '''female''' )

          IF( @Gender = 'male' )
            SELECT @Gender = ( '''male''' )

          IF( @Gender = 'female' )
            SELECT @Gender = ( '''female''' )

          SET @strSQLQuery = @strSQLQuery
                             + ' ProfileBasicInfo.Gender in ( ' + @Gender
                             + ')
						 AND portaluser.roleid = ''F62DDFBE55448E3A3''
                            -- User Profiles only
                            AND portaluser.isactivated = 1
                            -- Activated Profile Only
                            AND portaluser.loginid = profilebasicinfo.profileid
                 INNER JOIN sangammaster SangamMaster WITH (nolock)
                         ON sangammaster.id = '
                             + '''' + @SangamID + ''''
                             +
          '
						 AND sangammaster.isactivated = 1
                            -- Activated Sangam Only
                            AND sangammaster.id = portaluser.sangamid 
							union all
							SELECT profilebasicinfo.elanuserid,
                 profilebasicinfo.profileid,
                 profilebasicinfo.NAME,
                 profilebasicinfo.age,
                 profilebasicinfo.gender,
                 profilebasicinfo.dateofbirth,
                 profilebasicinfo.tamildob,
                 profilebasicinfo.timeofbirth,
                 profilebasicinfo.placeofbirth,
                 profilebasicinfo.maritalstatus,
                 profilebasicinfo.noofchildren,
                 profilebasicinfo.childrenlivingstatus,
                 profilebasicinfo.height,
                 profilebasicinfo.weight,
                 profilebasicinfo.bodytype,
                 profilebasicinfo.complexion,
                 profilebasicinfo.physicalstatus,
                 profilebasicinfo.bloodgroup,
                 profilebasicinfo.mothertongue,
                 profilebasicinfo.profilecreatedby,
                 profilebasicinfo.religion,
                 profilebasicinfo.caste,
                 profilebasicinfo.subcaste,
                 profilebasicinfo.gothram,
                 profilebasicinfo.star,
                 profilebasicinfo.raasi,
                 profilebasicinfo.zodiac,
                 profilebasicinfo.horoscopematch,
                 profilebasicinfo.anydosham,
                 profilebasicinfo.eating,
                 profilebasicinfo.smoking,
                 profilebasicinfo.drinking,
                 profilebasicinfo.aboutme,
                 profilebasicinfo.partnerexpectations,
                 profilebasicinfo.createdby,
                 profilebasicinfo.createddate,
                 profilebasicinfo.zodiacyear,
                 profilebasicinfo.zodiacmonth,
                 profilebasicinfo.zodiacday,
                 profilebasicinfo.photopath,
                 profilebasicinfo.sangamid,
                 profilebasicinfo.modifiedby,
                 profilebasicinfo.modifieddate,
				 2 as "sangam"
          FROM   profilebasicinfo ProfileBasicInfo WITH (nolock)
                 INNER JOIN portaluser PortalUser WITH (nolock)
				  ON ProfileBasicInfo.CreatedDate >= getdate() - 7 AND '

          IF( @Gender = 'admin' )
            SELECT @Gender = ( '''male''' + ', ' + '''female''' )

          IF( @Gender = 'male' )
            SELECT @Gender = ( '''male''' )

          IF( @Gender = 'female' )
            SELECT @Gender = ( '''female''' )

          SET @strSQLQuery = @strSQLQuery
                             + ' ProfileBasicInfo.Gender in ( ' + @Gender
                             + ')
						 AND portaluser.roleid = ''F62DDFBE55448E3A3''
                            -- User Profiles only
                            AND portaluser.isactivated = 1
                            -- Activated Profile Only
                            AND portaluser.loginid = profilebasicinfo.profileid
                 INNER JOIN sangammaster SangamMaster WITH (nolock)
                         ON sangammaster.id <> '
                             + '''' + @SangamID + '''' + '
						 AND sangammaster.isactivated = 1
                            -- Activated Sangam Only
                            AND sangammaster.id = portaluser.sangamid	
							order by sangam, profilebasicinfo.createddate desc						
							'

          EXECUTE Sp_executesql
            @strSQLQuery

          IF @localTran = 1
             AND Xact_state() = 1
            COMMIT TRAN localtran
      END try

      BEGIN catch
          DECLARE @ErrorMessage NVARCHAR(4000)
          DECLARE @ErrorSeverity INT
          DECLARE @ErrorState INT

          SELECT @ErrorMessage = Error_message(),
                 @ErrorSeverity = Error_severity(),
                 @ErrorState = Error_state()

          IF @localTran = 1
             AND Xact_state() <> 0
            ROLLBACK TRAN

          RAISERROR ( @ErrorMessage,@ErrorSeverity,@ErrorState)
      END catch
  END 

GO
/****** Object:  StoredProcedure [dbo].[uspGetRecentlyViewedProfiles]    Script Date: 6/22/2017 8:10:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



-- ==========================================================================

-- Author:      <ANAND JAYASEELAN>

-- Create date: <JUN 3 2015>

-- Description: <GETS THE VIEW NOTIFICATION OF THE LOGGED IN PROFILE>

-- Updated: <May 01 2015> for Performance Optimization

--          <May 16 2015> Orderby SangamID and ModifiedDate DESC

-- ============================================================================
CREATE PROCEDURE [dbo].[uspGetRecentlyViewedProfiles] @Gender       VARCHAR(30), 
                                              @InterestedID VARCHAR(50), 
                                              @SangamID     VARCHAR(20) 
AS 
  BEGIN 
      DECLARE @strSQLQuery AS NVARCHAR(max) 

      SET nocount ON; 
      SET xact_abort, quoted_identifier, ansi_nulls, ansi_padding, ansi_warnings 
      , 
      arithabort, concat_null_yields_null ON; 
      SET numeric_roundabort OFF; 

      DECLARE @LOCALTRAN BIT 

      IF @@TRANCOUNT = 0 
        BEGIN 
            SET @LOCALTRAN = 1 

            BEGIN TRANSACTION localtran 
        END 

      BEGIN try 
          IF ( @Gender = 'admin' ) 
            SELECT @Gender = ( '''male''' + ', ' + '''female''' ) 

          IF ( @Gender = 'male' ) 
            SELECT @Gender = ( '''male''' ) 

          IF ( @Gender = 'female' ) 
            SELECT @Gender = ( '''female''' ) 

          CREATE TABLE #temptable 
            ( 
               sangamprofileid    VARCHAR(50), 
               mugurthamprofileid VARCHAR(50), 
               NAME               NVARCHAR(150), 
               age                NUMERIC(3, 0), 
               gender             VARCHAR(15), 
               location           NVARCHAR(150), 
               education          NVARCHAR(250), 
               occupation         NVARCHAR(250), 
               aboutme            NVARCHAR(max), 
               sangamid           VARCHAR(50), 
               sangamname         NVARCHAR(450), 
               subcaste           NVARCHAR(150), 
               star               VARCHAR(150), 
               modifieddate       DATETIME,
			   vieweddate		  DATETIME,
            ); 

          SET @strSQLQuery = ' INSERT INTO #tempTable          
		  SELECT     profilebasicinfo.sangamprofileid, 
           profilebasicinfo.profileid, 
           profilebasicinfo.NAME, 
           profilebasicinfo.age, 
           profilebasicinfo.gender, 
           profilelocation.residingcity AS location, 
           profilecareer.education, 
           profilecareer.occupation, 
           profilebasicinfo.aboutme, 
           sangammaster.id   AS sangamid, 
           sangammaster.NAME AS sangamname, 
           profilebasicinfo.subcaste, 
           profilebasicinfo.star, 
           profilebasicinfo.modifieddate,
		   profileviewed.vieweddate 
FROM       profilebasicinfo profilebasicinfo WITH (nolock) 
INNER JOIN profileviewed ProfileViewed WITH (nolock) 
ON         profileviewed.viewerid = ''' + @InterestedID + ''' 
AND        profileviewed.viewedid = profilebasicinfo.profileid 
INNER JOIN profilecareer ProfileCareer WITH (nolock) 
ON         profilecareer.profileid = profilebasicinfo.profileid 
INNER JOIN profilelocation ProfileLocation WITH (nolock) 
ON         profilelocation.profileid = profilebasicinfo.profileid 
INNER JOIN portaluser PortalUser WITH (nolock) 
ON         profilebasicinfo.gender IN ( ' + @Gender + ') 
AND        portaluser.roleid = ''f62ddfbe55448e3a3''-- User Profiles only  
 AND portaluser.isactivated = 1 -- Activated Profile Only  
  AND portaluser.loginid = profilebasicinfo.profileid 
  INNER JOIN sangammaster SangamMaster WITH (NOLOCK)   
  ON sangammaster.isactivated = 1 -- Activated Sangam Only   
  AND sangammaster.id = portaluser.sangamid'
  
  
          EXECUTE Sp_executesql 
            @strSQLQuery 

          SELECT sangamprofileid, 
                 mugurthamprofileid, 
                 NAME, 
                 age, 
                 CASE gender 
                   WHEN 'male' THEN 'groom' 
                   WHEN 'female' THEN 'bride' 
                   ELSE gender 
                 END "Gender", 
                 location, 
                 education, 
                 occupation, 
                 aboutme, 
                 sangamid, 
                 sangamname, 
                 subcaste, 
                 star,
				 vieweddate 
          FROM   #temptable WITH (nolock) 
          ORDER  BY vieweddate desc
		  /*, CASE 
                      WHEN sangamid = @SangamID THEN 1 
                      ELSE 2 
                    END, 
                    modifieddate DESC */

          SELECT profilephoto.id, 
                 profilephoto.profileid, 
                 profilephoto.photopath, 
                 profilephoto.isprofilepic 
          FROM   profilephoto ProfilePhoto WITH (nolock) 
                 INNER JOIN #temptable SearchDataTable WITH (nolock) 
                         ON profilephoto.profileid = 
                            SearchDataTable.mugurthamprofileid 

          IF @LOCALTRAN = 1 
             AND Xact_state() = 1 
            COMMIT TRAN localtran 
      END try 

      BEGIN catch 
          DECLARE @ERRORMESSAGE NVARCHAR(4000) 
          DECLARE @ERRORSEVERITY INT 
          DECLARE @ERRORSTATE INT 

          SELECT @ERRORMESSAGE = Error_message(), 
                 @ERRORSEVERITY = Error_severity(), 
                 @ERRORSTATE = Error_state() 

          IF @LOCALTRAN = 1 
             AND Xact_state() <> 0 
            ROLLBACK TRAN 

          RAISERROR (@ERRORMESSAGE,@ERRORSEVERITY,@ERRORSTATE) 
      END catch 
  END 

GO
/****** Object:  StoredProcedure [dbo].[uspGetSangamProfilesInfo]    Script Date: 6/22/2017 8:10:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- ======================================================================
-- Author:			Anand Jayaseelan  
-- Create date:     Dec 13 2016
-- Description:     Gets the basic information for Sangam Dashboard
-- ======================================================================
CREATE PROCEDURE [dbo].[uspGetSangamProfilesInfo] @SangamID VARCHAR(20) 
AS 
  BEGIN 
      DECLARE @strSQLQuery AS NVARCHAR(max) 

      SET nocount ON; 
      SET xact_abort, quoted_identifier, ansi_nulls, ansi_padding, ansi_warnings 
      , 
      arithabort, concat_null_yields_null ON; 
      SET numeric_roundabort OFF; 

      DECLARE @localTran BIT 
	  DECLARE @LoggedInCount numeric(18,0), 
			  @ViewedProfile numeric(18,0), 
			  @ActiveProfiles numeric(18,0), 
			  @TotalProfiles numeric(18,0)
        

      IF @@TRANCOUNT = 0 
        BEGIN 
            SET @localTran = 1 

            BEGIN TRANSACTION localtran 
        END 

      BEGIN try 
          -- Portal Login  
          SELECT @LoggedInCount =  Count(*)  
          FROM   portalsession portalsession 
                 INNER JOIN portaluser portaluser 
                         ON portaluser.loginid = portalsession.userid 
                 INNER JOIN sangammaster Sangammaster 
                         ON sangammaster.id = @SangamID
                            AND portaluser.sangamid = sangammaster.id 
                            AND portalsession.logintime >= '2016-12-01' 

          -- Profile Viewed  
         SELECT @ViewedProfile =  Count(*) 
          FROM   profileviewed profileviewed 
                 INNER JOIN portaluser portaluser 
                         ON portaluser.loginid = profileviewed.viewedid 
                 INNER JOIN sangammaster Sangammaster 
                         ON sangammaster.id = @SangamID
                            AND portaluser.sangamid = sangammaster.id 

          -- Active Profiles  
         SELECT @ActiveProfiles =  Count(*) 
          FROM   portaluser 
          WHERE  sangamid = @SangamID
                 AND isactivated = 1 

          -- Total Profiles  
          SELECT @TotalProfiles =  Count(*) 
          FROM   portaluser 
          WHERE  sangamid = @SangamID

		  Select @LoggedInCount AS 'LoggedInCount',
				 @ViewedProfile AS 'ViewedProfile',
				 @ActiveProfiles AS 'ActiveProfiles',
				 @TotalProfiles  AS 'TotalProfiles'

          IF @localTran = 1 
             AND Xact_state() = 1 
            COMMIT TRAN localtran 
      END try 

      BEGIN catch 
          DECLARE @ErrorMessage NVARCHAR(4000) 
          DECLARE @ErrorSeverity INT 
          DECLARE @ErrorState INT 

          SELECT @ErrorMessage = Error_message(), 
                 @ErrorSeverity = Error_severity(), 
                 @ErrorState = Error_state() 

          IF @localTran = 1 
             AND Xact_state() <> 0 
            ROLLBACK TRAN 

          RAISERROR ( @ErrorMessage,@ErrorSeverity,@ErrorState) 
      END catch 
  END 
GO
/****** Object:  StoredProcedure [dbo].[uspGetViewedProfiles]    Script Date: 6/22/2017 8:10:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- ==========================================================================

-- Author:      <ANAND JAYASEELAN>

-- Create date: <JUN 3 2015>

-- Description: <GETS THE VIEW NOTIFICATION OF THE LOGGED IN PROFILE>

-- Updated: <May 01 2015> for Performance Optimization

--          <May 16 2015> Orderby SangamID and ModifiedDate DESC

-- ============================================================================
CREATE PROCEDURE [dbo].[uspGetViewedProfiles] @Gender       VARCHAR(30), 
                                              @InterestedID VARCHAR(50), 
                                              @SangamID     VARCHAR(20) 
AS 
  BEGIN 
      DECLARE @strSQLQuery AS NVARCHAR(max) 

      SET nocount ON; 
      SET xact_abort, quoted_identifier, ansi_nulls, ansi_padding, ansi_warnings 
      , 
      arithabort, concat_null_yields_null ON; 
      SET numeric_roundabort OFF; 

      DECLARE @LOCALTRAN BIT 

      IF @@TRANCOUNT = 0 
        BEGIN 
            SET @LOCALTRAN = 1 

            BEGIN TRANSACTION localtran 
        END 

      BEGIN try 
          IF ( @Gender = 'admin' ) 
            SELECT @Gender = ( '''male''' + ', ' + '''female''' ) 

          IF ( @Gender = 'male' ) 
            SELECT @Gender = ( '''male''' ) 

          IF ( @Gender = 'female' ) 
            SELECT @Gender = ( '''female''' ) 

          CREATE TABLE #temptable 
            ( 
               sangamprofileid    VARCHAR(50), 
               mugurthamprofileid VARCHAR(50), 
               NAME               NVARCHAR(150), 
               age                NUMERIC(3, 0), 
               gender             VARCHAR(15), 
               location           NVARCHAR(150), 
               education          NVARCHAR(250), 
               occupation         NVARCHAR(250), 
               aboutme            NVARCHAR(max), 
               sangamid           VARCHAR(50), 
               sangamname         NVARCHAR(450), 
               subcaste           NVARCHAR(150), 
               star               VARCHAR(150), 
               modifieddate       DATETIME 
            ); 

          SET @strSQLQuery = ' INSERT INTO #tempTable          
		  SELECT     profilebasicinfo.sangamprofileid, 
           profilebasicinfo.profileid, 
           profilebasicinfo.NAME, 
           profilebasicinfo.age, 
           profilebasicinfo.gender, 
           profilelocation.residingcity AS location, 
           profilecareer.education, 
           profilecareer.occupation, 
           profilebasicinfo.aboutme, 
           sangammaster.id   AS sangamid, 
           sangammaster.NAME AS sangamname, 
           profilebasicinfo.subcaste, 
           profilebasicinfo.star, 
           profilebasicinfo.modifieddate 
FROM       profilebasicinfo profilebasicinfo WITH (nolock) 
INNER JOIN profileviewed ProfileViewed WITH (nolock) 
ON         profileviewed.viewedid = ''' + @InterestedID + ''' 
AND        profileviewed.viewerid = profilebasicinfo.profileid 
INNER JOIN profilecareer ProfileCareer WITH (nolock) 
ON         profilecareer.profileid = profilebasicinfo.profileid 
INNER JOIN profilelocation ProfileLocation WITH (nolock) 
ON         profilelocation.profileid = profilebasicinfo.profileid 
INNER JOIN portaluser PortalUser WITH (nolock) 
ON         profilebasicinfo.gender IN ( ' + @Gender + ') 
AND        portaluser.roleid = ''f62ddfbe55448e3a3''-- User Profiles only  
 AND portaluser.isactivated = 1 -- Activated Profile Only  
  AND portaluser.loginid = profilebasicinfo.profileid 
  INNER JOIN sangammaster SangamMaster WITH (NOLOCK)   
  ON sangammaster.isactivated = 1 -- Activated Sangam Only   
  AND sangammaster.id = portaluser.sangamid'

          EXECUTE Sp_executesql 
            @strSQLQuery 

          SELECT sangamprofileid, 
                 mugurthamprofileid, 
                 NAME, 
                 age, 
                 CASE gender 
                   WHEN 'male' THEN 'groom' 
                   WHEN 'female' THEN 'bride' 
                   ELSE gender 
                 END "Gender", 
                 location, 
                 education, 
                 occupation, 
                 aboutme, 
                 sangamid, 
                 sangamname, 
                 subcaste, 
                 star 
          FROM   #temptable WITH (nolock) 
          ORDER  BY CASE 
                      WHEN sangamid = @SangamID THEN 1 
                      ELSE 2 
                    END, 
                    modifieddate DESC 

          SELECT profilephoto.id, 
                 profilephoto.profileid, 
                 profilephoto.photopath, 
                 profilephoto.isprofilepic 
          FROM   profilephoto ProfilePhoto WITH (nolock) 
                 INNER JOIN #temptable SearchDataTable WITH (nolock) 
                         ON profilephoto.profileid = 
                            SearchDataTable.mugurthamprofileid 

          IF @LOCALTRAN = 1 
             AND Xact_state() = 1 
            COMMIT TRAN localtran 
      END try 

      BEGIN catch 
          DECLARE @ERRORMESSAGE NVARCHAR(4000) 
          DECLARE @ERRORSEVERITY INT 
          DECLARE @ERRORSTATE INT 

          SELECT @ERRORMESSAGE = Error_message(), 
                 @ERRORSEVERITY = Error_severity(), 
                 @ERRORSTATE = Error_state() 

          IF @LOCALTRAN = 1 
             AND Xact_state() <> 0 
            ROLLBACK TRAN 

          RAISERROR (@ERRORMESSAGE,@ERRORSEVERITY,@ERRORSTATE) 
      END catch 
  END 
GO
/****** Object:  StoredProcedure [dbo].[uspGetViewedProfilesToday]    Script Date: 6/22/2017 8:10:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- ============================================= 
-- Author:      <ANAND JAYASEELAN>
-- Create date: <JAN 28 2017>
-- Description: <This procedure is used for Restriction purpose where the user is allowed to see only 10 full view perday for security purpose.>

-- ============================================= 
Create PROCEDURE [dbo].[uspGetViewedProfilesToday] @viewerID VARCHAR(20) 
AS 
  BEGIN 
      DECLARE @strSQLQuery AS NVARCHAR(4000) 

      SET nocount ON; 
      SET xact_abort, quoted_identifier, ansi_nulls, ansi_padding, ansi_warnings 
      , 
      arithabort, concat_null_yields_null ON; 
      SET numeric_roundabort OFF; 

      DECLARE @localTran BIT 

      IF @@TRANCOUNT = 0 
        BEGIN 
            SET @localTran = 1 

            BEGIN TRANSACTION localtran 
        END 

      BEGIN try 
          SET @strSQLQuery = 
  'select ID,ViewerID,ViewedID,ViewedDate from ProfileViewed where ViewerID = ' 
  + '''' + @viewerID 
  + 
''' and  DATEADD(dd, DATEDIFF(dd, 0, ViewedDate), 0) = DATEADD(dd, DATEDIFF(dd, 0, getdate()), 0) ' 

    EXECUTE Sp_executesql 
      @strSQLQuery 

    IF @localTran = 1 
       AND Xact_state() = 1 
      COMMIT TRAN localtran 
END try 

    BEGIN catch 
        DECLARE @ErrorMessage NVARCHAR(4000) 
        DECLARE @ErrorSeverity INT 
        DECLARE @ErrorState INT 

        SELECT @ErrorMessage = Error_message(), 
               @ErrorSeverity = Error_severity(), 
               @ErrorState = Error_state() 

        IF @localTran = 1 
           AND Xact_state() <> 0 
          ROLLBACK TRAN 

        RAISERROR ( @ErrorMessage,@ErrorSeverity,@ErrorState) 
    END catch 
END 
GO
/****** Object:  StoredProcedure [dbo].[uspGetYearlySalesReport]    Script Date: 6/22/2017 8:10:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:      <ANAND JAYASEELAN>
-- Create date: <APR 21 2014>
-- Description: <[uspGetYearlySalesReport]>
-- =============================================
CREATE PROCEDURE [dbo].[uspGetYearlySalesReport] @SangamID varchar(20) 		
AS
  BEGIN
      DECLARE @strSQLQuery AS NVARCHAR(4000)

      SET nocount ON;
      SET xact_abort, quoted_identifier, ansi_nulls, ansi_padding, ansi_warnings
      ,
      arithabort, concat_null_yields_null ON;
      SET numeric_roundabort OFF;

      DECLARE @localTran BIT

      IF @@TRANCOUNT = 0
        BEGIN
            SET @localTran = 1

            BEGIN TRANSACTION localtran
        END
		
      BEGIN try   
	  SET @strSQLQuery ='Delete from SangamDashboardChart where SangamID = ' + '''' + @SangamID+ ''''
	  EXECUTE Sp_executesql @strSQLQuery
	  Insert into SangamDashboardChart (ID,Count,Month,SangamID)
	  SELECT LEFT(NEWID(),20),
          Count(profileid), --as Data, -- Column Names just to match the EF DTO
                 Datename( month, Dateadd( month, Datepart(mm, createddate), -1
                 )
                 )
                 ,--        AS Month -- Column Names just to match the EF DTO
		  @SangamID
          FROM   profilebasicinfo
          WHERE  SangamID = @SangamID AND
		  Year(createddate) = year(getdate())
          GROUP  BY Datepart(mm, createddate)
          ORDER  BY Datepart(mm, createddate)
		  
		  SET @strSQLQuery ='Select ID,Count,Month,SangamID from SangamDashboardChart where SangamID = ' + '''' + @SangamID+ ''''  + 'ORDER  BY DATEPART(MM, Month +'' 01 2015'')'
		  print @strSQLQuery
		   EXECUTE Sp_executesql @strSQLQuery
          IF @localTran = 1
             AND Xact_state() = 1
            COMMIT TRAN localtran
      END try

      BEGIN catch
          DECLARE @ErrorMessage NVARCHAR(4000)
          DECLARE @ErrorSeverity INT
          DECLARE @ErrorState INT

          SELECT @ErrorMessage = Error_message(),
                 @ErrorSeverity = Error_severity(),
                 @ErrorState = Error_state()

          IF @localTran = 1
             AND Xact_state() <> 0
            ROLLBACK TRAN

          RAISERROR ( @ErrorMessage,@ErrorSeverity,@ErrorState)
      END catch
  END


GO
/****** Object:  Table [dbo].[dtpProfileCollection]    Script Date: 6/22/2017 8:10:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[dtpProfileCollection](
	[ID] [varchar](20) NOT NULL,
	[SangamID] [varchar](20) NULL,
	[Collection] [numeric](18, 0) NULL,
	[CollectedBy] [varchar](20) NULL,
	[CollectedDate] [datetime] NULL,
	[CreatedBy] [varchar](20) NULL,
	[CreatedDate] [datetime] NULL,
	[UploadedBy] [nvarchar](100) NULL,
 CONSTRAINT [PK_dtpProfileCollection] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PaymentGatewayTransactions]    Script Date: 6/22/2017 8:10:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PaymentGatewayTransactions](
	[TransactionID] [varchar](20) NOT NULL,
	[OrderID] [varchar](50) NULL,
	[TrackingID] [varchar](50) NULL,
	[BankRefNo] [varchar](50) NULL,
	[OrderStatus] [varchar](25) NULL,
	[FailureMessage] [varchar](250) NULL,
	[PaymentMode] [varchar](50) NULL,
	[CardName] [varchar](50) NULL,
	[StatusCode] [varchar](50) NULL,
	[StatusMessage] [varchar](50) NULL,
	[Currency] [varchar](50) NULL,
	[Amount] [decimal](18, 2) NULL,
	[BillingName] [varchar](100) NULL,
	[BillingAddress] [varchar](250) NULL,
	[BillingCity] [varchar](50) NULL,
	[BillingState] [varchar](50) NULL,
	[BillingCountry] [varchar](50) NULL,
	[BillingZip] [varchar](50) NULL,
	[BillingTel] [varchar](50) NULL,
	[BillingEmail] [varchar](100) NULL,
	[DeliveryName] [varchar](50) NULL,
	[DeliveryAddress] [varchar](50) NULL,
	[DeliveryCity] [varchar](50) NULL,
	[DeliveryState] [varchar](50) NULL,
	[DeliveryZip] [varchar](50) NULL,
	[DeliveryCountry] [varchar](50) NULL,
	[DeliveryTel] [varchar](50) NULL,
	[MerchantParam1] [varchar](500) NULL,
	[MerchantParam2] [varchar](500) NULL,
	[MerchantParam3] [varchar](500) NULL,
	[MerchantParam4] [varchar](500) NULL,
	[MerchantParam5] [varchar](500) NULL,
	[Vault] [varchar](10) NULL,
	[OfferType] [varchar](50) NULL,
	[OfferCode] [varchar](50) NULL,
	[DiscountValue] [varchar](50) NULL,
	[MerAmount] [decimal](18, 0) NULL,
	[ECIValue] [varchar](50) NULL,
	[Retry] [varchar](15) NULL,
	[ResponseCode] [varchar](10) NULL,
	[BillingNotes] [varchar](500) NULL,
	[TranDate] [datetime] NULL,
	[BinCountry] [varchar](50) NULL,
	[EncryptedText] [varchar](max) NULL,
	[CreatedBy] [varchar](50) NULL,
	[CreatedDate] [datetime] NULL,
 CONSTRAINT [PK_PaymentGatewayTransactions] PRIMARY KEY CLUSTERED 
(
	[TransactionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PaymentProfileTransactions]    Script Date: 6/22/2017 8:10:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PaymentProfileTransactions](
	[TransactionID] [varchar](20) NOT NULL,
	[ProfileID] [varchar](50) NULL,
	[SangamID] [varchar](20) NULL,
	[PaymentAmount] [decimal](18, 2) NULL,
	[PaymentDate] [datetime] NULL,
	[ValidityStartDate] [datetime] NULL,
	[ValidityExpiryDate] [datetime] NULL,
	[PaymentMode] [varchar](50) NULL,
	[PaymentFor] [varchar](50) NULL,
	[PaymentNotes] [varchar](2000) NULL,
	[CreatedBy] [varchar](50) NULL,
	[CreatedDate] [datetime] NULL,
 CONSTRAINT [PK_PaymentProfileTransactions] PRIMARY KEY CLUSTERED 
(
	[TransactionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PaymentSangamTransactions]    Script Date: 6/22/2017 8:10:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PaymentSangamTransactions](
	[ID] [varchar](20) NOT NULL,
	[TransactionID] [varchar](20) NULL,
	[SangamID] [varchar](20) NULL,
	[PaymentAmountToSangam] [decimal](18, 2) NULL,
	[PaymentDate] [datetime] NULL,
	[PaymentMode] [varchar](50) NULL,
	[PaymentConfirmationDetails] [varchar](100) NULL,
	[CreatedBy] [varchar](50) NULL,
	[CreatedDate] [datetime] NULL,
	[ModifiedBy] [varchar](50) NULL,
	[ModifiedDate] [datetime] NULL,
 CONSTRAINT [PK_PaymentSangamTransactions] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PortalLog]    Script Date: 6/22/2017 8:10:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PortalLog](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Date] [datetime] NOT NULL,
	[Thread] [varchar](255) NOT NULL,
	[Level] [varchar](50) NOT NULL,
	[Logger] [varchar](255) NOT NULL,
	[Message] [varchar](4000) NOT NULL,
	[Exception] [varchar](2000) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PortalSession]    Script Date: 6/22/2017 8:10:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PortalSession](
	[SessionID] [varchar](20) NOT NULL,
	[UserID] [varchar](50) NULL,
	[LoginTime] [datetime] NULL,
	[LogoutTime] [datetime] NULL,
	[LoggedInClientIP] [varchar](50) NULL,
 CONSTRAINT [PK_PortalSession] PRIMARY KEY CLUSTERED 
(
	[SessionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PortalUser]    Script Date: 6/22/2017 8:10:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PortalUser](
	[ID] [varchar](20) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[LoginID] [varchar](50) NOT NULL,
	[Password] [varchar](100) NOT NULL,
	[SangamID] [varchar](20) NOT NULL,
	[RoleID] [varchar](20) NOT NULL,
	[ThemeID] [varchar](20) NULL,
	[LocaleID] [varchar](20) NULL,
	[IsActivated] [varchar](1) NULL,
	[IsHighlighted] [numeric](18, 0) NULL,
	[HomePagePath] [varchar](150) NULL,
	[ShowHoroscope] [numeric](18, 0) NULL,
	[CreatedBy] [varchar](20) NULL,
	[CreatedDate] [datetime] NULL,
	[ModifiedBy] [varchar](20) NULL,
	[ModifiedDate] [datetime] NULL,
	[IsMarried] [numeric](18, 0) NULL,
	[PaymentDate] [datetime] NULL,
 CONSTRAINT [PK_PortalUser_1] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [IX_PortalUser] UNIQUE NONCLUSTERED 
(
	[LoginID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ProfileAmsam]    Script Date: 6/22/2017 8:10:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ProfileAmsam](
	[ProfileID] [varchar](50) NOT NULL,
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
	[CreatedBy] [varchar](50) NULL,
	[CreatedDate] [datetime] NULL,
	[ModifiedBy] [varchar](50) NULL,
	[ModifiedDate] [datetime] NULL,
 CONSTRAINT [PK_ProfileAmsam] PRIMARY KEY CLUSTERED 
(
	[ProfileID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ProfileBasicInfo]    Script Date: 6/22/2017 8:10:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ProfileBasicInfo](
	[ElanUserID] [varchar](20) NOT NULL,
	[SangamProfileID] [nvarchar](20) NULL,
	[ProfileID] [varchar](50) NOT NULL,
	[Name] [nvarchar](80) NOT NULL,
	[Age] [numeric](18, 0) NULL,
	[Gender] [varchar](6) NULL,
	[DateOfBirth] [datetime] NULL,
	[TamilDOB] [datetime] NULL,
	[TimeOfBirth] [varchar](50) NULL,
	[PlaceOfBirth] [nvarchar](100) NULL,
	[MaritalStatus] [nvarchar](50) NULL,
	[NoOfChildren] [numeric](18, 0) NULL,
	[ChildrenLivingStatus] [nvarchar](50) NULL,
	[Height] [varchar](50) NULL,
	[Weight] [numeric](18, 0) NULL,
	[BodyType] [nvarchar](50) NULL,
	[Complexion] [nvarchar](50) NULL,
	[PhysicalStatus] [nvarchar](80) NULL,
	[BloodGroup] [nvarchar](50) NULL,
	[MotherTongue] [nvarchar](50) NULL,
	[ProfileCreatedBy] [nvarchar](50) NULL,
	[Religion] [nvarchar](50) NULL,
	[Caste] [nvarchar](50) NULL,
	[SubCaste] [nvarchar](50) NULL,
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
	[PhotoPath] [varchar](150) NULL,
	[SangamID] [varchar](20) NOT NULL,
	[ModifiedBy] [varchar](20) NULL,
	[ModifiedDate] [datetime] NULL,
	[Paadham] [nvarchar](20) NULL,
 CONSTRAINT [PK_ProfileBasicInfo] PRIMARY KEY CLUSTERED 
(
	[ProfileID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ProfileCareer]    Script Date: 6/22/2017 8:10:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ProfileCareer](
	[ProfileID] [varchar](50) NOT NULL,
	[Education] [varchar](50) NULL,
	[EducationInDetail] [nvarchar](50) NULL,
	[EmployedIn] [nvarchar](50) NULL,
	[Occupation] [nvarchar](50) NULL,
	[OccupationInDetail] [nvarchar](1000) NULL,
	[Income] [decimal](18, 0) NULL,
	[CreatedBy] [varchar](20) NULL,
	[CreatedDate] [datetime] NULL,
	[ModifiedBy] [varchar](20) NULL,
	[ModifiedDate] [datetime] NULL,
 CONSTRAINT [PK_Profile_Career] PRIMARY KEY CLUSTERED 
(
	[ProfileID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ProfileContact]    Script Date: 6/22/2017 8:10:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ProfileContact](
	[ProfileID] [varchar](50) NOT NULL,
	[EMail] [varchar](150) NULL,
	[MobileNumber] [varchar](100) NULL,
	[LandLineNumber] [varchar](100) NULL,
	[Address] [nvarchar](150) NULL,
	[RelationShipWithMember] [nvarchar](50) NULL,
	[ConvinientTimeToCall] [varchar](150) NULL,
	[CreatedBy] [varchar](20) NULL,
	[CreatedDate] [datetime] NULL,
	[ModifiedBy] [varchar](20) NULL,
	[ModifiedDate] [datetime] NULL,
	[Name] [nvarchar](150) NULL,
 CONSTRAINT [PK_ProfileContact_1] PRIMARY KEY CLUSTERED 
(
	[ProfileID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ProfileFamily]    Script Date: 6/22/2017 8:10:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ProfileFamily](
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
	[CreateDate] [datetime] NULL,
	[CreatedBy] [varchar](20) NULL,
	[ModifiedDate] [datetime] NULL,
	[ModifiedBy] [varchar](20) NULL,
	[ParentsAlive] [nvarchar](100) NULL,
	[MothersSubSect] [nvarchar](200) NULL,
 CONSTRAINT [PK_ProfileFamily] PRIMARY KEY CLUSTERED 
(
	[ProfileID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ProfileHoroscope]    Script Date: 6/22/2017 8:10:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ProfileHoroscope](
	[ProfileID] [varchar](50) NOT NULL,
	[DasaBalance] [nvarchar](50) NULL,
	[Year] [numeric](18, 0) NULL,
	[Month] [numeric](18, 0) NULL,
	[Day] [numeric](18, 0) NULL,
	[Path] [nvarchar](150) NULL,
	[ModifiedBy] [varchar](50) NULL,
	[ModifiedDate] [datetime] NULL,
 CONSTRAINT [PK_ProfileHoroscope_1] PRIMARY KEY CLUSTERED 
(
	[ProfileID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ProfileInterested]    Script Date: 6/22/2017 8:10:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ProfileInterested](
	[ID] [varchar](20) NOT NULL,
	[ViewerID] [varchar](50) NULL,
	[InterestedInID] [varchar](50) NULL,
	[InterestedDate] [datetime] NULL,
 CONSTRAINT [PK_ProfileInterested] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ProfileLocation]    Script Date: 6/22/2017 8:10:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ProfileLocation](
	[ProfileID] [varchar](50) NOT NULL,
	[CountryLivingIn] [nvarchar](50) NULL,
	[CitizenShip] [nvarchar](50) NULL,
	[ResidentStatus] [nvarchar](50) NULL,
	[ResidingState] [nvarchar](50) NULL,
	[ResidingCity] [nvarchar](50) NULL,
	[CreatedBy] [varchar](20) NULL,
	[CreatedDate] [datetime] NULL,
	[ModifiedBy] [varchar](20) NULL,
	[ModifiedDate] [datetime] NULL,
 CONSTRAINT [PK_ProfileLocation_1] PRIMARY KEY CLUSTERED 
(
	[ProfileID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ProfilePhoto]    Script Date: 6/22/2017 8:10:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ProfilePhoto](
	[ID] [varchar](20) NOT NULL,
	[ProfileID] [varchar](50) NULL,
	[PhotoPath] [varchar](250) NULL,
	[IsProfilePic] [numeric](18, 0) NULL,
 CONSTRAINT [PK_ProfilePhoto] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ProfileRaasi]    Script Date: 6/22/2017 8:10:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ProfileRaasi](
	[ProfileID] [varchar](50) NOT NULL,
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
	[CreatedBy] [varchar](50) NULL,
	[CreatedDate] [datetime] NULL,
	[ModifiedBy] [varchar](50) NULL,
	[ModifiedDate] [datetime] NULL,
 CONSTRAINT [PK_ProfileRaasi] PRIMARY KEY CLUSTERED 
(
	[ProfileID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ProfileReference]    Script Date: 6/22/2017 8:10:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ProfileReference](
	[ProfileID] [varchar](50) NOT NULL,
	[NomineeName] [nvarchar](50) NULL,
	[ContactNo] [varchar](100) NULL,
	[CreatedBy] [varchar](20) NULL,
	[CreatedDate] [datetime] NULL,
	[ModifiedBy] [varchar](20) NULL,
	[ModifiedDate] [datetime] NULL,
 CONSTRAINT [PK_ProfileReference_1] PRIMARY KEY CLUSTERED 
(
	[ProfileID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ProfileViewed]    Script Date: 6/22/2017 8:10:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ProfileViewed](
	[ID] [varchar](20) NOT NULL,
	[ViewerID] [varchar](50) NOT NULL,
	[ViewedID] [varchar](50) NOT NULL,
	[ViewedDate] [datetime] NULL,
 CONSTRAINT [PK_ProfileViewed_1] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[RoleMaster]    Script Date: 6/22/2017 8:10:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[RoleMaster](
	[ID] [varchar](20) NOT NULL,
	[Name] [nvarchar](60) NULL,
	[Description] [nvarchar](150) NULL,
	[CreatedBy] [varchar](20) NULL,
	[CreatedDate] [datetime] NULL,
	[ModifiedBy] [varchar](20) NULL,
	[ModifiedDate] [datetime] NULL,
 CONSTRAINT [PK_RoleMaster] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[SangamDashboardChart]    Script Date: 6/22/2017 8:10:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[SangamDashboardChart](
	[ID] [varchar](20) NOT NULL,
	[Count] [numeric](18, 0) NULL,
	[Month] [varchar](50) NULL,
	[SangamID] [varchar](20) NULL,
 CONSTRAINT [PK_SangamDashboardChart] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[SangamMaster]    Script Date: 6/22/2017 8:10:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[SangamMaster](
	[ID] [varchar](20) NOT NULL,
	[Name] [nvarchar](200) NULL,
	[Address] [nvarchar](300) NULL,
	[ContactNumber] [varchar](50) NULL,
	[ProfileIDStartsWith] [nvarchar](20) NULL,
	[AboutSangam] [nvarchar](max) NULL,
	[IsActivated] [varchar](1) NOT NULL,
	[LogoPath] [varchar](150) NULL,
	[BannerPath] [varchar](150) NULL,
	[RunningNoStartsFrom] [numeric](18, 0) NULL,
	[LastProfileIDNo] [numeric](18, 0) NULL,
	[CreatedBy] [varchar](20) NULL,
	[CreatedDate] [datetime] NULL,
	[ModifiedBy] [varchar](20) NULL,
	[ModifiedDate] [datetime] NULL,
	[ContactName] [nvarchar](200) NULL,
	[ShowContactDetails] [varchar](1) NULL,
	[MugurthamSPOC] [varchar](200) NULL,
 CONSTRAINT [PK_SangamMaster] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[PaymentGatewayTransactions] ADD  CONSTRAINT [DF_PaymentGatewayTransactions_CreatedDate]  DEFAULT (getdate()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[PaymentProfileTransactions] ADD  CONSTRAINT [DF_PaymentProfileTransactions_CreatedDate]  DEFAULT (getdate()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[PaymentSangamTransactions] ADD  CONSTRAINT [DF_PaymentSangamTransactions_CreatedDate]  DEFAULT (getdate()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[PaymentSangamTransactions] ADD  CONSTRAINT [DF_PaymentSangamTransactions_ModifiedDate]  DEFAULT (getdate()) FOR [ModifiedDate]
GO
ALTER TABLE [dbo].[PortalSession] ADD  CONSTRAINT [DF_PortalSession_LoginTime]  DEFAULT (getdate()) FOR [LoginTime]
GO
ALTER TABLE [dbo].[PortalUser] ADD  CONSTRAINT [DF_PortalUser_ThemeID]  DEFAULT ('Bootstrap') FOR [ThemeID]
GO
ALTER TABLE [dbo].[PortalUser] ADD  CONSTRAINT [DF_PortalUser_LocaleID]  DEFAULT ((409)) FOR [LocaleID]
GO
ALTER TABLE [dbo].[PortalUser] ADD  CONSTRAINT [DF_PortalUser_IsHighlighted]  DEFAULT ((0)) FOR [IsHighlighted]
GO
ALTER TABLE [dbo].[PortalUser] ADD  CONSTRAINT [DF_PortalUser_ShowHoroscope]  DEFAULT ((1)) FOR [ShowHoroscope]
GO
ALTER TABLE [dbo].[ProfileAmsam] ADD  CONSTRAINT [DF_ProfileAmsam_CreatedDate]  DEFAULT (getdate()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[ProfileHoroscope] ADD  CONSTRAINT [DF_ProfileHoroscope_ModifiedDate]  DEFAULT (getdate()) FOR [ModifiedDate]
GO
ALTER TABLE [dbo].[ProfileInterested] ADD  CONSTRAINT [DF_ProfileInterested_InterestedDate]  DEFAULT (getdate()) FOR [InterestedDate]
GO
ALTER TABLE [dbo].[ProfileRaasi] ADD  CONSTRAINT [DF_ProfileRaasi_CreatedDate]  DEFAULT (getdate()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[ProfileViewed] ADD  DEFAULT (getdate()) FOR [ViewedDate]
GO
ALTER TABLE [dbo].[SangamMaster] ADD  CONSTRAINT [DF_SangamMaster_RunningNoStartsFrom]  DEFAULT ((1000)) FOR [RunningNoStartsFrom]
GO
ALTER TABLE [dbo].[SangamMaster] ADD  CONSTRAINT [DF_SangamMaster_LastProfileIDNo]  DEFAULT ((1000)) FOR [LastProfileIDNo]
GO
ALTER TABLE [dbo].[SangamMaster] ADD  DEFAULT ('0') FOR [ShowContactDetails]
GO
ALTER TABLE [dbo].[SangamMaster] ADD  CONSTRAINT [CONSTRAINT_SPOC]  DEFAULT ('+91 9659375050') FOR [MugurthamSPOC]
GO
ALTER TABLE [dbo].[dtpProfileCollection]  WITH CHECK ADD  CONSTRAINT [FK_dtpProfileCollection_dtpProfileCollection] FOREIGN KEY([ID])
REFERENCES [dbo].[dtpProfileCollection] ([ID])
GO
ALTER TABLE [dbo].[dtpProfileCollection] CHECK CONSTRAINT [FK_dtpProfileCollection_dtpProfileCollection]
GO
ALTER TABLE [dbo].[PaymentGatewayTransactions]  WITH CHECK ADD  CONSTRAINT [FK_PaymentGatewayTransactions_PortalUser] FOREIGN KEY([CreatedBy])
REFERENCES [dbo].[PortalUser] ([LoginID])
GO
ALTER TABLE [dbo].[PaymentGatewayTransactions] CHECK CONSTRAINT [FK_PaymentGatewayTransactions_PortalUser]
GO
ALTER TABLE [dbo].[PaymentProfileTransactions]  WITH CHECK ADD  CONSTRAINT [FK_PaymentProfileTransactions_PaymentGatewayTransactions] FOREIGN KEY([TransactionID])
REFERENCES [dbo].[PaymentGatewayTransactions] ([TransactionID])
GO
ALTER TABLE [dbo].[PaymentProfileTransactions] CHECK CONSTRAINT [FK_PaymentProfileTransactions_PaymentGatewayTransactions]
GO
ALTER TABLE [dbo].[PaymentProfileTransactions]  WITH CHECK ADD  CONSTRAINT [FK_PaymentProfileTransactions_ProfileBasicInfo] FOREIGN KEY([ProfileID])
REFERENCES [dbo].[ProfileBasicInfo] ([ProfileID])
GO
ALTER TABLE [dbo].[PaymentProfileTransactions] CHECK CONSTRAINT [FK_PaymentProfileTransactions_ProfileBasicInfo]
GO
ALTER TABLE [dbo].[PaymentProfileTransactions]  WITH CHECK ADD  CONSTRAINT [FK_PaymentProfileTransactions_SangamMaster] FOREIGN KEY([SangamID])
REFERENCES [dbo].[SangamMaster] ([ID])
GO
ALTER TABLE [dbo].[PaymentProfileTransactions] CHECK CONSTRAINT [FK_PaymentProfileTransactions_SangamMaster]
GO
ALTER TABLE [dbo].[PaymentSangamTransactions]  WITH CHECK ADD  CONSTRAINT [FK_PaymentSangamTransactions_PaymentGatewayTransactions] FOREIGN KEY([TransactionID])
REFERENCES [dbo].[PaymentGatewayTransactions] ([TransactionID])
GO
ALTER TABLE [dbo].[PaymentSangamTransactions] CHECK CONSTRAINT [FK_PaymentSangamTransactions_PaymentGatewayTransactions]
GO
ALTER TABLE [dbo].[PaymentSangamTransactions]  WITH CHECK ADD  CONSTRAINT [FK_PaymentSangamTransactions_PortalUser] FOREIGN KEY([CreatedBy])
REFERENCES [dbo].[PortalUser] ([LoginID])
GO
ALTER TABLE [dbo].[PaymentSangamTransactions] CHECK CONSTRAINT [FK_PaymentSangamTransactions_PortalUser]
GO
ALTER TABLE [dbo].[PaymentSangamTransactions]  WITH CHECK ADD  CONSTRAINT [FK_PaymentSangamTransactions_PortalUser1] FOREIGN KEY([ModifiedBy])
REFERENCES [dbo].[PortalUser] ([LoginID])
GO
ALTER TABLE [dbo].[PaymentSangamTransactions] CHECK CONSTRAINT [FK_PaymentSangamTransactions_PortalUser1]
GO
ALTER TABLE [dbo].[PortalSession]  WITH CHECK ADD  CONSTRAINT [FK_PortalSession_PortalUser] FOREIGN KEY([UserID])
REFERENCES [dbo].[PortalUser] ([LoginID])
GO
ALTER TABLE [dbo].[PortalSession] CHECK CONSTRAINT [FK_PortalSession_PortalUser]
GO
ALTER TABLE [dbo].[PortalUser]  WITH CHECK ADD  CONSTRAINT [FK_PortalUser_RoleMaster] FOREIGN KEY([RoleID])
REFERENCES [dbo].[RoleMaster] ([ID])
GO
ALTER TABLE [dbo].[PortalUser] CHECK CONSTRAINT [FK_PortalUser_RoleMaster]
GO
ALTER TABLE [dbo].[PortalUser]  WITH CHECK ADD  CONSTRAINT [FK_PortalUser_SangamMaster] FOREIGN KEY([SangamID])
REFERENCES [dbo].[SangamMaster] ([ID])
GO
ALTER TABLE [dbo].[PortalUser] CHECK CONSTRAINT [FK_PortalUser_SangamMaster]
GO
ALTER TABLE [dbo].[ProfileAmsam]  WITH CHECK ADD  CONSTRAINT [FK_ProfileAmsam_ProfileBasicInfo] FOREIGN KEY([ProfileID])
REFERENCES [dbo].[ProfileBasicInfo] ([ProfileID])
GO
ALTER TABLE [dbo].[ProfileAmsam] CHECK CONSTRAINT [FK_ProfileAmsam_ProfileBasicInfo]
GO
ALTER TABLE [dbo].[ProfileBasicInfo]  WITH CHECK ADD  CONSTRAINT [FK_ProfileBasicInfo_PortalUser] FOREIGN KEY([ProfileID])
REFERENCES [dbo].[PortalUser] ([LoginID])
GO
ALTER TABLE [dbo].[ProfileBasicInfo] CHECK CONSTRAINT [FK_ProfileBasicInfo_PortalUser]
GO
ALTER TABLE [dbo].[ProfileCareer]  WITH CHECK ADD  CONSTRAINT [FK_ProfileCareer_ProfileBasicInfo] FOREIGN KEY([ProfileID])
REFERENCES [dbo].[ProfileBasicInfo] ([ProfileID])
GO
ALTER TABLE [dbo].[ProfileCareer] CHECK CONSTRAINT [FK_ProfileCareer_ProfileBasicInfo]
GO
ALTER TABLE [dbo].[ProfileContact]  WITH CHECK ADD  CONSTRAINT [FK_ProfileContact_ProfileBasicInfo] FOREIGN KEY([ProfileID])
REFERENCES [dbo].[ProfileBasicInfo] ([ProfileID])
GO
ALTER TABLE [dbo].[ProfileContact] CHECK CONSTRAINT [FK_ProfileContact_ProfileBasicInfo]
GO
ALTER TABLE [dbo].[ProfileFamily]  WITH CHECK ADD  CONSTRAINT [FK_ProfileFamily_ProfileBasicInfo] FOREIGN KEY([ProfileID])
REFERENCES [dbo].[ProfileBasicInfo] ([ProfileID])
GO
ALTER TABLE [dbo].[ProfileFamily] CHECK CONSTRAINT [FK_ProfileFamily_ProfileBasicInfo]
GO
ALTER TABLE [dbo].[ProfileHoroscope]  WITH CHECK ADD  CONSTRAINT [FK_ProfileHoroscope_ProfileBasicInfo] FOREIGN KEY([ProfileID])
REFERENCES [dbo].[ProfileBasicInfo] ([ProfileID])
GO
ALTER TABLE [dbo].[ProfileHoroscope] CHECK CONSTRAINT [FK_ProfileHoroscope_ProfileBasicInfo]
GO
ALTER TABLE [dbo].[ProfileInterested]  WITH CHECK ADD  CONSTRAINT [FK_ProfileInterested_ProfileBasicInfo] FOREIGN KEY([ViewerID])
REFERENCES [dbo].[ProfileBasicInfo] ([ProfileID])
GO
ALTER TABLE [dbo].[ProfileInterested] CHECK CONSTRAINT [FK_ProfileInterested_ProfileBasicInfo]
GO
ALTER TABLE [dbo].[ProfileLocation]  WITH CHECK ADD  CONSTRAINT [FK_ProfileLocation_ProfileBasicInfo] FOREIGN KEY([ProfileID])
REFERENCES [dbo].[ProfileBasicInfo] ([ProfileID])
GO
ALTER TABLE [dbo].[ProfileLocation] CHECK CONSTRAINT [FK_ProfileLocation_ProfileBasicInfo]
GO
ALTER TABLE [dbo].[ProfilePhoto]  WITH CHECK ADD  CONSTRAINT [FK_ProfilePhoto_ProfileBasicInfo] FOREIGN KEY([ProfileID])
REFERENCES [dbo].[ProfileBasicInfo] ([ProfileID])
GO
ALTER TABLE [dbo].[ProfilePhoto] CHECK CONSTRAINT [FK_ProfilePhoto_ProfileBasicInfo]
GO
ALTER TABLE [dbo].[ProfileRaasi]  WITH CHECK ADD  CONSTRAINT [FK_ProfileRaasi_ProfileBasicInfo] FOREIGN KEY([ProfileID])
REFERENCES [dbo].[ProfileBasicInfo] ([ProfileID])
GO
ALTER TABLE [dbo].[ProfileRaasi] CHECK CONSTRAINT [FK_ProfileRaasi_ProfileBasicInfo]
GO
ALTER TABLE [dbo].[ProfileReference]  WITH CHECK ADD  CONSTRAINT [FK_ProfileReference_ProfileBasicInfo] FOREIGN KEY([ProfileID])
REFERENCES [dbo].[ProfileBasicInfo] ([ProfileID])
GO
ALTER TABLE [dbo].[ProfileReference] CHECK CONSTRAINT [FK_ProfileReference_ProfileBasicInfo]
GO
ALTER TABLE [dbo].[ProfileViewed]  WITH CHECK ADD  CONSTRAINT [FK_ProfileViewed_ProfileBasicInfo] FOREIGN KEY([ViewerID])
REFERENCES [dbo].[ProfileBasicInfo] ([ProfileID])
GO
ALTER TABLE [dbo].[ProfileViewed] CHECK CONSTRAINT [FK_ProfileViewed_ProfileBasicInfo]
GO
ALTER TABLE [dbo].[SangamDashboardChart]  WITH CHECK ADD  CONSTRAINT [FK_SangamDashboardChart_SangamDashboardChart] FOREIGN KEY([SangamID])
REFERENCES [dbo].[SangamMaster] ([ID])
GO
ALTER TABLE [dbo].[SangamDashboardChart] CHECK CONSTRAINT [FK_SangamDashboardChart_SangamDashboardChart]
GO


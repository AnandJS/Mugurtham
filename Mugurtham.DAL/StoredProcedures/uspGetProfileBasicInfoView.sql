USE [Mugurtham]
GO

/****** Object:  StoredProcedure [dbo].[uspGetProfileBasicInfoView]    Script Date: 4/12/2016 10:41:48 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



-- =====================================================================================================  
-- Author:         <ANAND JAYASEELAN> 
-- Create date:     <APR 11 2016>
-- Description:    <This Procedure will get all the profiles for BasicInfo view display >
-- ======================================================================================================  
CREATE PROCEDURE [dbo].[uspGetProfileBasicInfoView] @GENDER varchar(30)
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
        Name varchar(150),
        Age numeric(3, 0),
        Gender varchar(15),
        Location varchar(150),
        Education varchar(250),
        Occupation varchar(250),
        AboutMe nvarchar(max),
        SangamID varchar(50),
        SangamName varchar(450),
		Subcaste varchar(150),
		Star varchar(150)
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
  profilebasicinfo.Star

  
FROM profilebasicinfo profilebasicinfo WITH (NOLOCK)

INNER JOIN ProfileCareer ProfileCareer WITH (NOLOCK)
  ON ProfileCareer.ProfileID = profilebasicinfo.ProfileID
INNER JOIN ProfileLocation ProfileLocation WITH (NOLOCK)
  ON ProfileLocation.ProfileID = profilebasicinfo.ProfileID

INNER JOIN portaluser PortalUser WITH (NOLOCK)
  ON PROFILEBASICINFO.gender in ( ' + @Gender + ')
  AND portaluser.roleid = ''F62DDFBE55448E3A3''-- User Profiles only
  AND portaluser.isactivated = 1 -- Activated Profile Only
  AND portaluser.loginid = profilebasicinfo.profileid
INNER JOIN sangammaster SangamMaster WITH (NOLOCK)
  ON sangammaster.isactivated = 1 -- Activated Sangam Only
  AND sangammaster.id = portaluser.sangamid'

      EXECUTE Sp_executesql @strSQLQuery

      SELECT
        SangamProfileID,
        MugurthamProfileID,
        Name,
        Age,
        Gender,
        Location,
        Education,
        Occupation,
        AboutMe,
        SangamID,
        SangamName,
		Subcaste,
		Star
      FROM #tempTable

      SELECT
        ProfilePhoto.ID,
        ProfilePhoto.ProfileID,
        ProfilePhoto.PhotoPath,
        ProfilePhoto.IsProfilePic
      FROM ProfilePhoto ProfilePhoto WITH (NOLOCK)
      INNER JOIN #tempTable SearchDataTable WITH (NOLOCK)
        ON ProfilePhoto.ProfileID = SearchDataTable.MugurthamProfileID
		
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


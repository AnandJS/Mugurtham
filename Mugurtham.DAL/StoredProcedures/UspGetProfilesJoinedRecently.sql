-- =====================================================================================================  
-- Author:         <ANAND JAYASEELAN> 
-- Create date:     <JUN 17 2016>
-- Description:    <This Procedure will get 20 profiles joined recently from each and every Association>
-- ======================================================================================================  
ALTER PROCEDURE [dbo].[UspGetProfilesJoinedRecently] @GENDER VARCHAR(30) 
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
               star               VARCHAR(150) 
            ); 

          SET @strSQLQuery = 
          ' INSERT INTO #tempTable            SELECT     profilebasicinfo.sangamprofileid,     profilebasicinfo.profileid,     profilebasicinfo.NAME,     profilebasicinfo.age,     profilebasicinfo.gender,     profilelocation.residingcity AS location,     profilecareer.education,     profilecareer.occupation,     profilebasicinfo.aboutme,     sangammaster.id   AS sangamid,     sangammaster.NAME AS sangamname,     profilebasicinfo.subcaste,     profilebasicinfo.star  FROM       profilebasicinfo profilebasicinfo WITH (nolock)  INNER JOIN #temptableforrecentlyjoined AS recentlyjoinedprofiles WITH (nolock)  ON         recentlyjoinedprofiles.profileid = profilebasicinfo.profileid  INNER JOIN profilecareer ProfileCareer WITH (nolock)  ON         profilecareer.profileid = profilebasicinfo.profileid  INNER JOIN profilelocation ProfileLocation WITH (nolock)  ON         profilelocation.profileid = profilebasicinfo.profileid  INNER JOIN portaluser PortalUser WITH (nolock)  ON         profilebasicinfo.gender IN ( ' 
          + @Gender 
          + 
          ')  AND        portaluser.roleid = ''f62ddfbe55448e3a3''-- User Profiles only    AND portaluser.isactivated = 1 -- Activated Profile Only   AND portaluser.loginid = profilebasicinfo.profileid  INNER JOIN sangammaster SangamMaster WITH (NOLOCK)    ON sangammaster.isactivated = 1 -- Activated Sangam Only    AND sangammaster.id = portaluser.sangamid' 

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
          FROM   #temptable 

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

go 
-- =====================================================================================================  
-- Author:         <ANAND JAYASEELAN> 
-- Create date:	   <APR 8 2016>
-- Description:    <This Procedure will get the badge count only for User Profiles and not for rest >
-- ======================================================================================================  
Alter PROCEDURE [dbo].[Uspgetprofilebadgecount] @GENDER       VARCHAR(30), 
                                                 @INTERESTEDID VARCHAR(50), 
                                                 @SANGAMID     VARCHAR(20) 
AS 
  BEGIN 
      DECLARE @HIGHLIGHTEDPROFILESCOUNT    INT, 
              @INTERESTEDINMEPROFILESCOUNT INT, 
              @INTERESTEDPROFILESCOUNT     INT, 
              @PROFILESJOINEDTHISWEEKCOUNT INT, 
              @PROFILESVIEWEDMECOUNT       INT 

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
          SELECT @HIGHLIGHTEDPROFILESCOUNT    AS 'HighlightedProfilesCount', 
                 @INTERESTEDINMEPROFILESCOUNT AS 'InterestedInMeProfilesCount', 
                 @INTERESTEDPROFILESCOUNT     AS 'InterestedProfilesCount', 
                 @PROFILESJOINEDTHISWEEKCOUNT AS 'ProfilesJoinedThisWeekCount', 
                 @PROFILESVIEWEDMECOUNT       AS 'ProfilesViewedMeCount' 

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
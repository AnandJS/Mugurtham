USE [Mugurtham]
GO

/****** Object:  StoredProcedure [dbo].[uspGetProfileBadgeCount]    Script Date: 4/12/2016 10:41:41 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


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
          Count(PROFILEBASICINFO.profileid) 
                                           FROM 
          PROFILEBASICINFO ProfileBasicInfo WITH ( 
          nolock) 
          INNER JOIN PORTALUSER PortalUser WITH ( 
                     nolock) 
                  ON PORTALUSER.ishighlighted = 1 
                     AND PROFILEBASICINFO.gender = 
                         @GENDER 
                     AND PORTALUSER.roleid = 
                         'F62DDFBE55448E3A3' 
                     -- User Profiles only    
                     AND PORTALUSER.isactivated = 
                         1 
                     -- Activated Profile Only                                
                     AND PORTALUSER.loginid = 
          PROFILEBASICINFO.profileid 
          INNER JOIN SANGAMMASTER SangamMaster WITH (nolock) 
          ON SANGAMMASTER.isactivated = 1 
          -- Activated Sangam Only                                
          AND SANGAMMASTER.id = PORTALUSER.sangamid) 
      /*=============================uspGetHighlightedProfiles  Ends===================================================*/
          /*=============================uspGetInterestedInMeProfiles  Starts===================================================*/
          SET @INTERESTEDINMEPROFILESCOUNT = (SELECT Count( 
                                             PROFILEBASICINFO.profileid) 
                                              FROM 
          PROFILEBASICINFO ProfileBasicInfo WITH (nolock) 
          INNER JOIN PROFILEINTERESTED ProfileInterested WITH (nolock) 
                  ON PROFILEINTERESTED.interestedinid = @INTERESTEDID 
                     AND PROFILEINTERESTED.viewerid = PROFILEBASICINFO.profileid 
          INNER JOIN PORTALUSER PortalUser WITH (nolock) 
                  ON PROFILEBASICINFO.gender = @GENDER 
                     AND PORTALUSER.roleid = 'F62DDFBE55448E3A3' 
                     -- User Profiles only                                
                     AND PORTALUSER.isactivated = 1 
                     -- Activated Profile Only                                
                     AND PORTALUSER.loginid = PROFILEBASICINFO.profileid 
          INNER JOIN SANGAMMASTER SangamMaster WITH (nolock) 
                  ON SANGAMMASTER.isactivated = 1 
                     -- Activated Sangam Only                                
                     AND SANGAMMASTER.id = PORTALUSER.sangamid) 
      /*=============================uspGetInterestedInMeProfiles  Ends===================================================*/
          /*=============================uspGetInterestedProfiles  Starts===================================================*/
          SET @INTERESTEDPROFILESCOUNT = (SELECT Count( 
                                         PROFILEBASICINFO.profileid) 
                                          FROM 
          PROFILEBASICINFO ProfileBasicInfo WITH ( 
          nolock) 
          INNER JOIN PROFILEINTERESTED 
                     ProfileInterested WITH (nolock 
                     ) 
                  ON PROFILEINTERESTED.viewerid = 
                     @INTERESTEDID 
                     AND 
          PROFILEINTERESTED.interestedinid = 
          PROFILEBASICINFO.profileid 
          INNER JOIN PORTALUSER PortalUser WITH ( 
                     nolock) 
                  ON PROFILEBASICINFO.gender = 
                     @GENDER 
                     AND PORTALUSER.roleid = 
                         'F62DDFBE55448E3A3' 
                     -- User Profiles only    
                     AND PORTALUSER.isactivated = 1 
                     -- Activated Profile Only    
                     AND PORTALUSER.loginid = 
                         PROFILEBASICINFO.profileid 
          INNER JOIN SANGAMMASTER SangamMaster WITH 
                     (nolock) 
                  ON SANGAMMASTER.isactivated = 1 
                     -- Activated Sangam Only    
                     AND SANGAMMASTER.id = 
                         PORTALUSER.sangamid) 
      /*=============================uspGetInterestedProfiles  Ends===================================================*/
          /*=============================[uspGetProfilesJoinedThisWeek]  Starts===================================================*/ 
          SET @PROFILESJOINEDTHISWEEKCOUNT = (SELECT Count( 
                                             PROFILEBASICINFO.profileid) 
                                              FROM 
          PROFILEBASICINFO ProfileBasicInfo WITH (nolock) 
          INNER JOIN PORTALUSER PortalUser WITH (nolock) 
                  ON PROFILEBASICINFO.createddate >= Getdate() - 7 
                     AND PROFILEBASICINFO.gender = @GENDER 
                     AND PORTALUSER.roleid = 'F62DDFBE55448E3A3' 
                     -- User Profiles only    
                     AND PORTALUSER.isactivated = 1 -- Activated Profile Only    
                     AND PORTALUSER.loginid = PROFILEBASICINFO.profileid 
          INNER JOIN SANGAMMASTER SangamMaster WITH (nolock) 
                  ON SANGAMMASTER.isactivated = 1 -- Activated Sangam Only    
                     AND SANGAMMASTER.id = PORTALUSER.sangamid) 
      /*=============================[uspGetProfilesJoinedThisWeek]  Ends===================================================*/ 
          /*=============================[uspGetViewedProfiles] STARTS===================================================*/ 
          SET @PROFILESVIEWEDMECOUNT = (SELECT Count(PROFILEBASICINFO.profileid) 
                                        FROM 
          PROFILEBASICINFO ProfileBasicInfo WITH 
          ( 
          nolock) 
          INNER JOIN PROFILEVIEWED ProfileViewed 
                     WITH 
                     (nolock) 
                  ON PROFILEVIEWED.viewedid = 
                     @INTERESTEDID 
                     AND PROFILEVIEWED.viewerid = 
      PROFILEBASICINFO.profileid 
      INNER JOIN PORTALUSER PortalUser WITH ( 
      nolock) 
      ON PROFILEBASICINFO.gender = 
      @GENDER 
      AND PORTALUSER.roleid = 
      'F62DDFBE55448E3A3' 
      -- User Profiles only    
      AND PORTALUSER.isactivated = 1 
      -- Activated Profile Only    
      AND PORTALUSER.loginid = 
      PROFILEBASICINFO.profileid 
      INNER JOIN SANGAMMASTER SangamMaster WITH ( 
      nolock) 
      ON SANGAMMASTER.isactivated = 1 
      -- Activated Sangam Only    
      AND SANGAMMASTER.id = 
      PORTALUSER.sangamid) 

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
GO


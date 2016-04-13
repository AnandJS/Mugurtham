USE [Mugurtham]
GO

/****** Object:  StoredProcedure [dbo].[uspGetViewedProfiles]    Script Date: 4/12/2016 10:42:04 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- ==========================================================================
-- Author:      <ANAND JAYASEELAN>
-- Create date: <JUN 3 2015>
-- Description: <GETS THE VIEW NOTIFICATION OF THE LOGGED IN PROFILE>
-- ============================================================================
CREATE PROCEDURE [dbo].[uspGetViewedProfiles] @Gender   VARCHAR(30),
                                              @InterestedID VARCHAR(50),
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
                 profilebasicinfo.sangamprofileid,
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
		  Inner join ProfileViewed ProfileViewed WITH (nolock) ON 
		  ProfileViewed.ViewedID = ''' + @InterestedID + '''
		  AND ProfileViewed.ViewerID = profilebasicinfo.ProfileID
                 INNER JOIN portaluser PortalUser WITH (nolock)'

          IF( @Gender = 'admin' )
            SELECT @Gender = ( '''male''' + ', ' + '''female''' )

          IF( @Gender = 'male' )
            SELECT @Gender = ( '''male''' )

          IF( @Gender = 'female' )
            SELECT @Gender = ( '''female''' )

          SET @strSQLQuery = @strSQLQuery
                             + 'ON ProfileBasicInfo.Gender in ( '
                             + @Gender
                             +
          ')
						 AND portaluser.roleid = ''F62DDFBE55448E3A3''
                            -- User Profiles only
                            AND portaluser.isactivated = 1
                            -- Activated Profile Only
                            AND portaluser.loginid = profilebasicinfo.profileid
                 INNER JOIN sangammaster SangamMaster WITH (nolock)
				  ON sangammaster.id = '
                             + '''' + @SangamID + ''''
                             +
				 ' AND sangammaster.isactivated = 1
                            -- Activated Sangam Only
                            AND sangammaster.id = portaluser.sangamid
							Union All
							SELECT profilebasicinfo.elanuserid,
                 profilebasicinfo.profileid,
                 profilebasicinfo.sangamprofileid,
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
		  Inner join ProfileViewed ProfileViewed WITH (nolock) ON 
		  ProfileViewed.ViewedID = ''' + @InterestedID + '''
		  AND ProfileViewed.ViewerID = profilebasicinfo.ProfileID
                 INNER JOIN portaluser PortalUser WITH (nolock)'

          IF( @Gender = 'admin' )
            SELECT @Gender = ( '''male''' + ', ' + '''female''' )

          IF( @Gender = 'male' )
            SELECT @Gender = ( '''male''' )

          IF( @Gender = 'female' )
            SELECT @Gender = ( '''female''' )

          SET @strSQLQuery = @strSQLQuery
                             + 'ON ProfileBasicInfo.Gender in ( '
                             + @Gender
                             +
          ')
						 AND portaluser.roleid = ''F62DDFBE55448E3A3''
                            -- User Profiles only
                            AND portaluser.isactivated = 1
                            -- Activated Profile Only
                            AND portaluser.loginid = profilebasicinfo.profileid
                 INNER JOIN sangammaster SangamMaster WITH (nolock)
				  ON sangammaster.id <> '
                             + '''' + @SangamID + ''''
                             +
				 ' AND sangammaster.isactivated = 1                         
                            -- Activated Sangam Only
                            AND sangammaster.id = portaluser.sangamid
							order by sangam'						
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


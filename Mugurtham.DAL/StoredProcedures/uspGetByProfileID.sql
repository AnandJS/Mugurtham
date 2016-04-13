USE [Mugurtham]
GO

/****** Object:  StoredProcedure [dbo].[uspGetByProfileID]    Script Date: 4/12/2016 10:40:20 PM ******/
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
       profilebasicinfo.modifieddate
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



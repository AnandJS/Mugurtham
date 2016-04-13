USE [Mugurtham]
GO

/****** Object:  StoredProcedure [dbo].[uspGetYearlySalesReport]    Script Date: 4/12/2016 10:42:16 PM ******/
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


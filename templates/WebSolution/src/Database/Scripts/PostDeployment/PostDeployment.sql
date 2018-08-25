/*
Post-Deployment Script Template                            
--------------------------------------------------------------------------------------
 This file contains SQL statements that will be appended to the build script.        
 Use SQLCMD syntax to include a file in the post-deployment script.            
 Example:      :r .\myfile.sql                                
 Use SQLCMD syntax to reference a variable in the post-deployment script.        
 Example:      :setvar TableName MyTable                            
               SELECT * FROM [$(TableName)]                    
--------------------------------------------------------------------------------------
*/

USE [master];
GO

alter authorization on database::[$(DatabaseName)] to [sa]
go
alter database [$(DatabaseName)] set recovery simple 
go
alter database [$(DatabaseName)] set auto_shrink off
go
alter database [$(DatabaseName)] set auto_create_statistics on
go
alter database [$(DatabaseName)] set auto_update_statistics on
go


-- Never change the script execution order below

INSERT [dbo].[RoleMaster] ([ID], [Name], [Description], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (N'5DD71987C324A1E86', N'User Public', N'The user who is not registered with any of the sangams in Mugurtham portal and visits for profiles', NULL, CAST(0x0000A46F00C5D1AE AS DateTime), NULL, CAST(0x0000A46F00C5D1AE AS DateTime))
GO
INSERT [dbo].[RoleMaster] ([ID], [Name], [Description], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (N'6F12E0055B6450BB3', N'Sangam Admin', N'The administrator of the respective sangam', NULL, CAST(0x0000A46F00C57A3A AS DateTime), NULL, CAST(0x0000A46F00C57A3A AS DateTime))
GO
INSERT [dbo].[RoleMaster] ([ID], [Name], [Description], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (N'F62DDFBE55448E3A3', N'User Profile', N'The user who is registered as profile in this portal with their respective sangam', NULL, CAST(0x0000A46F00C5A743 AS DateTime), NULL, CAST(0x0000A46F00C5A743 AS DateTime))
GO
INSERT [dbo].[RoleMaster] ([ID], [Name], [Description], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (N'FE1C8DE449F4AA8A0', N'Mugurtham Admin', N'The administrator of the Mugurtham Portal', NULL, CAST(0x0000A48D00AE4AF2 AS DateTime), NULL, CAST(0x0000A48D00AE4AF2 AS DateTime))
GO

INSERT [dbo].[SangamMaster] ([ID], [Name], [Address], [ContactNumber], [ProfileIDStartsWith], [AboutSangam], [IsActivated], [LogoPath], [BannerPath], [RunningNoStartsFrom], [LastProfileIDNo], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (N'3040D12EF264E2FA0', N'Public Sangam', NULL, N'5465', N'PUB', N'Public Sangam established in 1940', N'1', NULL, NULL, NULL, CAST(1025 AS Numeric(18, 0)), NULL, CAST(0x0000A47C0186D767 AS DateTime), NULL, CAST(0x0000A47C0186D767 AS DateTime))
GO
INSERT [dbo].[SangamMaster] ([ID], [Name], [Address], [ContactNumber], [ProfileIDStartsWith], [AboutSangam], [IsActivated], [LogoPath], [BannerPath], [RunningNoStartsFrom], [LastProfileIDNo], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (N'C136B11D9A64D6D94', N'Mugurtham - Associations Integrated', NULL, N'46456', N'MUG', N'Mugurtham Sangam is established in 2013 for providing platform on Matrimony across all sangmas', N'1', NULL, NULL, NULL, CAST(1025 AS Numeric(18, 0)), NULL, CAST(0x0000A4A600C65155 AS DateTime), NULL, CAST(0x0000A4A600C65155 AS DateTime))
GO

INSERT [dbo].[PortalUser] ([ID], [Name], [LoginID], [Password], [SangamID], [RoleID], [ThemeID], [LocaleID], [IsActivated], [IsHighlighted], [HomePagePath], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (N'2F707758489494990', N'Mugurtham Admin', N'administrator', N'/6UN2Oco6V2sEKuooAIuzrrOUrk=', N'C136B11D9A64D6D94', N'FE1C8DE449F4AA8A0', N'Bootstrap', N'0409', 1, CAST(0 AS Numeric(18, 0)), N'Matrimony#/MugurthamAdminDashboard', NULL, CAST(0x0000A46F00C885EF AS DateTime), NULL, CAST(0x0000A46F00C885EF AS DateTime))
GO

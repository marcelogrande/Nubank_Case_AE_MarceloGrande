CREATE TABLE [dbo].[raw_weekday](
	[weekday_id] [varchar](128) NOT NULL,
	[action_weekday] [varchar](20) NOT NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
ALTER TABLE [dbo].[raw_weekday] ADD  CONSTRAINT [PK_raw_weekday] PRIMARY KEY CLUSTERED 
(
	[weekday_id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO

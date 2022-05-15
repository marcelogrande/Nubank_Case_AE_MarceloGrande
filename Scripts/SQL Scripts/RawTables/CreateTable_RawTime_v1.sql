CREATE TABLE [dbo].[raw_time](
	[time_id] [varchar](256) NOT NULL,
	[action_timestamp] [varchar](128) NULL,
	[week_id] [varchar](128) NULL,
	[month_id] [varchar](128) NULL,
	[year_id] [varchar](128) NULL,
	[weekday_id] [varchar](128) NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
ALTER TABLE [dbo].[raw_time] ADD  CONSTRAINT [PK_raw_time] PRIMARY KEY CLUSTERED 
(
	[time_id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO

CREATE TABLE [dbo].[raw_city](
	[city] [varchar](128) NULL,
	[state_id] [varchar](128) NULL,
	[city_id] [varchar](128) NOT NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
ALTER TABLE [dbo].[raw_city] ADD  CONSTRAINT [PK_raw_city] PRIMARY KEY CLUSTERED 
(
	[city_id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO

CREATE TABLE [dbo].[raw_state](
	[state] [varchar](128) NOT NULL,
	[country_id] [varchar](128) NOT NULL,
	[state_id] [varchar](128) NOT NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
ALTER TABLE [dbo].[raw_state] ADD  CONSTRAINT [PK_raw_state] PRIMARY KEY CLUSTERED 
(
	[state_id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO

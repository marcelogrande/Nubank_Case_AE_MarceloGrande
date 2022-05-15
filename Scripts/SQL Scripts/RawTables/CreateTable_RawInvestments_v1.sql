CREATE TABLE [dbo].[raw_investments](
	[account_id] [varchar](256) NOT NULL,
	[transaction_id] [varchar](256) NOT NULL,
	[status] [varchar](20) NOT NULL,
	[amount] [varchar](50) NOT NULL,
	[investment_requested_at] [varchar](256) NOT NULL,
	[investment_completed_at] [varchar](256) NULL,
	[investment_completed_at_timestamp] [varchar](128) NULL,
	[type] [varchar](50) NOT NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
ALTER TABLE [dbo].[raw_investments] ADD  CONSTRAINT [PK_raw_investments] PRIMARY KEY CLUSTERED 
(
	[transaction_id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO

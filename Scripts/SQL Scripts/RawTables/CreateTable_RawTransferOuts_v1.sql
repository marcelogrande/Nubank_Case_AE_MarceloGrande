CREATE TABLE [dbo].[raw_transfer_outs](
	[id] [varchar](256) NOT NULL,
	[account_id] [varchar](256) NOT NULL,
	[amount] [varchar](50) NOT NULL,
	[transaction_requested_at] [varchar](256) NOT NULL,
	[transaction_completed_at] [varchar](256) NULL,
	[status] [varchar](20) NOT NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
ALTER TABLE [dbo].[raw_transfer_outs] ADD  CONSTRAINT [PK_raw_transfer_outs] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO

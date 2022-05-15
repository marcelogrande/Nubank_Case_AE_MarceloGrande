CREATE TABLE [dbo].[raw_accounts](
	[account_id] [varchar](256) NOT NULL,
	[customer_id] [varchar](256) NOT NULL,
	[created_at] [varchar](128) NOT NULL,
	[status] [varchar](50) NOT NULL,
	[account_branch] [varchar](50) NOT NULL,
	[account_check_digit] [varchar](2) NOT NULL,
	[account_number] [varchar](50) NOT NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
ALTER TABLE [dbo].[raw_accounts] ADD  CONSTRAINT [PK_raw_accounts] PRIMARY KEY CLUSTERED 
(
	[account_id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO

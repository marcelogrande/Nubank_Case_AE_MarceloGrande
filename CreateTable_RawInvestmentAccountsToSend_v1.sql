CREATE TABLE [dbo].[raw_investment_accounts_to_send](
	[account_id] [varchar](256) NOT NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
ALTER TABLE [dbo].[raw_investment_accounts_to_send] ADD  CONSTRAINT [PK_raw_investment_accounts_to_send] PRIMARY KEY CLUSTERED 
(
	[account_id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
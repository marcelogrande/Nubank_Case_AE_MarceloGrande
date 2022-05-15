CREATE TABLE [dbo].[raw_investments_daily_returns](
	[account_id] [varchar](256) NOT NULL,
	[action_date] [varchar](20) NOT NULL,
	[action_month] [char](2) NOT NULL,
	[action_year] [char](4) NOT NULL,
	[action_month_year] [char](7) NOT NULL,
	[daily_rate] [varchar](50) NOT NULL,
	[investment_in_amount] [varchar](50) NOT NULL,
	[investment_out_amount] [varchar](50) NOT NULL,
	[investment_balance_amount] [varchar](50) NOT NULL,
	[run_total_investment_balance_amount] [varchar](50) NOT NULL,
	[rownumber_account] [varchar](50) NOT NULL,
	[flag_movement] [char](1) NOT NULL,
	[run_total_investment_with_return] [varchar](50) NOT NULL,
	[daily_return] [varchar](50) NOT NULL,
	[key] [varchar](256) NOT NULL,
 CONSTRAINT [PK_raw_investments_daily_returns] PRIMARY KEY CLUSTERED 
(
	[key] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
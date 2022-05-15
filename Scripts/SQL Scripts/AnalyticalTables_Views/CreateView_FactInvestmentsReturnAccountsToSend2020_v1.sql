CREATE OR ALTER VIEW [dbo].[curated_fact_investments_return_accounts_to_send_2020] AS
SELECT 
     fid.account_id
    ,fid.action_date
	,day(fid.action_date) as action_day
    ,fid.action_month
    ,fid.action_year
    ,fid.action_month_year
    ,fid.investment_in_amount
    ,fid.investment_out_amount
    ,fid.investment_balance_amount
    ,fid.run_total_investment_balance_amount
    ,fid.run_total_investment_with_return as run_total_investment_with_income
    ,fid.daily_return as end_of_day_income
  FROM dbo.curated_fact_investments_daily_returns_2020 fid
INNER JOIN dbo.raw_investment_accounts_to_send ria ON fid.account_id = ria.account_id
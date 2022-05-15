CREATE OR ALTER VIEW [dbo].[curated_fact_investments_daily_returns_2020] AS

SELECT
     rir.account_id
    ,cast(rir.action_date as date) as action_date
    ,rir.action_month as action_month
    ,rir.action_year as action_year
    ,rir.action_month_year as action_month_year
	,eomonth(cast(rir.action_date as date)) as end_of_month
    ,rir.rownumber_account as rownumber_account
	,rir.flag_movement as flag_movement
    ,cast(rir.daily_rate as float) as daily_rate
    ,cast(rir.investment_in_amount as float) as investment_in_amount
    ,cast(rir.investment_out_amount as float) as investment_out_amount
    ,cast(rir.investment_balance_amount as float) as investment_balance_amount
    ,cast(rir.run_total_investment_balance_amount as float) as run_total_investment_balance_amount
    ,cast(rir.run_total_investment_with_return as float) as run_total_investment_with_return
    ,cast(rir.daily_return as float) as daily_return
  FROM dbo.raw_investments_daily_returns rir
 
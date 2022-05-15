CREATE OR ALTER VIEW [dbo].[curated_fact_investments_monthly_balance_2020] AS
WITH investment_daily AS
(
SELECT
     cir.account_id
    ,cir.action_date
    ,cir.action_month
    ,cir.action_year
    ,cir.action_month_year
	,cir.end_of_month
    ,dcu.city_name
    ,dcu.state_name
    ,dcu.country_name
    ,cir.rownumber_account
	,cir.flag_movement
    ,cir.daily_rate
    ,cir.investment_in_amount
    ,cir.investment_out_amount
    ,cir.investment_balance_amount
    ,cir.run_total_investment_balance_amount
    ,cir.run_total_investment_with_return
    ,cir.daily_return
  FROM dbo.curated_fact_investments_daily_returns_2020 cir
  LEFT JOIN dbo.curated_dim_customer dcu on cir.account_id = dcu.account_id
)  

SELECT
     ida.account_id
    ,ida.action_month
    ,ida.action_year
    ,ida.action_month_year
    ,ida.city_name
    ,ida.state_name
    ,ida.country_name
	,round(sum(ida.investment_in_amount), 2) as investment_in_amount
	,round(sum(ida.investment_out_amount), 2) as investment_out_amount
	,round(sum(ida.investment_balance_amount), 2) as investment_monthly_balance_amount
    ,round(sum(case when ida.action_date = ida.end_of_month then ida.run_total_investment_with_return end), 2) as run_total_investment_monthly_balance_amount
	,round(sum(ida.daily_return), 2) as monthly_investment_return
 FROM investment_daily ida
GROUP BY
    ida.account_id
   ,ida.action_month
   ,ida.action_year
   ,ida.action_month_year
   ,ida.city_name
   ,ida.state_name
   ,ida.country_name
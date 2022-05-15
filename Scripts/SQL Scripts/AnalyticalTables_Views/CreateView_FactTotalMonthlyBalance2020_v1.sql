CREATE OR ALTER VIEW [dbo].[curated_fact_total_monthly_balance_2020] AS 
SELECT 
       coalesce(ftb.account_id, fib.account_id) as account_id
      ,coalesce(ftb.action_month, fib.action_month) as action_month
      ,coalesce(ftb.action_year, fib.action_year) as action_year
      ,coalesce(ftb.action_month_year, fib.action_month_year) as month_year
      ,coalesce(ftb.city_name, fib.city_name) as city_name
      ,coalesce(ftb.state_name, fib.state_name) as state_name
      ,coalesce(ftb.country_name, fib.country_name) as country_name
      ,coalesce(ftb.transactions_in_amount, 0) as transactions_in_amount
      ,coalesce(ftb.transfer_in_amount, 0) as transfer_in_amount
      ,coalesce(ftb.pix_in_amount, 0) as pix_in_amount
      ,coalesce(ftb.transactions_out_amount, 0) as transactions_out_amount
      ,coalesce(ftb.transfer_out_amount, 0) as transfer_out_amount
      ,coalesce(ftb.pix_out_amount, 0) as pix_out_amount
      ,coalesce(ftb.transactions_monthly_balance_amount, 0) as transactions_monthly_balance_amount
      ,coalesce(ftb.run_total_transactions_monthly_balance_amount, 0) as run_total_transactions_monthly_balance_amount
	  ,coalesce(fib.investment_in_amount, 0) as investment_in_amount
	  ,coalesce(fib.investment_out_amount, 0) as investment_out_amount
	  ,coalesce(fib.investment_monthly_balance_amount, 0) as investment_monthly_balance_amount
	  ,coalesce(fib.run_total_investment_monthly_balance_amount, 0) as run_total_investment_monthly_balance_amount
	  ,coalesce(monthly_investment_return, 0) as monthly_investment_return
	  ,coalesce(ftb.transactions_monthly_balance_amount, 0) + coalesce(fib.investment_monthly_balance_amount, 0) + coalesce(monthly_investment_return, 0) as total_monthly_balance_amount
	  ,coalesce(ftb.run_total_transactions_monthly_balance_amount, 0) + coalesce(fib.run_total_investment_monthly_balance_amount, 0) as run_total_monthly_balance_amount
  FROM dbo.curated_fact_transactions_monthly_balance_2020 ftb
  FULL OUTER JOIN dbo.curated_fact_investments_monthly_balance_2020 fib  ON ftb.account_id = fib.account_id AND ftb.action_month_year = fib.action_month_year 
CREATE OR ALTER VIEW [dbo].[curated_fact_investments_fill_daily_gaps_2020] AS

WITH
--Collect investments table, filtering only completed status and aggregating per account and date
fact_investments AS
(
SELECT 
     cfi.account_id
    ,dtm.action_date
    ,sum(case when cfi.transaction_type = 'investment_transfer_in' then cfi.amount else 0 end) as investment_in_amount
    ,sum(case when cfi.transaction_type = 'investment_transfer_out' then -cfi.amount else 0 end) as investment_out_amount
    ,sum(case when cfi.transaction_type = 'investment_transfer_out' then -cfi.amount else cfi.amount end) as investment_balance_amount
  FROM dbo.curated_fact_investments cfi
  LEFT JOIN dbo.curated_dim_time dtm on cfi.transaction_completed_id = dtm.time_id
 WHERE cfi.status = 'completed' --AND cfi.account_id  = '1501827093567989504' --('2059944788826779904')
 GROUP BY
     cfi.account_id
    ,dtm.action_date  
),

--Collect first date by customer in investments table
customers_min_date AS
(
SELECT
     cfi.account_id
    ,min(cfi.action_date) as min_action_date
  FROM fact_investments cfi
--  
 GROUP BY
     cfi.account_id
),

--Collect distinct days in the year of interest
days_year AS
(
SELECT 
     DISTINCT 
     dtm.action_date
    ,dtm.action_month
    ,dtm.action_year    
    ,dtm.action_month_year	
  FROM dbo.curated_dim_time dtm
 WHERE year(dtm.action_date) = '2020'
),

--Fill gaps in sparsing data for calculate daily balance and returns
customers_days_year AS
(
SELECT 
     dyr.action_date
    ,dyr.action_month
    ,dyr.action_year
    ,dyr.action_month_year
    ,cus.account_id
    ,0.0001 as daily_rate
  FROM (SELECT account_id, min_action_date
          FROM customers_min_date) cus
  RIGHT OUTER JOIN  days_year dyr on cus.min_action_date <= dyr.action_date
  
)

SELECT
     cyr.account_id
    ,cyr.action_date
    ,cyr.action_month
    ,cyr.action_year
    ,cyr.action_month_year
    ,cyr.daily_rate
    ,coalesce(cfi.investment_in_amount, 0) as investment_in_amount
    ,coalesce(cfi.investment_out_amount, 0) as investment_out_amount
    ,coalesce(cfi.investment_balance_amount, 0) as investment_balance_amount
    ,sum(coalesce(cfi.investment_balance_amount, 0)) OVER (PARTITION BY cyr.account_id ORDER BY cyr.action_date asc) as run_total_investment_balance_amount
    ,row_number() OVER (PARTITION BY cyr.account_id ORDER BY cyr.action_date asc) as rownumber_account
    ,case when coalesce(cfi.investment_balance_amount, 0) != 0 then 1 else 0 end as flag_movement
  FROM customers_days_year cyr
  LEFT JOIN fact_investments cfi ON cyr.action_date = cfi.action_date
                                AND cyr.account_id = cfi.account_id
 WHERE cyr.account_id is not null
CREATE OR ALTER VIEW [dbo].[curated_fact_transactions_monthly_balance_2020] AS

WITH
fact_monthly_transactions AS
(
SELECT
     /*Dimensions*/
     ftr.account_id
	,dtm.action_month_year
    ,round(sum(case when ftr.transaction_type in ('transfer_in', 'pix_in') then ftr.amount else 0 end), 2) as transactions_in_amount
    ,round(sum(case when ftr.transaction_type = 'transfer_in' then ftr.amount else 0 end), 2) as transfer_in_amount
    ,round(sum(case when ftr.transaction_type = 'pix_in' then ftr.amount else 0 end), 2) as pix_in_amount
    ,round(sum(case when ftr.transaction_type in ('transfer_out', 'pix_out') then -ftr.amount else 0 end), 2) as transactions_out_amount
    ,round(sum(case when ftr.transaction_type = 'transfer_out' then -ftr.amount else 0 end), 2) as transfer_out_amount
    ,round(sum(case when ftr.transaction_type = 'pix_out' then -ftr.amount else 0 end), 2) as pix_out_amount
    ,round(sum(case when ftr.transaction_type in ('transfer_out', 'pix_out') then -ftr.amount else ftr.amount end), 2) as transactions_monthly_balance_amount
  FROM dbo.curated_fact_transactions ftr
  LEFT JOIN dbo.curated_dim_time dtm on ftr.transaction_completed_id = dtm.time_id
 WHERE ftr.status = 'completed'
 GROUP BY
     ftr.account_id
    ,dtm.action_month_year	
),

customer_min_month AS
(
SELECT 
     ftr.account_id
	,min(ftr.action_month_year) as min_month_year
  FROM	fact_monthly_transactions ftr
 GROUP BY
     ftr.account_id
),

month_year AS
(
SELECT
     DISTINCT
	 dtm.action_month_year
	,dtm.action_month
	,dtm.action_year
  FROM dbo.curated_dim_time dtm
 WHERE year(dtm.action_date) = '2020' 
),

customer_month_year AS
(
SELECT
     myr.action_month_year
	,myr.action_month
	,myr.action_year
	,cmm.account_id
  FROM (SELECT account_id, min_month_year 
          FROM customer_min_month) cmm
 RIGHT OUTER JOIN month_year myr on cmm.min_month_year <= myr.action_month_year
) 

SELECT
     cm.account_id
    ,cm.action_month
    ,cm.action_year
    ,cm.action_month_year
    ,dc.city_name
    ,dc.state_name
    ,dc.country_name
    ,coalesce(ft.transactions_in_amount, 0) as transactions_in_amount
    ,coalesce(ft.transfer_in_amount, 0) as transfer_in_amount
    ,coalesce(ft.pix_in_amount, 0) as pix_in_amount
    ,coalesce(ft.transactions_out_amount, 0) as transactions_out_amount
    ,coalesce(ft.transfer_out_amount, 0) as transfer_out_amount
    ,coalesce(ft.pix_out_amount, 0) as pix_out_amount
    ,coalesce(ft.transactions_monthly_balance_amount, 0) as transactions_monthly_balance_amount
    ,round(sum(coalesce(ft.transactions_monthly_balance_amount, 0)) over (partition by cm.account_id order by cm.action_month_year asc), 2) as run_total_transactions_monthly_balance_amount
  FROM customer_month_year cm
  LEFT JOIN fact_monthly_transactions ft ON cm.account_id = ft.account_id
                                        AND cm.action_month_year = ft.action_month_year
  LEFT JOIN dbo.curated_dim_customer dc on cm.account_id = dc.account_id
 WHERE cm.account_id is not null
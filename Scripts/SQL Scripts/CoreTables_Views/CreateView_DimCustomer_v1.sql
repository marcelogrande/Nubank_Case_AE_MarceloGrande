CREATE OR ALTER VIEW [dbo].[curated_dim_customer] as
SELECT 
     rac.account_id as account_id
    ,rac.customer_id as customer_id
    ,cast(rac.created_at as datetime) as created_at
    ,cast(rac.status as VARCHAR(20)) as status
    ,cast(rac.account_branch as int) as account_branch
    ,cast(rac.account_check_digit as int) as account_check_digit
    ,cast(rac.account_number as int) as account_number
    ,upper(rci.city) as city_name
    ,upper(rst.state) as state_name
    ,upper(rco.country) as country_name
  FROM dbo.raw_accounts rac
  LEFT JOIN dbo.raw_customers rcu on rac.customer_id = rcu.customer_id
  LEFT JOIN dbo.raw_city rci on rcu.customer_city = rci.city_id
  LEFT JOIN dbo.raw_state rst on rci.state_id = rst.state_id
  LEFT JOIN dbo.raw_country rco on rst.country_id = rco.country_id
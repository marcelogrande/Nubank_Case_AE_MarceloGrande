CREATE OR ALTER VIEW [dbo].[curated_fact_investments] AS
SELECT 
     rin.transaction_id as id
    ,rin.account_id as account_id
    ,case when rin.status = 'failed' then rin.investment_requested_at else rin.investment_completed_at end as time_id
    ,cast(rin.amount as float) as amount
    ,rin.investment_requested_at as transaction_requested_id
    ,rin.investment_completed_at as transaction_completed_id
    ,rin.status as status
    ,rin.type as transaction_type   
  FROM dbo.raw_investments rin
CREATE OR ALTER VIEW [dbo].[curated_fact_transactions_investments] AS
SELECT id
      ,account_id
      ,time_id
      ,amount
      ,transaction_requested_id
      ,transaction_completed_id
      ,status
      ,transaction_type
  FROM dbo.curated_fact_investments
UNION ALL
SELECT id
      ,account_id
      ,time_id
      ,amount
      ,transaction_requested_id
      ,transaction_completed_id
      ,status
      ,transaction_type
  FROM dbo.curated_fact_transactions





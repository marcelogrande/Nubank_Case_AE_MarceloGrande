CREATE OR ALTER VIEW [dbo].[curated_fact_transactions] AS
SELECT 
     rto.id
    ,rto.account_id as account_id
    ,case when rto.status = 'failed' then rto.transaction_requested_at else rto.transaction_completed_at end as time_id
    ,cast(rto.amount as float) as amount
    ,rto.transaction_requested_at as transaction_requested_id
    ,rto.transaction_completed_at as transaction_completed_id
    ,rto.status as status
    ,'transfer_out' as transaction_type
  FROM dbo.raw_transfer_outs rto
 UNION ALL
SELECT 
     rti.id as id
    ,rti.account_id as account_id
    ,case when rti.status = 'failed' then rti.transaction_requested_at else rti.transaction_completed_at end as time_id
    ,cast(rti.amount as float) as amount
    ,rti.transaction_requested_at as transaction_requested_id
    ,rti.transaction_completed_at as transaction_completed_id
    ,rti.status as status
    ,'transfer_in' as transaction_type
  FROM dbo.raw_transfer_ins rti  
 UNION ALL
SELECT 
     rpm.id as id
    ,rpm.account_id as account_id
    ,case when rpm.status = 'failed' then rpm.pix_requested_at else rpm.pix_completed_at end as time_id
    ,cast(rpm.pix_amount as float) as amount
    ,rpm.pix_requested_at as transaction_requested_id
    ,rpm.pix_completed_at as transaction_completed_id
    ,rpm.status as status
    ,rpm.in_or_out as transaction_type
  FROM dbo.raw_pix_movements rpm
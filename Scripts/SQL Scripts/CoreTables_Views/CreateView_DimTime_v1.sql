CREATE OR ALTER VIEW [dbo].[curated_dim_time] as
SELECT 
     rtm.time_id
    ,cast(rtm.action_timestamp as datetime) as action_timestamp
    ,cast(rtm.action_timestamp as date) as action_date
    ,cast(rtm.action_timestamp as time) as action_time
    ,cast(datepart(hour, cast(rtm.action_timestamp as datetime)) as INT) as action_hour
    ,cast(rwk.action_week as int) as action_week
    ,cast(rwd.action_weekday as int) as action_weekday
    ,cast(
     case when rwd.action_weekday = '0' then 'Mon'
          when rwd.action_weekday = '1' then 'Tue'
          when rwd.action_weekday = '2' then 'Wed'
          when rwd.action_weekday = '3' then 'Thu'
          when rwd.action_weekday = '4' then 'Fri'
          when rwd.action_weekday = '5' then 'Sat'
          when rwd.action_weekday = '6' then 'Sun'
        end as CHAR(3)) as action_weekday_name               
    ,cast(format(cast(rmo.action_month as int), '00') as CHAR(2)) as action_month
    ,cast(
     case when rmo.action_month = '1' then 'Jan'
          when rmo.action_month = '2' then 'Feb'
          when rmo.action_month = '3' then 'Mar'
          when rmo.action_month = '4' then 'Apr'
          when rmo.action_month = '5' then 'May'
          when rmo.action_month = '6' then 'Jun'
          when rmo.action_month = '7' then 'Jul'
          when rmo.action_month = '8' then 'Aug'
          when rmo.action_month = '9' then 'Sep'
          when rmo.action_month = '10' then 'Oct'
          when rmo.action_month = '11' then 'Nov'
          when rmo.action_month = '12' then 'Dec'
        end as CHAR(3)) as action_month_name    
    ,cast(ryr.action_year as char(4)) as action_year
	,cast(concat(cast(ryr.action_year as char(4)),'-',cast(format(cast(rmo.action_month as int), '00') as CHAR(2))) as CHAR(7)) as action_month_year 
    ,eomonth(cast(rtm.action_timestamp as date)) as end_of_month
  FROM dbo.raw_time rtm
  LEFT JOIN dbo.raw_week rwk on rtm.week_id = rwk.week_id
  LEFT JOIN dbo.raw_weekday rwd on rtm.weekday_id = rwd.weekday_id
  LEFT JOIN dbo.raw_month rmo on rtm.month_id = rmo.month_id
  LEFT JOIN dbo.raw_year ryr on rtm.year_id = ryr.year_id

{{ config(materialized='table') }}

select
  monthly_reporting_period,
  property_state,
  channel,
  count(*) as loan_months,
  countif(current_loan_delinquency_status = 0) as current_count,
  countif(current_loan_delinquency_status > 0) as delinquent_count,
  safe_divide(countif(current_loan_delinquency_status > 0), count(*)) as delinquency_rate
from {{ ref('int_loan_monthly') }}
group by 1, 2, 3
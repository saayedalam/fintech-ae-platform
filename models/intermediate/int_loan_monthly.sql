select
  p.loan_sequence_number,
  p.monthly_reporting_period,
  p.current_actual_upb,
  p.current_loan_delinquency_status,
  p.current_interest_rate,
  p.loan_age,
  a.credit_score,
  a.first_payment_date,
  a.maturity_date,
  a.orig_upb,
  a.orig_interest_rate,
  a.property_state,
  a.property_type,
  a.channel,
  a.seller_name,
  a.servicer_name,
  r.mortgage_rate_30y
from {{ ref('stg_freddie_performance') }} p
left join {{ ref('stg_freddie_acquisition') }} a
  on p.loan_sequence_number = a.loan_sequence_number
left join {{ ref('stg_mortgage_rates') }} r
  on parse_date('%Y%m', cast(p.monthly_reporting_period as string)) = r.month
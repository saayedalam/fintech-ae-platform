{% snapshot snap_fct_delinquency_monthly %}

{{
  config(
    target_schema='snapshots',
    unique_key="concat(cast(monthly_reporting_period as string), '-', property_state, '-', channel)",
    strategy='check',
    check_cols=['delinquency_rate', 'loan_months', 'delinquent_count']
  )
}}

select
  monthly_reporting_period,
  property_state,
  channel,
  loan_months,
  delinquent_count,
  delinquency_rate
from {{ ref('fct_delinquency_monthly') }}

{% endsnapshot %}
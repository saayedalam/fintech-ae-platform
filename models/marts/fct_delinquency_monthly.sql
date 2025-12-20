select
    reporting_month,
    property_state,
    channel,

    count(*) as loan_months,

    sum(is_current)     as current_count,
    sum(is_delinquent)  as delinquent_count,

    safe_divide(
        sum(is_delinquent),
        count(*)
    ) as delinquency_rate,

    avg(mortgage_rate_30y) as avg_mortgage_rate_30y

from {{ ref('int_delinquency_flags_monthly') }}
group by 1, 2, 3
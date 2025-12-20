with base as (

    select *
    from {{ ref('int_delinquency_flags_monthly') }}

),

final as (

    select
        reporting_month,

        case
            when credit_score is null then 'unknown'
            when credit_score < 620 then '<620'
            when credit_score between 620 and 679 then '620-679'
            when credit_score between 680 and 739 then '680-739'
            when credit_score >= 740 then '740+'
            else 'unknown'
        end as credit_score_band,

        count(*) as loan_months,
        sum(is_current) as current_count,
        sum(is_delinquent) as delinquent_count,

        safe_divide(sum(is_delinquent), count(*)) as delinquency_rate,
        avg(mortgage_rate_30y) as avg_mortgage_rate_30y

    from base
    group by 1, 2

)

select *
from final
with base as (

    select *
    from {{ ref('int_loan_monthly') }}

),

final as (

    select
        loan_sequence_number,
        monthly_reporting_period,
        parse_date('%Y%m', cast(monthly_reporting_period as string)) as reporting_month,

        property_state,
        channel,

        current_loan_delinquency_status,
        current_actual_upb,
        current_interest_rate,
        loan_age,

        credit_score,
        first_payment_date,
        maturity_date,
        orig_upb,
        orig_interest_rate,
        seller_name,
        servicer_name,

        mortgage_rate_30y,

        -- Flags
        case
            when cast(current_loan_delinquency_status as string) = '0' then 1 else 0
        end as is_current,

        case
            when cast(current_loan_delinquency_status as string) != '0' then 1 else 0
        end as is_delinquent,

        -- Optional bucket (kept simple)
        case
            when cast(current_loan_delinquency_status as string) = '0' then 'current'
            else 'delinquent'
        end as delinquency_bucket

    from base

)

select *
from final
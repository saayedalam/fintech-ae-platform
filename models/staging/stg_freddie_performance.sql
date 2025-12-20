with src as (

    select *
    from {{ source('raw_fintech', 'freddie_performance_raw') }}

),

renamed as (

    select
        cast(string_field_0 as string) as loan_sequence_number,
        cast(int64_field_1 as int64)   as monthly_reporting_period,

        cast(double_field_2 as float64) as current_actual_upb,
        cast(int64_field_3 as int64)    as current_loan_delinquency_status,
        cast(int64_field_4 as int64)    as loan_age,
        cast(int64_field_5 as int64)    as remaining_months_to_legal_maturity,

        -- YYYYMM dates (kept as INT64 for now)
        cast(int64_field_6 as int64) as defect_settlement_date,

        cast(string_field_7 as string) as modification_flag,
        cast(int64_field_8 as int64)   as zero_balance_code,
        cast(int64_field_9 as int64)   as zero_balance_effective_date,

        cast(double_field_10 as float64) as current_interest_rate,
        cast(double_field_11 as float64) as current_non_interest_bearing_upb,

        cast(int64_field_12 as int64) as ddlpi,

        cast(string_field_13 as string) as mi_recoveries,
        cast(string_field_14 as string) as net_sale_proceeds,
        cast(string_field_15 as string) as non_mi_recoveries,
        cast(string_field_16 as string) as expenses,
        cast(string_field_17 as string) as legal_costs,
        cast(string_field_18 as string) as maintenance_and_preservation_costs,
        cast(string_field_19 as string) as taxes_and_insurance,
        cast(string_field_20 as string) as miscellaneous_expenses,
        cast(string_field_21 as string) as actual_loss_calculation,
        cast(string_field_22 as string) as cumulative_modification_cost,
        cast(string_field_23 as string) as interest_rate_step_indicator,
        cast(string_field_24 as string) as payment_deferral_flag,

        cast(int64_field_25 as int64)    as estimated_loan_to_value,
        cast(double_field_26 as float64) as zero_balance_removal_upb,

        cast(string_field_27 as string)  as delinquent_accrued_interest,
        cast(string_field_28 as string)  as delinquency_due_to_disaster,
        cast(string_field_29 as string)  as borrower_assistance_status_code,
        cast(string_field_30 as string)  as current_month_modification_cost,
        cast(double_field_31 as float64) as interest_bearing_upb
    from src

)

select *
from renamed
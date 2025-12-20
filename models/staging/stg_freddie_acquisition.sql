with src as (

    select *
    from {{ source('raw_fintech', 'freddie_acquisition_raw') }}

)

select
    -- Identifiers
    string_field_19 as loan_sequence_number,

    -- Core borrower / loan attributes
    int64_field_0 as credit_score,

    -- YYYYMM -> DATE (first day of month)
    parse_date('%Y%m', cast(int64_field_1 as string)) as first_payment_date,
    parse_date('%Y%m', cast(int64_field_3 as string)) as maturity_date,

    -- Flags / codes (kept as STRING for consistency)
    cast(bool_field_2 as string)  as first_time_homebuyer_flag,
    string_field_7                as occupancy_status,
    string_field_13               as channel,
    cast(bool_field_14 as string) as prepayment_penalty_mortgage_flag,
    string_field_15               as amortization_type,

    -- Property
    string_field_16 as property_state,
    string_field_17 as property_type,
    int64_field_18  as postal_code,

    -- Loan terms / amounts
    int64_field_10  as orig_upb,
    int64_field_11  as orig_ltv,
    int64_field_8   as orig_combined_ltv,
    int64_field_9   as orig_dti,
    double_field_12 as orig_interest_rate,
    int64_field_21  as orig_loan_term,

    -- Purpose / parties
    string_field_20 as loan_purpose,
    int64_field_22  as num_borrowers,
    string_field_23 as seller_name,
    string_field_24 as servicer_name,

    -- Other fields (kept; cleaned names)
    int64_field_4               as msa,
    int64_field_5               as mi_pct,
    int64_field_6               as num_units,
    cast(bool_field_25 as string) as super_conforming_flag,
    string_field_26             as pre_relief_refinance_loan_sequence_number,
    string_field_27             as special_eligibility_program,
    string_field_28             as relief_refinance_indicator,
    int64_field_29              as property_valuation_method,
    cast(bool_field_30 as string) as interest_only_indicator,
    string_field_31             as mi_cancellation_indicator
from src
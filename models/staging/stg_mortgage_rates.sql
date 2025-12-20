with src as (

    select *
    from {{ source('raw_macro', 'mortgage_rates_raw') }}

)

select
    observation_date as month,
    mortgage30us     as mortgage_rate_30y
from src
select
    observation_date as month,
    MORTGAGE30US as mortgage_rate_30y
from {{ source('raw_macro', 'mortgage_rates_raw') }}
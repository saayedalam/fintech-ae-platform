select
    loan_sequence_number,
    monthly_reporting_period,
    count(*) as row_count
from {{ ref('int_loan_monthly') }}
group by 1, 2
having count(*) > 1
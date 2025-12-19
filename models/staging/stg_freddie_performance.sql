{{ config(materialized='view') }}

select
  *
from {{ source('raw_fintech', 'freddie_performance_raw') }}
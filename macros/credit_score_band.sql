{% macro credit_score_band(score_expr) %}
    case
        when {{ score_expr }} is null then 'unknown'
        when {{ score_expr }} < 620 then '<620'
        when {{ score_expr }} between 620 and 679 then '620-679'
        when {{ score_expr }} between 680 and 739 then '680-739'
        when {{ score_expr }} >= 740 then '740+'
        else 'unknown'
    end
{% endmacro %}
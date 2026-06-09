{{
    config(
        materialized = 'ephemeral',
        )
}}

WITH hosts AS (
    SELECT
        host_id
        , MAX(host_name) host_name
        , MAX(host_since) host_since
        , BOOL_OR(is_superhost) is_superhost
        , MAX(response_rate_quality) response_rate_quality
        , MAX(host_created_at) host_created_at
    FROM
        {{ ref('obt') }}
    GROUP BY
        host_id
)

SELECT * FROM hosts
{{
    config(
        materialized = 'ephemeral',
        )
}}

WITH bookings AS (
    SELECT
        booking_id
        , MAX(booking_date) booking_date
        , MAX(booking_status) booking_status
        , MAX(created_at) created_at
    FROM
        {{ ref('obt') }}
    GROUP BY
        booking_id
)

SELECT * FROM bookings
{{
    config(
        materialized = 'ephemeral',
        )
}}

WITH listings AS (
    SELECT
        listing_id
        , MAX(property_type) property_type
        , MAX(room_type) room_type
        , MAX(city) city
        , MAX(country) country
        , MAX(price_per_night_tag) price_per_night_tag
        , MAX(listings_created_at) listings_created_at
    FROM
        {{ ref('obt') }}
    GROUP BY
        listing_id
)

SELECT * FROM listings
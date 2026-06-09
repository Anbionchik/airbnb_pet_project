{% set configs = [
    {
            "table": "de_pet_project_db.gold.obt"
            , "columns" : "gold_obt.booking_id, gold_obt.listing_id, gold_obt.host_id, gold_obt.total_booking_amount, gold_obt.service_fee, gold_obt.cleaning_fee, gold_obt.accommodates, gold_obt.bedrooms, gold_obt.bathrooms, gold_obt.price_per_night, gold_obt.response_rate"
            , "alias" : "gold_obt"
    }, 
    {
            "table": "de_pet_project_db.gold.dim_listings"
            , "columns" : ""
            , "alias" : "gl"
            , "join_condition" : "gl.listing_id = gold_obt.listing_id"
    }, 
    {
            "table": "de_pet_project_db.gold.dim_hosts"
            , "columns" : ""
            , "alias" : "gh"
            , "join_condition" : "gold_obt.host_id = gh.host_id"
    }, 
    {
            "table": "de_pet_project_db.gold.dim_bookings"
            , "columns" : ""
            , "alias" : "gb"
            , "join_condition" : "gold_obt.booking_id = gb.booking_id"
    }, 
] %}

SELECT
    {{ configs[0].columns }}
FROM
    {% for config in configs %}
        {% if loop.first %}
            {{ config['table'] }} AS {{ config['alias'] }}
        {% else %}
            LEFT JOIN {{ config['table'] }} AS {{ config['alias'] }}
            ON {{ config['join_condition'] }}
        {% endif%}
    {% endfor %}
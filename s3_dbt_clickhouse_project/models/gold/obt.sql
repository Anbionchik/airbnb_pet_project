{% set configs = [
    {
            "model": ref("silver_bookings")
            , "columns" : "sb.*"
            , "alias" : "sb"
    }, 
    {
            "model": ref("silver_listings")
            , "columns" : "sl.host_id, sl.property_type, sl.room_type, sl.city, sl.country, sl.accommodates, sl.bedrooms, sl.bathrooms, sl.price_per_night, sl.price_per_night_tag, sl.created_at AS listings_created_at"
            , "alias" : "sl"
            , "join_condition" : "sb.listing_id = sl.listing_id"
    }, 
    {
            "model": ref("silver_hosts")
            , "columns" : "sh.host_name, sh.host_since, sh.is_superhost, sh.response_rate, sh.response_rate_quality, sh.created_at AS host_created_at"
            , "alias" : "sh"
            , "join_condition" : "sl.host_id = sh.host_id"
    }, 
] %}

SELECT
    {% for config in configs %}
        {{ config.columns }}{% if not loop.last %},{% endif %}
    {% endfor %}
FROM
    {% for config in configs %}
        {% if loop.first %}
            {{ config['model'] }} AS {{ config['alias'] }}
        {% else %}
            LEFT JOIN {{ config['model'] }} AS {{ config['alias'] }}
            ON {{ config['join_condition'] }}
        {% endif%}
    {% endfor %}
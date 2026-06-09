{% set nights_booked = 1%}
{% set flag = 0 %}

SELECT * FROM {{ ref('bronze_bookings') }}
{% if flag == 1 %}
    WHERE NIGHTS_BOOKED > {{ nights_booked }}
{% else %}
    WHERE NIGHTS_BOOKED = 1
{% endif %}
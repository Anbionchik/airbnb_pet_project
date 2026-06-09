-- Удалить таблицы, если существуют
DROP TABLE IF EXISTS staging.bookings;
DROP TABLE IF EXISTS staging.listings;
DROP TABLE IF EXISTS staging.hosts;

-- Hosts
CREATE TABLE staging.hosts (
    host_id BIGINT PRIMARY KEY,
    host_name TEXT,
    host_since DATE,
    is_superhost BOOLEAN,
    response_rate BIGINT,
    created_at TIMESTAMP
);

-- Listings
CREATE TABLE staging.listings (
    listing_id BIGINT PRIMARY KEY,
    host_id BIGINT,
    property_type TEXT,
    room_type TEXT,
    city TEXT,
    country TEXT,
    accommodates BIGINT,
    bedrooms BIGINT,
    bathrooms BIGINT,
    price_per_night BIGINT,
    created_at TIMESTAMP
);

-- Bookings
CREATE TABLE staging.bookings (
    booking_id TEXT PRIMARY KEY,
    listing_id BIGINT,
    booking_date TIMESTAMP,
    nights_booked BIGINT,
    booking_amount BIGINT,
    cleaning_fee BIGINT,
    service_fee BIGINT,
    booking_status TEXT,
    created_at TIMESTAMP
);
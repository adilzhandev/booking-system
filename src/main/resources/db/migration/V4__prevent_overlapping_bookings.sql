-- Supplies GiST equality support for BIGINT room_id.
CREATE EXTENSION IF NOT EXISTS btree_gist;

ALTER TABLE bookings
    ADD CONSTRAINT ex_bookings_room_active_period
    EXCLUDE USING gist (
        room_id WITH =,
        tstzrange(start_time, end_time, '[)') WITH &&
    )
    WHERE (status = 'ACTIVE');


    
-------------------------------------------------------------------------------------------------
-- 03/11/2023 prasanna sai kommineni - CIDM-10188 B-215263 : Psychotropic Prescription Review Report Dashboard

-----------------------------------------------------------------------------------------------------
DROP FUNCTION IF EXISTS cjams.getbusinessdaysbetween(start_timestamp TIMESTAMP, end_timestamp TIMESTAMP);
DROP FUNCTION IF EXISTS cjams.getbusinessdaysbetween(start_timestamp timestamp without time zone, end_timestamp timestamp without time zone);
DROP FUNCTION IF EXISTS cjams.getbusinessdaysbetween(start_timestamp timestamp with time zone, end_timestamp timestamp with time zone);
DROP FUNCTION IF EXISTS cjams.getbusinessdaysbetween(start_timestamp timestamp with time zone, end_timestamp timestamp with time zone ,start_settingname VARCHAR,end_settingname VARCHAR);
CREATE OR REPLACE FUNCTION cjams.getbusinessdaysbetween(start_timestamp timestamp with time zone, end_timestamp timestamp with time zone,start_settingname VARCHAR,end_settingname VARCHAR)
 RETURNS TABLE(business_time text)
 LANGUAGE plpgsql
AS $function$
DECLARE
    total_seconds BIGINT := 0; -- Total business seconds
    current_day_start TIMESTAMP;
    current_day_end TIMESTAMP;
    business_start TIME;
    business_end TIME;
BEGIN
    -- Fetch business start and end times from settings table
    SELECT settingvalue
    INTO business_start
    FROM cjams.settings
    WHERE settingname = start_settingname;
   
    SELECT settingvalue
    INTO business_end
    FROM cjams.settings
    WHERE settingname = end_settingname;

    -- Loop through each day between start and end timestamps
    FOR current_day_start IN
        (SELECT generate_series(
            DATE_TRUNC('day', start_timestamp),
            DATE_TRUNC('day', end_timestamp),
            INTERVAL '1 day'
        ))
    LOOP
        -- Define business hour window for the current day dynamically
        current_day_start := current_day_start + INTERVAL '1 hour' * EXTRACT(HOUR FROM business_start);
        current_day_start := current_day_start + INTERVAL '1 minute' * EXTRACT(MINUTE FROM business_start);

        current_day_end := current_day_start + (business_end - business_start);

        -- Adjust start and end timestamps for the first and last day in the range
        IF current_day_start < start_timestamp THEN
            current_day_start := start_timestamp;
        END IF;
        IF current_day_end > end_timestamp THEN
            current_day_end := end_timestamp;
        END IF;

        -- Exclude weekends and holidays
        IF EXTRACT(DOW FROM current_day_start) NOT IN (0, 6) AND
           NOT EXISTS (
               SELECT 1
               FROM cjams.holidays
               WHERE current_day_start::date = holidays.date::date
           )
        THEN
            -- Accumulate business seconds for the current day
            total_seconds := total_seconds + GREATEST(
                0,
                EXTRACT(EPOCH FROM (current_day_end - current_day_start))
            );
        END IF;
    END LOOP;

    -- Calculate business days, hours, and minutes and format into a single string
    RETURN QUERY SELECT
        CAST(FLOOR(total_seconds / (8 * 3600)) AS TEXT) || ' D, ' ||
        CAST(FLOOR((total_seconds % (8 * 3600)) / 3600) AS TEXT) || ' H, ' ||
        CAST(FLOOR((total_seconds % 3600) / 60) AS TEXT) || ' M' AS business_time;
END;
$function$
;
DROP FUNCTION IF EXISTS getnthweekday(year INT, month INT, dow INT, n INT);
CREATE OR REPLACE FUNCTION getnthweekday(year INT, month INT, dow INT, n INT)
RETURNS DATE AS $$
DECLARE
    d DATE;  -- Variable to store the current date being checked
    first_day_of_month DATE;  -- First day of the month
    count INT := 0;  -- Counter for the occurrences of the desired weekday
BEGIN
    -- Ensure 'n' is a positive integer
    IF n <= 0 THEN
        RAISE EXCEPTION 'n must be a positive integer';
    END IF;

    -- Ensure 'dow' is within the range of 0 to 6 (PostgreSQL DOW range)
    IF dow < 0 OR dow > 6 THEN
        RAISE EXCEPTION 'Invalid day of week (dow). It must be between 0 (Sunday) and 6 (Saturday).';
    END IF;

    -- Calculate the first day of the month
    first_day_of_month := MAKE_DATE(year, month, 1);

    -- Find the first occurrence of the desired weekday in the month
    d := first_day_of_month;
    IF EXTRACT(DOW FROM d) <= dow THEN
        d := d + (dow - EXTRACT(DOW FROM d))::INT;
    ELSE
        d := d + (7 - EXTRACT(DOW FROM d) + dow)::INT;
    END IF;

    -- Loop to find the nth occurrence of the weekday
    WHILE count < n LOOP
        count := count + 1;
        
        -- If count matches 'n', return the date
        IF count = n THEN
            RETURN d;
        END IF;

        -- Move to the next week
        d := d + INTERVAL '7 days';
    END LOOP;

    -- Return the found date (shouldn't reach here unless n is a valid positive integer)
    RETURN d;
END;
$$ LANGUAGE plpgsql;

-- Function to calculate the last weekday of a month
DROP FUNCTION IF EXISTS getlastweekday(year INT, month INT, dow INT);
CREATE OR REPLACE FUNCTION getlastweekday(year INT, month INT, dow INT)
RETURNS DATE AS $$
DECLARE
    d DATE := (MAKE_DATE(year, month, 1) + INTERVAL '1 month' - INTERVAL '1 day')::DATE;
BEGIN
    WHILE EXTRACT(DOW FROM d) != dow LOOP
        d := d - INTERVAL '1 day';
    END LOOP;
    RETURN d;
END;
$$ LANGUAGE plpgsql;
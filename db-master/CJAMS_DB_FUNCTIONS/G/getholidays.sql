DROP FUNCTION IF EXISTS cjams.getholidays();

CREATE OR REPLACE FUNCTION cjams.getholidays()
RETURNS TABLE (holidaydate DATE, description CHARACTER VARYING)
LANGUAGE plpgsql
STABLE
AS
$function$
---------------------------------------------------------------------------------------
-- This procedure will return all holidays of previous, current and next years.
-- 05/14/2026 Raghavendra Puli - CIDM-11381 -  F2F Monthly Visit Entry Delay Narrative.
---------------------------------------------------------------------------------------
BEGIN
   RETURN QUERY
    SELECT
    h.date,
    h.description
    FROM cjams.holidays h
    WHERE h.activeflag = 1
      AND h.year BETWEEN
          (extract(year FROM current_date)::int - 1)::varchar
      AND (extract(year FROM current_date)::int + 1)::varchar
    ORDER BY h.date;

END;
$function$;
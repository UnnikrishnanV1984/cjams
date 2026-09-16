CREATE OR REPLACE FUNCTION cjams.f_months_between(d1 timestamp without time zone, d2 timestamp without time zone)
 RETURNS integer
 LANGUAGE plpgsql
AS $function$

DECLARE
    declare D_OLD DATE;
    declare D_NEW DATE;
BEGIN
    IF D1 > D2 THEN
        D_OLD = D2;
        D_NEW = D1;
    ELSE
        D_OLD = D1;
        D_NEW = D2;
    END IF;
    
    --RETURN (SELECT date_part('month',age( D_NEW, D_OLD)));
	RETURN (SELECT date_part('year',age( D_NEW, D_OLD)) * 12 + date_part('month',age( D_NEW, D_OLD)));
END;

$function$
;

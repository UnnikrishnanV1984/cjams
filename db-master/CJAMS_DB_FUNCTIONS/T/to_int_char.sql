CREATE OR REPLACE FUNCTION cjams.to_int_char(varchar)
RETURNS bigint
LANGUAGE sql
IMMUTABLE
AS $function$ select to_number($1,'99999999999999999999') $function$
;
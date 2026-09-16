CREATE OR REPLACE FUNCTION cjams.to_char_yyyymm(timestamp without time zone)
 RETURNS text
 LANGUAGE sql immutable
AS $function$ select to_char($1,'YYYY-MM') $function$
;

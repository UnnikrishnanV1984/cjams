CREATE OR REPLACE FUNCTION cjams.to_char_yyyymmdd(timestamp without time zone)
 RETURNS text
 LANGUAGE sql immutable
AS $function$ select to_char($1,'YYYY-MM-DD') $function$
;
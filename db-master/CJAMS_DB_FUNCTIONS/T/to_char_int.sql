CREATE OR REPLACE FUNCTION cjams.to_char_int(integer)
 RETURNS text
 LANGUAGE sql
 IMMUTABLE
AS $function$ select replace(to_char($1,'99999999999999'),' ','') $function$--Max 14 Characters
;
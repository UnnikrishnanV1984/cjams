 CREATE OR REPLACE FUNCTION public.gbt_float8_compress(internal) 
  RETURNS internal                                               
  LANGUAGE c                                                     
  IMMUTABLE STRICT                                               
 AS '$libdir/btree_gist', $function$gbt_float8_compress$function$


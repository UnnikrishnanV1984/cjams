 CREATE OR REPLACE FUNCTION public.gbt_timetz_compress(internal) 
  RETURNS internal                                               
  LANGUAGE c                                                     
  IMMUTABLE STRICT                                               
 AS '$libdir/btree_gist', $function$gbt_timetz_compress$function$


 CREATE OR REPLACE FUNCTION public.gbt_ts_compress(internal) 
  RETURNS internal                                           
  LANGUAGE c                                                 
  IMMUTABLE STRICT                                           
 AS '$libdir/btree_gist', $function$gbt_ts_compress$function$


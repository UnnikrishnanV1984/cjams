 CREATE OR REPLACE FUNCTION public.gbt_int8_fetch(internal) 
  RETURNS internal                                          
  LANGUAGE c                                                
  IMMUTABLE STRICT                                          
 AS '$libdir/btree_gist', $function$gbt_int8_fetch$function$


 CREATE OR REPLACE FUNCTION public.gbt_time_fetch(internal) 
  RETURNS internal                                          
  LANGUAGE c                                                
  IMMUTABLE STRICT                                          
 AS '$libdir/btree_gist', $function$gbt_time_fetch$function$


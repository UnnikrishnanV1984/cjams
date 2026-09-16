 CREATE OR REPLACE FUNCTION public.gbt_ts_same(gbtreekey16, gbtreekey16, internal)
  RETURNS internal                                                                
  LANGUAGE c                                                                      
  IMMUTABLE STRICT                                                                
 AS '$libdir/btree_gist', $function$gbt_ts_same$function$                         


 CREATE OR REPLACE FUNCTION public.gbt_int8_same(gbtreekey16, gbtreekey16, internal)
  RETURNS internal                                                                  
  LANGUAGE c                                                                        
  IMMUTABLE STRICT                                                                  
 AS '$libdir/btree_gist', $function$gbt_int8_same$function$                         


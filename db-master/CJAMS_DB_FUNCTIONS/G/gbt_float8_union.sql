 CREATE OR REPLACE FUNCTION public.gbt_float8_union(internal, internal)
  RETURNS gbtreekey16                                                  
  LANGUAGE c                                                           
  IMMUTABLE STRICT                                                     
 AS '$libdir/btree_gist', $function$gbt_float8_union$function$         


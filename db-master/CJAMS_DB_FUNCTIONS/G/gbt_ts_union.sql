 CREATE OR REPLACE FUNCTION public.gbt_ts_union(internal, internal)
  RETURNS gbtreekey16                                              
  LANGUAGE c                                                       
  IMMUTABLE STRICT                                                 
 AS '$libdir/btree_gist', $function$gbt_ts_union$function$         


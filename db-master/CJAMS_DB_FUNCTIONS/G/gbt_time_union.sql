 CREATE OR REPLACE FUNCTION public.gbt_time_union(internal, internal)
  RETURNS gbtreekey16                                                
  LANGUAGE c                                                         
  IMMUTABLE STRICT                                                   
 AS '$libdir/btree_gist', $function$gbt_time_union$function$         


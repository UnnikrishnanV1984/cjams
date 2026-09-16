 CREATE OR REPLACE FUNCTION public.gbt_numeric_union(internal, internal)
  RETURNS gbtreekey_var                                                 
  LANGUAGE c                                                            
  IMMUTABLE STRICT                                                      
 AS '$libdir/btree_gist', $function$gbt_numeric_union$function$         


 CREATE OR REPLACE FUNCTION public.gbt_numeric_same(gbtreekey_var, gbtreekey_var, internal)
  RETURNS internal                                                                         
  LANGUAGE c                                                                               
  IMMUTABLE STRICT                                                                         
 AS '$libdir/btree_gist', $function$gbt_numeric_same$function$                             


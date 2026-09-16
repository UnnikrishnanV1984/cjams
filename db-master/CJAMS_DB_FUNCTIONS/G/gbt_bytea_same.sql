 CREATE OR REPLACE FUNCTION public.gbt_bytea_same(gbtreekey_var, gbtreekey_var, internal)
  RETURNS internal                                                                       
  LANGUAGE c                                                                             
  IMMUTABLE STRICT                                                                       
 AS '$libdir/btree_gist', $function$gbt_bytea_same$function$                             


 CREATE OR REPLACE FUNCTION public.gbt_bytea_penalty(internal, internal, internal)
  RETURNS internal                                                                
  LANGUAGE c                                                                      
  IMMUTABLE STRICT                                                                
 AS '$libdir/btree_gist', $function$gbt_bytea_penalty$function$                   


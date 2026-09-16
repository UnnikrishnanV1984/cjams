 CREATE OR REPLACE FUNCTION public.gbt_bytea_consistent(internal, bytea, smallint, oid, internal)
  RETURNS boolean                                                                                
  LANGUAGE c                                                                                     
  IMMUTABLE STRICT                                                                               
 AS '$libdir/btree_gist', $function$gbt_bytea_consistent$function$                               


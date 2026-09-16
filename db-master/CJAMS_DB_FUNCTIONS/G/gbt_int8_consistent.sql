 CREATE OR REPLACE FUNCTION public.gbt_int8_consistent(internal, bigint, smallint, oid, internal)
  RETURNS boolean                                                                                
  LANGUAGE c                                                                                     
  IMMUTABLE STRICT                                                                               
 AS '$libdir/btree_gist', $function$gbt_int8_consistent$function$                                


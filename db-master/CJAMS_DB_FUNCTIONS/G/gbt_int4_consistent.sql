 CREATE OR REPLACE FUNCTION public.gbt_int4_consistent(internal, integer, smallint, oid, internal)
  RETURNS boolean                                                                                 
  LANGUAGE c                                                                                      
  IMMUTABLE STRICT                                                                                
 AS '$libdir/btree_gist', $function$gbt_int4_consistent$function$                                 


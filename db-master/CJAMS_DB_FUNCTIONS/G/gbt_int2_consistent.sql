 CREATE OR REPLACE FUNCTION public.gbt_int2_consistent(internal, smallint, smallint, oid, internal)
  RETURNS boolean                                                                                  
  LANGUAGE c                                                                                       
  IMMUTABLE STRICT                                                                                 
 AS '$libdir/btree_gist', $function$gbt_int2_consistent$function$                                  


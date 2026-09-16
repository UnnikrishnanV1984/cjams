 CREATE OR REPLACE FUNCTION public.gbt_macad_consistent(internal, macaddr, smallint, oid, internal)
  RETURNS boolean                                                                                  
  LANGUAGE c                                                                                       
  IMMUTABLE STRICT                                                                                 
 AS '$libdir/btree_gist', $function$gbt_macad_consistent$function$                                 


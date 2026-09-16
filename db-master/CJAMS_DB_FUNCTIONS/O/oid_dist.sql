 CREATE OR REPLACE FUNCTION public.oid_dist(oid, oid) 
  RETURNS oid                                         
  LANGUAGE c                                          
  IMMUTABLE STRICT                                    
 AS '$libdir/btree_gist', $function$oid_dist$function$


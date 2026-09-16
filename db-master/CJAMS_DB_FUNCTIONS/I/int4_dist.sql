 CREATE OR REPLACE FUNCTION public.int4_dist(integer, integer)
  RETURNS integer                                             
  LANGUAGE c                                                  
  IMMUTABLE STRICT                                            
 AS '$libdir/btree_gist', $function$int4_dist$function$       


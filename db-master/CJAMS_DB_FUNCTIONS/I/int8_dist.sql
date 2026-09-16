 CREATE OR REPLACE FUNCTION public.int8_dist(bigint, bigint)
  RETURNS bigint                                            
  LANGUAGE c                                                
  IMMUTABLE STRICT                                          
 AS '$libdir/btree_gist', $function$int8_dist$function$     


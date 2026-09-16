 CREATE OR REPLACE FUNCTION public.float4_dist(real, real)
  RETURNS real                                            
  LANGUAGE c                                              
  IMMUTABLE STRICT                                        
 AS '$libdir/btree_gist', $function$float4_dist$function$ 


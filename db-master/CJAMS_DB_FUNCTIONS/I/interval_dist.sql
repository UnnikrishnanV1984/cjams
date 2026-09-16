 CREATE OR REPLACE FUNCTION public.interval_dist(interval, interval)
  RETURNS interval                                                  
  LANGUAGE c                                                        
  IMMUTABLE STRICT                                                  
 AS '$libdir/btree_gist', $function$interval_dist$function$         


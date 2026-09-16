 CREATE OR REPLACE FUNCTION public.time_dist(time without time zone, time without time zone)
  RETURNS interval                                                                          
  LANGUAGE c                                                                                
  IMMUTABLE STRICT                                                                          
 AS '$libdir/btree_gist', $function$time_dist$function$                                     


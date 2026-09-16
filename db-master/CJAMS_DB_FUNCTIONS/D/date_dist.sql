 CREATE OR REPLACE FUNCTION public.date_dist(date, date)
  RETURNS integer                                       
  LANGUAGE c                                            
  IMMUTABLE STRICT                                      
 AS '$libdir/btree_gist', $function$date_dist$function$ 


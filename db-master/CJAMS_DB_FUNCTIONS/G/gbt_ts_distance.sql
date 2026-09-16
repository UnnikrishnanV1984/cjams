 CREATE OR REPLACE FUNCTION public.gbt_ts_distance(internal, timestamp without time zone, smallint, oid, internal)
  RETURNS double precision                                                                                        
  LANGUAGE c                                                                                                      
  IMMUTABLE STRICT                                                                                                
 AS '$libdir/btree_gist', $function$gbt_ts_distance$function$                                                     


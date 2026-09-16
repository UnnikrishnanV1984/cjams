 CREATE OR REPLACE FUNCTION public.gbt_time_distance(internal, time without time zone, smallint, oid, internal)
  RETURNS double precision                                                                                     
  LANGUAGE c                                                                                                   
  IMMUTABLE STRICT                                                                                             
 AS '$libdir/btree_gist', $function$gbt_time_distance$function$                                                


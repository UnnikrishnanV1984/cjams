 CREATE OR REPLACE FUNCTION public.gbt_intv_distance(internal, interval, smallint, oid, internal)
  RETURNS double precision                                                                       
  LANGUAGE c                                                                                     
  IMMUTABLE STRICT                                                                               
 AS '$libdir/btree_gist', $function$gbt_intv_distance$function$                                  


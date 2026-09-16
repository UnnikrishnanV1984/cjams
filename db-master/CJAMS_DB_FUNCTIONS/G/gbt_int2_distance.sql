 CREATE OR REPLACE FUNCTION public.gbt_int2_distance(internal, smallint, smallint, oid, internal)
  RETURNS double precision                                                                       
  LANGUAGE c                                                                                     
  IMMUTABLE STRICT                                                                               
 AS '$libdir/btree_gist', $function$gbt_int2_distance$function$                                  


 CREATE OR REPLACE FUNCTION public.gbt_date_distance(internal, date, smallint, oid, internal)
  RETURNS double precision                                                                   
  LANGUAGE c                                                                                 
  IMMUTABLE STRICT                                                                           
 AS '$libdir/btree_gist', $function$gbt_date_distance$function$                              


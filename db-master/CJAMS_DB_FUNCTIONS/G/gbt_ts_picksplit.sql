 CREATE OR REPLACE FUNCTION public.gbt_ts_picksplit(internal, internal)
  RETURNS internal                                                     
  LANGUAGE c                                                           
  IMMUTABLE STRICT                                                     
 AS '$libdir/btree_gist', $function$gbt_ts_picksplit$function$         


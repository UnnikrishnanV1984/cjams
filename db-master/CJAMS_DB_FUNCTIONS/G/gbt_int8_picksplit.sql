 CREATE OR REPLACE FUNCTION public.gbt_int8_picksplit(internal, internal)
  RETURNS internal                                                       
  LANGUAGE c                                                             
  IMMUTABLE STRICT                                                       
 AS '$libdir/btree_gist', $function$gbt_int8_picksplit$function$         


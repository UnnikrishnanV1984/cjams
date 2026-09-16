 CREATE OR REPLACE FUNCTION public.gbt_float4_picksplit(internal, internal)
  RETURNS internal                                                         
  LANGUAGE c                                                               
  IMMUTABLE STRICT                                                         
 AS '$libdir/btree_gist', $function$gbt_float4_picksplit$function$         


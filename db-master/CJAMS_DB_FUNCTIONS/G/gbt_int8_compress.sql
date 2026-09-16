 CREATE OR REPLACE FUNCTION public.gbt_int8_compress(internal) 
  RETURNS internal                                             
  LANGUAGE c                                                   
  IMMUTABLE STRICT                                             
 AS '$libdir/btree_gist', $function$gbt_int8_compress$function$


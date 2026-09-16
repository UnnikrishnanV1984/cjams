 CREATE OR REPLACE FUNCTION public.gbt_int2_compress(internal) 
  RETURNS internal                                             
  LANGUAGE c                                                   
  IMMUTABLE STRICT                                             
 AS '$libdir/btree_gist', $function$gbt_int2_compress$function$


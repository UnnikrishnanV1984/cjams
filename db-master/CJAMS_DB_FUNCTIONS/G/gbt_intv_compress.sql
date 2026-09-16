 CREATE OR REPLACE FUNCTION public.gbt_intv_compress(internal) 
  RETURNS internal                                             
  LANGUAGE c                                                   
  IMMUTABLE STRICT                                             
 AS '$libdir/btree_gist', $function$gbt_intv_compress$function$


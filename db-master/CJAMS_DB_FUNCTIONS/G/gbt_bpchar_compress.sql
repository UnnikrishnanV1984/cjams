 CREATE OR REPLACE FUNCTION public.gbt_bpchar_compress(internal) 
  RETURNS internal                                               
  LANGUAGE c                                                     
  IMMUTABLE STRICT                                               
 AS '$libdir/btree_gist', $function$gbt_bpchar_compress$function$


 CREATE OR REPLACE FUNCTION public.gbt_inet_compress(internal) 
  RETURNS internal                                             
  LANGUAGE c                                                   
  IMMUTABLE STRICT                                             
 AS '$libdir/btree_gist', $function$gbt_inet_compress$function$


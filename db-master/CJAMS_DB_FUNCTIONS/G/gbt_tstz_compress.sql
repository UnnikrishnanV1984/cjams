 CREATE OR REPLACE FUNCTION public.gbt_tstz_compress(internal) 
  RETURNS internal                                             
  LANGUAGE c                                                   
  IMMUTABLE STRICT                                             
 AS '$libdir/btree_gist', $function$gbt_tstz_compress$function$


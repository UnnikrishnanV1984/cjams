 CREATE OR REPLACE FUNCTION public.gbt_date_compress(internal) 
  RETURNS internal                                             
  LANGUAGE c                                                   
  IMMUTABLE STRICT                                             
 AS '$libdir/btree_gist', $function$gbt_date_compress$function$


 CREATE OR REPLACE FUNCTION public.gbt_text_compress(internal) 
  RETURNS internal                                             
  LANGUAGE c                                                   
  IMMUTABLE STRICT                                             
 AS '$libdir/btree_gist', $function$gbt_text_compress$function$


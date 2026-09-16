 CREATE OR REPLACE FUNCTION public.gbt_bit_compress(internal) 
  RETURNS internal                                            
  LANGUAGE c                                                  
  IMMUTABLE STRICT                                            
 AS '$libdir/btree_gist', $function$gbt_bit_compress$function$


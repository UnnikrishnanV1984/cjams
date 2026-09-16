 CREATE OR REPLACE FUNCTION public.gbt_macad_compress(internal) 
  RETURNS internal                                              
  LANGUAGE c                                                    
  IMMUTABLE STRICT                                              
 AS '$libdir/btree_gist', $function$gbt_macad_compress$function$


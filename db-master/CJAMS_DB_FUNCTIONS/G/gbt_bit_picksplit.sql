 CREATE OR REPLACE FUNCTION public.gbt_bit_picksplit(internal, internal)
  RETURNS internal                                                      
  LANGUAGE c                                                            
  IMMUTABLE STRICT                                                      
 AS '$libdir/btree_gist', $function$gbt_bit_picksplit$function$         


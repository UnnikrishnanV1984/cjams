 CREATE OR REPLACE FUNCTION public.gbt_bit_consistent(internal, bit, smallint, oid, internal)
  RETURNS boolean                                                                            
  LANGUAGE c                                                                                 
  IMMUTABLE STRICT                                                                           
 AS '$libdir/btree_gist', $function$gbt_bit_consistent$function$                             


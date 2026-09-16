 CREATE OR REPLACE FUNCTION public.gbt_bpchar_consistent(internal, character, smallint, oid, internal)
  RETURNS boolean                                                                                     
  LANGUAGE c                                                                                          
  IMMUTABLE STRICT                                                                                    
 AS '$libdir/btree_gist', $function$gbt_bpchar_consistent$function$                                   


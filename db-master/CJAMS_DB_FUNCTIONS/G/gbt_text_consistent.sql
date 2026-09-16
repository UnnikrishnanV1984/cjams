 CREATE OR REPLACE FUNCTION public.gbt_text_consistent(internal, text, smallint, oid, internal)
  RETURNS boolean                                                                              
  LANGUAGE c                                                                                   
  IMMUTABLE STRICT                                                                             
 AS '$libdir/btree_gist', $function$gbt_text_consistent$function$                              


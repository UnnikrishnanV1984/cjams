 CREATE OR REPLACE FUNCTION public.gbt_numeric_penalty(internal, internal, internal)
  RETURNS internal                                                                  
  LANGUAGE c                                                                        
  IMMUTABLE STRICT                                                                  
 AS '$libdir/btree_gist', $function$gbt_numeric_penalty$function$                   


 CREATE OR REPLACE FUNCTION public.gbt_int4_penalty(internal, internal, internal)
  RETURNS internal                                                               
  LANGUAGE c                                                                     
  IMMUTABLE STRICT                                                               
 AS '$libdir/btree_gist', $function$gbt_int4_penalty$function$                   


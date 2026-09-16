 CREATE OR REPLACE FUNCTION public.gbtreekey32_out(gbtreekey32)
  RETURNS cstring                                              
  LANGUAGE c                                                   
  IMMUTABLE STRICT                                             
 AS '$libdir/btree_gist', $function$gbtreekey_out$function$    


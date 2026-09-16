 CREATE OR REPLACE FUNCTION public.gbtreekey16_in(cstring)
  RETURNS gbtreekey16                                     
  LANGUAGE c                                              
  IMMUTABLE STRICT                                        
 AS '$libdir/btree_gist', $function$gbtreekey_in$function$


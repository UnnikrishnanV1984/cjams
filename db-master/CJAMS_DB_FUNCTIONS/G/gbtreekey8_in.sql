 CREATE OR REPLACE FUNCTION public.gbtreekey8_in(cstring) 
  RETURNS gbtreekey8                                      
  LANGUAGE c                                              
  IMMUTABLE STRICT                                        
 AS '$libdir/btree_gist', $function$gbtreekey_in$function$


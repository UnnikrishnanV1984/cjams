 CREATE OR REPLACE FUNCTION public.gbtreekey_var_in(cstring)
  RETURNS gbtreekey_var                                     
  LANGUAGE c                                                
  IMMUTABLE STRICT                                          
 AS '$libdir/btree_gist', $function$gbtreekey_in$function$  


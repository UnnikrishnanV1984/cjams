 CREATE OR REPLACE FUNCTION public.gbt_cash_union(internal, internal)
  RETURNS gbtreekey16                                                
  LANGUAGE c                                                         
  IMMUTABLE STRICT                                                   
 AS '$libdir/btree_gist', $function$gbt_cash_union$function$         


 CREATE OR REPLACE FUNCTION public.gbt_date_union(internal, internal)
  RETURNS gbtreekey8                                                 
  LANGUAGE c                                                         
  IMMUTABLE STRICT                                                   
 AS '$libdir/btree_gist', $function$gbt_date_union$function$         


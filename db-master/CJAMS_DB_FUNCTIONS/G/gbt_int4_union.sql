 CREATE OR REPLACE FUNCTION public.gbt_int4_union(internal, internal)
  RETURNS gbtreekey8                                                 
  LANGUAGE c                                                         
  IMMUTABLE STRICT                                                   
 AS '$libdir/btree_gist', $function$gbt_int4_union$function$         


 CREATE OR REPLACE FUNCTION public.gbt_float4_union(internal, internal)
  RETURNS gbtreekey8                                                   
  LANGUAGE c                                                           
  IMMUTABLE STRICT                                                     
 AS '$libdir/btree_gist', $function$gbt_float4_union$function$         


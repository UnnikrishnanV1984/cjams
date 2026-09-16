 CREATE OR REPLACE FUNCTION public.cash_dist(money, money)
  RETURNS money                                           
  LANGUAGE c                                              
  IMMUTABLE STRICT                                        
 AS '$libdir/btree_gist', $function$cash_dist$function$   


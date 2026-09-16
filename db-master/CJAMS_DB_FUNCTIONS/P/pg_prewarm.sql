 CREATE OR REPLACE FUNCTION public.pg_prewarm(regclass, mode text DEFAULT 'buffer'::text, fork text DEFAULT 'main'::text, first_block bigint DEFAULT NULL::bigint, last_block bigint DEFAULT NULL::bigint)
  RETURNS bigint                                                                                                                                                                                          
  LANGUAGE c                                                                                                                                                                                              
  PARALLEL SAFE                                                                                                                                                                                           
 AS '$libdir/pg_prewarm', $function$pg_prewarm$function$                                                                                                                                                  


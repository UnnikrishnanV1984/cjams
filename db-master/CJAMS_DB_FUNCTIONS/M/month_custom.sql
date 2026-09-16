 CREATE OR REPLACE FUNCTION public.month_custom(timestamp without time zone)
  RETURNS integer                                                           
  LANGUAGE sql                                                              
  IMMUTABLE                                                                 
 AS $function$                                                              
       SELECT EXTRACT(MONTH FROM $1)::INTEGER;                              
 $function$                                                                 


 CREATE OR REPLACE FUNCTION public.json_check(obj json)
  RETURNS bigint                                       
  LANGUAGE plpgsql                                     
 AS $function$                                         
 BEGIN                                                 
  RAISE NOTICE '%',obj ->> 'firstname';                
                                                       
   RAISE NOTICE '%','3333333333333';                   
   RETURN 5;                                           
 END;                                                  
 $function$                                            


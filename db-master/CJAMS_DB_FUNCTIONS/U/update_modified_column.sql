 CREATE OR REPLACE FUNCTION public.update_modified_column()
  RETURNS trigger                                          
  LANGUAGE plpgsql                                         
 AS $function$                                           
 begin                                                   
    new."updatedon"  := now();                           
 return new;                                             
 end;                                                    
 $function$                                                


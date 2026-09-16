 CREATE OR REPLACE FUNCTION public.update_effectivedate_column()
  RETURNS trigger                                               
  LANGUAGE plpgsql                                              
 AS $function$                                                
 begin                                                        
    IF new.activeflag = 1 THEN                                
       new."effectivedate"  := now();                         
       new."expirationdate"  := null;                         
    END IF;                                                   
 return new;                                                  
 end;                                                         
 $function$                                                     


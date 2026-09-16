 CREATE OR REPLACE FUNCTION public.cdprelimconsentbs(i_intakenumber character varying)      
  RETURNS TABLE(persons text, provider_name character varying)                              
  LANGUAGE plpgsql                                                                          
 AS $function$                                                                            
    BEGIN                                                                                 
         RETURN QUERY                                                                     
 (select                                                                                  
       da.jsondata->>'persons' as persons,                                                
                 cast(pr.providername as character varying)  as provider_name             
        from                                                                              
        intakedastaging da                                                                
            left join placement pl on da.intakenumber =pl.intakenumber and pl.activeflag=1
            left JOIN provider pr ON pl.providerid = pr.providerid AND pr.activeflag=1    
            where  da.intakenumber = i_intakenumber   limit 1) ;                          
            end;                                                                          
   $function$                                                                               


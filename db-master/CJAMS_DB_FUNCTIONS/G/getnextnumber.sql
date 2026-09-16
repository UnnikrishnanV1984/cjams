 CREATE OR REPLACE FUNCTION public.getnextnumber(app character varying)             
  RETURNS bigint                                                                    
  LANGUAGE plpgsql                                                                  
 AS $function$                                                                      
                                                                                    
 DECLARE                                                                            
         nextno bigint;                                                             
 BEGIN                                                                              
                                                                                    
 SELECT next_number into nextno FROM nextnumber WHERE                               
                         lower(nextnumber.application)=lower(app) AND               
                         nextnumber.fiscalyear = COALESCE(nextnumber.fiscalyear, 0);
                                                                                    
 UPDATE nextnumber                                                                  
     SET next_number=(next_number+1)                                                
         WHERE lower(nextnumber.application)=lower(app) AND                         
               nextnumber.fiscalyear = COALESCE(nextnumber.fiscalyear, 0);          
                                                                                    
 RETURN nextno;                                                                     
 END;                                                                               
                                                                                    
                                                                                    
 $function$  

 CREATE OR REPLACE FUNCTION public.listlanguage(v_languagename character varying)                      
  RETURNS TABLE(ref_key character varying, value_text character varying, description character varying)
  LANGUAGE plpgsql                                                                                     
 AS $function$                                                                                         
                                                                                                       
 DECLARE                                                                                               
                                                                                                       
                                                                                                       
                                                                                                       
 BEGIN                                                                                                 
                                                                                                       
         RETURN QUERY                                                                                  
         SELECT rv.ref_key,rv.value_text,rv.description                                                
 FROM referencevalues rv                                                                               
 WHERE rv.value_text ILIKE v_languagename ||'%'                                                        
 AND rv.referencetypeid = 27                                                                           
 ORDER BY rv.value_text LIMIT 25;                                                                      
                                                                                                       
 END;                                                                                                  
                                                                                                       
 $function$                                                                                            


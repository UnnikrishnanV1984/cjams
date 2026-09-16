 CREATE OR REPLACE FUNCTION public.getrequestlog(v_tokenid character varying)            
  RETURNS json                                                                           
  LANGUAGE plpgsql                                                                       
 AS $function$                                                                         
                                                                                       
 DECLARE                                                                               
                                                                                       
 requestlog json;                                                                      
 v_insertedon timestamp;                                                               
 BEGIN                                                                                 
                                                                                       
 SELECT max(insertedon) INTO v_insertedon FROM welfarelog                              
 WHERE  tokenid = v_tokenid AND   request not like '%supportlog/add' ;                 
                                                                                       
 SELECT array_to_json(array_agg(t)) into requestlog                                    
 FROM (SELECT DISTINCT request, requestdata FROM welfarelog WHERE  tokenid = v_tokenid 
       AND insertedon  >= (v_insertedon::timestamp - 100 * INTERVAL '1 second' )       
           -- AND insertedon  <=   v_insertedon                                        
       ) t;                                                                            
                                                                                       
 RETURN requestlog;                                                                    
                                                                                       
 END;                                                                                  
                                                                                       
 $function$                                                                              

